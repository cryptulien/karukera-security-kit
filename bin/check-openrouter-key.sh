#!/usr/bin/env sh
# Sonde agent-safe : dit si une clé OpenRouter est déposée, sans jamais l’imprimer.
# Usage : sh bin/check-openrouter-key.sh
#         sh bin/check-openrouter-key.sh --live
# Sortie : une ligne status=…  exit 0 si present, 1 sinon.

set -eu

live=0
for arg in "$@"; do
  case "$arg" in
    --live) live=1 ;;
    -h|--help)
      echo "usage: sh bin/check-openrouter-key.sh [--live]"
      exit 0
      ;;
    *)
      echo "status=error reason=unknown-arg" >&2
      exit 2
      ;;
  esac
done

root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
cd "$root"

value=""
source=""

read_env_file() {
  file=$1
  [ -f "$file" ] || return 1
  # Une seule variable, pas de source shell (un .env n’est pas un script).
  line=$(grep -E '^OPENROUTER_API_KEY=' "$file" | tail -n 1 || true)
  [ -n "$line" ] || return 1
  value=${line#OPENROUTER_API_KEY=}
  value=$(printf '%s' "$value" | tr -d '\r')
  case "$value" in
    \"*\") value=${value#\"}; value=${value%\"} ;;
    \'*\') value=${value#\'}; value=${value%\'} ;;
  esac
  return 0
}

read_json_file() {
  file=$1
  [ -f "$file" ] || return 1
  if command -v python3 >/dev/null 2>&1; then
    value=$(python3 -c '
import json, sys
try:
    data = json.load(open(sys.argv[1], encoding="utf-8"))
except Exception:
    sys.exit(1)
key = data.get("api_key") or ""
if not isinstance(key, str) or not key:
    sys.exit(1)
print(key)
' "$file") || return 1
    return 0
  fi
  line=$(grep -E '"api_key"[[:space:]]*:' "$file" | head -n 1 || true)
  [ -n "$line" ] || return 1
  value=$(printf '%s' "$line" | sed -n 's/.*"api_key"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
  [ -n "$value" ] || return 1
}

if [ -n "${OPENROUTER_API_KEY:-}" ]; then
  value=$OPENROUTER_API_KEY
  source=env
elif read_env_file .env; then
  source=.env
elif read_json_file config/openrouter.json; then
  source=config/openrouter.json
else
  echo "status=missing"
  echo "next=GUIDES/deposit-key.md"
  exit 1
fi

is_placeholder() {
  v=$1
  case "$v" in
    ""|changeme|CHANGE_ME|changeme-me|your-key|your-key-here|YOUR_KEY|REPLACE_ME|TODO|xxx|XXX|sk-or-|sk-or-v1-|sk-or-…|sk-or-v1-…|"<"*|">"* ) return 0 ;;
  esac
  return 1
}

if [ -z "$value" ]; then
  echo "status=empty source=$source"
  echo "next=GUIDES/deposit-key.md"
  unset value
  exit 1
fi

if is_placeholder "$value"; then
  echo "status=placeholder source=$source"
  echo "next=GUIDES/deposit-key.md"
  unset value
  exit 1
fi

prefix=other
case "$value" in
  sk-or-*) prefix=sk-or- ;;
esac
len=${#value}

if [ "$len" -lt 20 ]; then
  echo "status=placeholder source=$source prefix=$prefix length=$len"
  echo "next=GUIDES/deposit-key.md"
  unset value
  exit 1
fi

live_state=skipped
if [ "$live" -eq 1 ]; then
  if command -v curl >/dev/null 2>&1; then
    code=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 15 \
      -H "Authorization: Bearer ${value}" \
      https://openrouter.ai/api/v1/key || printf '000')
    case "$code" in
      200) live_state=ok ;;
      401|403) live_state=$code ;;
      *) live_state=$code ;;
    esac
  else
    live_state=no-curl
  fi
fi

unset value

if [ "$live" -eq 1 ]; then
  echo "status=present source=$source prefix=$prefix length=$len live=$live_state"
  case "$live_state" in
    ok) exit 0 ;;
    skipped|no-curl) exit 0 ;;
    *)
      echo "next=GUIDES/deposit-key.md"
      exit 1
      ;;
  esac
fi

echo "status=present source=$source prefix=$prefix length=$len"
exit 0

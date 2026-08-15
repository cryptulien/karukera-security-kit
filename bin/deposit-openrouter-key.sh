#!/usr/bin/env sh
# Dépose OPENROUTER_API_KEY dans .env depuis un terminal local.
# Humain uniquement. Jamais via un LLM, jamais en argument, jamais par pipe.
# Usage : sh bin/deposit-openrouter-key.sh

set -eu

restore_tty() {
  if [ -t 0 ]; then
    stty echo 2>/dev/null || true
  fi
}
trap restore_tty EXIT INT TERM HUP

if [ "$#" -gt 0 ]; then
  echo "Refuse : ne passe jamais la clé en argument (historique, ps)." >&2
  echo "Relance sans argument. Le script la demandera en silencieux." >&2
  exit 2
fi

if [ ! -t 0 ]; then
  echo "Refuse : ce script lit uniquement depuis un terminal (TTY)." >&2
  echo "Ouvre un terminal local, hors chat LLM, puis relance." >&2
  echo "Procédure : GUIDES/deposit-key.md" >&2
  exit 2
fi

root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
cd "$root"

umask 077

if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env
    echo "Créé .env depuis .env.example" >&2
  else
    printf 'OPENROUTER_API_KEY=\n' > .env
    echo "Créé .env minimal" >&2
  fi
fi

printf 'Colle la clé OpenRouter (invisible), puis Entrée : ' >&2
stty -echo
IFS= read -r key || true
stty echo
printf '\n' >&2

key=$(printf '%s' "$key" | tr -d '\r\n')

if [ -z "$key" ]; then
  echo "Refuse : clé vide." >&2
  exit 1
fi

case "$key" in
  sk-or-?*) ;;
  *)
    echo "Refuse : une clé OpenRouter commence par sk-or-." >&2
    unset key
    exit 1
    ;;
esac

len=${#key}
if [ "$len" -lt 20 ]; then
  echo "Refuse : clé trop courte (placeholder)." >&2
  unset key
  exit 1
fi

tmp=$(mktemp "${TMPDIR:-/tmp}/karukera-or.XXXXXX")
OPENROUTER_API_KEY=$key awk '
  BEGIN { done = 0 }
  /^OPENROUTER_API_KEY=/ {
    print "OPENROUTER_API_KEY=" ENVIRON["OPENROUTER_API_KEY"]
    done = 1
    next
  }
  { print }
  END {
    if (!done) print "OPENROUTER_API_KEY=" ENVIRON["OPENROUTER_API_KEY"]
  }
' .env > "$tmp"
mv "$tmp" .env
chmod 600 .env
unset key
unset OPENROUTER_API_KEY

echo "status=present source=.env prefix=sk-or- length=$len mode=600"
echo "La clé n’a pas été affichée. Dis à l’agent « clé déposée » — ne la recopie pas dans le chat."
echo "Vérif agent : sh bin/check-openrouter-key.sh"

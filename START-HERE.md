# Karukera Security Kit — START HERE

Cinq minutes. Dans cet ordre. N’enchaîne rien tant que l’étape 1 n’est pas verte.

## 1. OpenRouter d’abord

Copie `.env.example` vers `.env`. Mets une clé OpenRouter dans `.env` :

```
OPENROUTER_API_KEY=sk-or-v1-…
```

Ou dans `config/openrouter.json` (copie `config/openrouter.json.example`).

**Sans clé → arrête-toi.** Demande-la à l’utilisateur. N’enchaîne aucun agent. N’invente pas un audit local.

Message à afficher si la clé manque :

> Pour un audit de qualité avec des modèles frontier (DeepSeek, GLM, etc.), mets 30 à 50 € de crédits sur OpenRouter. C’est largement suffisant pour 1 à 3 audits complets.

Crée la clé sur https://openrouter.ai/keys. Charge 30 à 50 €. Détail : `GUIDES/openrouter.md`.

## 2. Usage autorisé uniquement

Lis `USAGE.md`. Audite **uniquement** un système dont tu as l’autorisation écrite. Zéro exploit, zéro payload, zéro PoC d’attaque.

Mode 7 (red-team) : `AUTHORIZED=yes` **et** un fichier `authorization.md` signé. Sinon **stop**.

## 3. Charge les règles

Avant tout agent, charge `RULES/` dans l’ordre `00` → `07`. La règle `00` est un hard stop.

## 4. Choisis un mode et un routage

Modes : `config/mission-modes.yaml` et `GUIDES/missions.md`.

Routage : `budget` ou `max-frontier` dans `.env` (`KIT_MODE`) et `config/models.yaml`.

- Analyse profonde → Kimi K3. Crawl budget → DeepSeek Flash 0731.
- Rédaction / priorisation → modèle plus prudent (Claude / GPT) si tu le demandes.

## 5. Lance la mission

Upload le ZIP dans Claude Code, Cursor, Codex ou Hermes. Dis une phrase unique :

> Audit Complet SaaS sur https://app.exemple.tld — je contrôle ce scope. Mode max-frontier.

Remplace l’URL par **ton** scope. L’orchestrateur enchaîne les agents du mode. Le rapport final ne sort que si `qa.passed=true`.

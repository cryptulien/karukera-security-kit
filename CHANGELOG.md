# Journal des versions

## 1.0.2 — 2026-08-15

- Flux produit : projet chez toi, profondeur, approches extérieur / code / intérieur, accès optionnels, rapports + preuves, tickets avec prompt à coller (`GUIDES/postures.md`, `TEMPLATES/fix-ticket.md`).
- OpenRouter justifié par le refus fréquent des modèles hôtes (Claude, Codex, etc.), plus seulement par la qualité.
- Spécialiste `code-source`. Accès utilisateurs hors chat (`TEMPLATES/accounts.local.md`).
- Orchestrateur : accueil en langue produit, puis mapping vers les modes. 11 écrit les tickets.

## 1.0.1 — 2026-08-15

- Dépôt de la clé OpenRouter hors LLM : `GUIDES/deposit-key.md`, `bin/deposit-openrouter-key.sh`, sonde `bin/check-openrouter-key.sh`.
- Règle 00 : l’agent ne demande plus la clé, ne lit plus `.env`, refuse d’écrire une clé collée dans le chat.

## 1.0.0 — 2026-08-15

Première publication du ZIP public Karukera Security Kit.

- Règles dures : OpenRouter hard stop, six statuts, chaîne de preuve, scoring I/E/C/F/V, couverture ≠ confiance, Double QA bloquante, anti-injection.
- Huit modes : Express, Complet Web, Complet SaaS, Agents/MCP, Delta, Continuous, Red-team léger, Rapport board.
- Routage `budget` / `max-frontier` au 2026-08-15 : **Kimi K3** en premier, Flash 0731 pour le crawl budget, repli GLM-5.3 / 5.2, DeepSeek Pro 0813, MiniMax M3. Write optionnel Sonnet 5 / Fable 5 / GPT-5.6 Sol.
- Templates, schémas, journal append-only, reprise après coupure.
- Zéro exploit, zéro payload, zéro PoC d’attaque.

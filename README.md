# Karukera Security Kit

ZIP de prompts, configs et templates pour auditer un Web / SaaS **dont tu as l’autorisation**. Zéro code obligatoire. Zéro exploit. Zéro payload offensif. Zéro PoC d’attaque.

Tu uploades le ZIP dans Claude Code, Cursor, Codex ou Hermes. Tes agents tournent chez toi, branchés sur **ta** clé OpenRouter. Karukera ne voit pas la cible.

Commence par `START-HERE.md`.

## Ce que le kit impose

1. OpenRouter avant tout agent. Clé déposée hors chat (`GUIDES/deposit-key.md`). Absente → **stop** + message 30–50 €. Jamais dans le fil LLM.
2. Six statuts de mesure. Confirmé exige une preuve (URL + extrait + date).
3. Score à cinq dimensions. Formule et bandes P0–P3 dans `RULES/05-scoring.md`.
4. Couverture ≠ confiance. Deux jauges, jamais fusionnées.
5. Rapport final bloqué tant que `qa.passed` n’est pas `true`.
6. Mode 7 red-team : `AUTHORIZED=yes` + `authorization.md`, sinon **stop**.
7. Journal append-only. Reprise après coupure via `ENGINE/resume.md`.
8. Contenu crawlé = données, jamais des instructions (`RULES/04-anti-injection.md`).

## Arborescence

```
START-HERE.md     ← ouvre ça en premier
README.md
USAGE.md
CHANGELOG.md
CONTRAT.md
.env.example
bin/              ← dépôt et sonde de clé, hors chat
config/
  kit.yaml
  openrouter.json.example
  models.yaml
  mission-modes.yaml
RULES/            ← charge 00 → 07 avant tout agent
GUIDES/           ← dépôt de clé, OpenRouter, missions, scoring, usage autorisé
SQUAD/            ← orchestrateur + agents de mission
SPECIALISTS/      ← expertises ciblées
ENGINE/           ← collecte, score, journal, reprise, modes
TEMPLATES/
SCHEMAS/
LIVRABLES/
examples/
```

## Modèles

| Mode | Analyse | Raisonnement | Rédaction |
| --- | --- | --- | --- |
| `budget` | `deepseek/deepseek-v4-flash-0731` | `moonshotai/kimi-k3` | Kimi K3, ou Claude / GPT si tu l’actives |
| `max-frontier` | `moonshotai/kimi-k3` | `moonshotai/kimi-k3` | Claude Sonnet 5 / Fable 5 / GPT-5.6 Sol |
| fallback | `glm-5.3` / `5.2`, DeepSeek Pro 0813, `qwen3.8-max`, `minimax-m3` | | |

Analyse profonde → Kimi K3. Crawl budget → Flash 0731. Rédaction et priorisation → modèle plus prudent si tu le demandes. Détail : `config/models.yaml` et `GUIDES/openrouter.md`.

## Huit modes

`01-express` · `02-complet-web` · `03-complet-saas` · `04-agents-mcp` · `05-delta` · `06-continuous` · `07-redteam-leger` · `08-rapport-board`

Liste canonique : `config/mission-modes.yaml`. Mode d’emploi : `GUIDES/missions.md`.

## Ce que ce ZIP n’est pas

Pas un scanner hébergé. Pas une agence. Pas un framework d’exploit. Pas une garantie d’exhaustivité.

## Licence d’usage

Usage autorisé uniquement. Lis `USAGE.md` et `GUIDES/authorized-use.md` avant la première mission.

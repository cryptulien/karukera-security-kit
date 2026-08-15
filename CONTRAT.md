# Contrat du kit — tous les auteurs s’y tiennent

ZIP de prompts + configs + templates. **Zéro code obligatoire.** Zéro exploit, zéro payload offensif, zéro PoC d’attaque.

## Arborescence (cible ~110–125 fichiers)

```
START-HERE.md  README.md  USAGE.md  CHANGELOG.md  CONTRAT.md  .env.example
bin/deposit-openrouter-key.sh  bin/check-openrouter-key.sh
config/kit.yaml  config/openrouter.json.example  config/models.yaml  config/mission-modes.yaml
GUIDES/deposit-key.md  GUIDES/postures.md
RULES/00-openrouter.md … 07-double-qa.md
SQUAD/00-orchestrator.md + 00-orchestrator.checklist.md … 11-rapport-final.*
SPECIALISTS/<slug>/<slug>.md + <slug>.checklist.md
ENGINE/collect.md score.md projects.md journal.md resume.md
ENGINE/modes/01-express.md … 08-rapport-board.md
TEMPLATES/  SCHEMAS/  LIVRABLES/  GUIDES/  examples/demo-journal/
```

## Règles dures

1. OpenRouter : avant tout agent, clé déposée hors chat. Raison dite à l’opérateur : beaucoup de modèles (Claude, Codex, etc.) refusent l’audit. L’agent sonde via `bin/check-openrouter-key.sh`. Absente → STOP + message canonique + `GUIDES/deposit-key.md`.
2. Statuts : Confirmé / Probable / Hypothèse / Non testé / Mitigé / Faux positif.
3. Confirmé ⇒ preuve (URL ou `path:ligne` + extrait + date).
4. Score : I, E, C, F, V (1–5). `priority = 10*(0.30I+0.25E+0.20C+0.15V) - 2*F`. Bandes ≥35 P0, 25–34 P1, 15–24 P2, <15 P3. C plafonné par le statut.
5. Couverture ≠ confiance (deux jauges).
6. Rapport final bloqué sans `qa.passed=true`. Tickets de correctif avec prompt ensuite.
7. Mode 7 red-team : `AUTHORIZED=yes` + `authorization.md` sinon STOP.
8. Journal append-only. Reprise après coupure via ENGINE/resume.md.
9. Accueil produit avant les ids de mode : projet, profondeur, approches, accès. Mots de passe hors chat.

## Contrat d’un agent (frontmatter + sections)

Chaque fichier agent (squad ou spécialiste) commence par :

```yaml
---
id: squad-01-surface-mapper
role: squad | specialist
reads: [RULES/*, ENGINE/journal.md, brief]
writes: [journal/findings, journal/evidence]
forbids: [inventer une preuve, sortir du scope, produire un exploit]
---
```

Puis : Mission · Checklist déclenchée · Méthode · Sorties (schéma finding) · Pièges · Exemple de finding **fictif**.

## Modèles

budget: deepseek-v4-flash-0731 (crawl), kimi-k3 (raisonnement)
max-frontier: kimi-k3, rédaction optionnelle Sonnet 5 / Fable 5 / GPT-5.6 Sol
fallback: glm-5.3 / 5.2, DeepSeek Pro 0813, Qwen3.8 Max, MiniMax M3
Analyse / cyber → Kimi K3. Rédaction/priorisation → safe si voulu.

## Interdit

Pas de TBD, TODO, « remplir plus tard ». Pas de code d’exploit. Français. Impératif.

# Livrables — comment un agent les remplit

Les fichiers de ce dossier sont des **modèles de fond**. L’agent n’écrit pas ici pour un client. Il copie, puis remplit dans le journal du projet.

```
kit/TEMPLATES/*          ← forme (champs, sections)
kit/LIVRABLES/*          ← intention (à qui ça parle, quoi décider)
projects/<slug>/…        ← seule sortie client
```

Sans `projects/<slug>/` ouvert (`ENGINE/projects.md`), tu n’écris aucun livrable.

## Chaîne obligatoire

1. `RULES/` chargées. `sh bin/check-openrouter-key.sh` → `status=present`.
2. Mode choisi. Collecte et findings dans `journal/` (`ENGINE/journal.md`).
3. Scores (`ENGINE/score.md`). Deux jauges renseignées dans `project.yaml`.
4. `journal/qa/signoff.md` avec `qa.passed=true`.
5. **Alors seulement** : rapports et livrables.

Mode 8 = board uniquement, zéro test. Mode 5/6 = `delta-compare` en plus. Un refus QA = pas de livrable « final ». Un exec brouillon interne, s’il existe, porte en tête `BROUILLON — QA non signée` et ne sort pas du dossier `journal/`.

## Où écrire quoi

| Livrable | Template | Destination client | Condition |
| --- | --- | --- | --- |
| Rapport exécutif | `TEMPLATES/report-exec.md` | `reports/exec.md` | QA passée |
| Rapport implémentation | `TEMPLATES/report-impl.md` | `reports/impl.md` | QA passée |
| Rapport board | `TEMPLATES/report-board.md` | `reports/board.md` | Mode 8 + QA passée |
| Audit stratégique | `LIVRABLES/audit-strategique.md` (fond) + exec | `livrables/audit-strategique.md` | QA passée, modes 2/3/4/7 |
| Plan d’implémentation | `LIVRABLES/plan-implementation.md` | `livrables/plan-implementation.md` | QA passée |
| Tickets + prompts | `TEMPLATES/fix-ticket.md` | `livrables/tickets/TICKET-NNN.md` | QA passée, un par Confirmé / Probable P0–P1 |
| Checklist | `TEMPLATES/checklist-actions.md` | `livrables/checklist-actions.md` | QA passée |
| Delta | `TEMPLATES/delta-compare.md` | `livrables/delta-compare.md` | Mode 5 ou 6 |
| Modèle de menace | `TEMPLATES/threat-model.md` | `journal/threat-model.md` | Après collecte, avant QA |

Les `.txt` (`llms-security.txt`, `security-robots.txt`) ne sont pas des livrables d’audit. Ce sont des fichiers que le **client** peut publier. Tu peux les annexer tels quels, non remplis avec un faux contact.

## Méthode de remplissage

1. Lis **tous** les `journal/findings/*.md` et l’index des preuves. N’ouvre pas le web.
2. Recalcule mentalement (ou sur brouillon) les priority des P0/P1. Un écart avec la fiche → STOP, renvoyer à `score` + QA, ne « corrige » pas dans le rapport.
3. Remplis les compteurs de bandes. Les Faux positif hors totaux actifs. Les Mitigé dans leur section.
4. Chaque phrase de constat cite un `F-NNN` ou une précondition manquante. Sinon tu la supprimes.
5. Owners, dates de correctif, montants : seulement s’ils sont dans le brief. Sinon `à nommer par le client` / `à dater par le client`.
6. Une entrée `action: report` liste les chemins écrits.

## Qui lit quoi

- **Founder / CISO** : `audit-strategique.md` + `reports/exec.md`. Décisions, pas la liste des en-têtes.
- **Équipe qui corrige** : `livrables/tickets/` (prompt à coller) + `plan-implementation.md` + `reports/impl.md` + checklist.
- **Board / investisseur** : `reports/board.md` uniquement, mode 8.
- **Passe suivante** : journal + snapshot + delta. Pas le board.

## Interdits

- Livrer un board « adouci » qui omet un P0 Confirmé.
- Remplir un contact, un chiffre d’amende, un témoignage.
- Recopier `examples/demo-*` en changeant juste le nom du client.
- Produire un livrable pendant que la collecte tourne.

## Exemple fictif

`examples/demo-report-board.md` + `examples/demo-journal/` montrent la forme remplie. Tout y est étiqueté **fictif**.

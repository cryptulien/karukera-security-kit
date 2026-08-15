# Journal — append-only

Le journal est la mémoire du projet. On ajoute. On ne réécrit pas le passé. On ne détruit rien.

Lis aussi `RULES/02-evidence-chain.md`. Schémas : `SCHEMAS/journal.schema.json`, `SCHEMAS/finding.schema.json`, `SCHEMAS/evidence.schema.json`.

---

## Emplacement

```
projects/<slug>/journal/
  entries/          # registre : une file, append-only strict
  findings/         # projection courante de chaque constat
  evidence/         # preuves, append-only strict
  qa/signoff.md
  surface.md
  apis.md
  threat-model.md
  coverage.md
```

Les templates : `TEMPLATES/journal-entry.md`, `finding.md`, `evidence.md`, `qa-signoff.md`, `threat-model.md`.

## Append-only — règles dures

1. **`entries/`** : créer un fichier, jamais le modifier, jamais le supprimer. Une erreur se corrige par une **nouvelle** entrée qui référence l’ancienne et dit quoi ignorer.
2. **`evidence/`** : idem. Une preuve incomplète → nouvelle preuve `E-00N`, liée au même finding. On ne « nettoie » pas l’extrait après coup.
3. **`findings/`** : seul endroit où une mise à jour sur place est permise, et seulement pour : `status`, I/E/C/F/V, `priority`, `band`, liste `evidence`, `notes`. Chaque mise à jour **exige** une entrée dans `entries/` qui cite l’id, l’ancien statut, le nouveau, la raison.
4. Interdit : changer le titre pour masquer un constat, recycler un id, effacer un Faux positif (on le garde, statut à jour).
5. Interdit : réécrire `qa/signoff.md` pour passer `passed` à `true` sans nouvelle revue. Un refus reste. Une nouvelle passe QA = nouveau fichier `qa/signoff-YYYY-MM-DD.md` + le `signoff.md` courant pointe vers la dernière décision. L’ancien fichier reste.

`surface.md`, `apis.md`, `coverage.md`, `threat-model.md` sont des projections : tu peux les régénérer, mais tu consigne l’événement dans `entries/`.

## Une entrée

Fichier : `journal/entries/<YYYY-MM-DDTHHMMSSZ>-<agent>-<action>.md`

Champs minimum (frontmatter) :

- `id` : `J-<YYYYMMDD>-<nnn>`
- `ts` : ISO-8601 UTC
- `agent` : id d’agent (`squad-01-surface-mapper`, `specialist-saas-multitenant`, `human`)
- `action` : `open` | `collect` | `find` | `score` | `status-change` | `qa` | `report` | `resume` | `snapshot` | `close` | `note`
- `reads` : chemins lus
- `writes` : chemins créés ou projections mises à jour
- `mode` : mode courant

Corps : ce qui s’est passé, en faits. Pas de payload. Pas de secret en clair.

## Un finding

Un fichier `journal/findings/F-NNN-slug.md` conforme à `TEMPLATES/finding.md`.

- `id` unique dans le projet.
- `status` ∈ Confirmé, Probable, Hypothèse, Non testé, Mitigé, Faux positif.
- Confirmé ⇒ au moins une preuve avec `url` + `excerpt` + `date`.
- I, E, C, F, V entiers 1–5 ; C plafonné (`ENGINE/score.md`).
- `priority` et `band` calculés, pas devinés.
- `fictif: true` sur tout exemple du kit et tout constat hors cible réelle.
- Tableau `evidence` : ids `E-NNN`, pas d’extrait inventé dans la fiche si la preuve n’existe pas.

Création = entrée `action: find`. Rescore = entrée `action: score`. Changement de statut = `action: status-change`.

## Une preuve

Un fichier `journal/evidence/E-NNN-slug.md` conforme à `TEMPLATES/evidence.md`.

- `url` ou surface nommée (ex. `cookie:session` sur `https://app.example`).
- `excerpt` : texte réellement vu, tronqué. Masque les secrets (6 caractères + `…`).
- `date` : jour de l’observation (UTC).
- `method` : `GET`, `HEAD`, `OPTIONS`, `lecture-js`, `lecture-header`, `compte-test-documenté`. Rien d’autre sans le brief.
- `finding_ids` : liste des findings qui s’appuient dessus.

Une preuve peut servir à plusieurs findings. Un Confirmé sans preuve liée est une faute : l’agent QA le rejette.

## Cycle de vie d’un constat

```
Non testé ──► Hypothèse ──► Probable ──► Confirmé ──► Mitigé
                 │              │            │
                 └──────────────┴────────────┴──► Faux positif
```

On peut sauter une case vers le haut **seulement** si la preuve le justifie (Non testé → Confirmé est licite : on a testé et vu). On ne descend pas de Confirmé à Hypothèse sans entrée qui explique la perte de preuve. Mitigé exige une **nouvelle** preuve que le correctif est en place (re-GET, en-tête maintenant présent, 500 devenue 404 générique).

## Index machine

Si tu maintiens `journal/journal.json`, il obéit à `SCHEMAS/journal.schema.json`. C’est un index, pas une seconde vérité : en cas de conflit, les fichiers Markdown gagnent, et tu répares l’index par une nouvelle écriture complète **datée** (remplacer `journal.json` est permis parce que c’est une projection ; les `entries/` restent).

## Ce que le journal refuse

- Une entrée antidatée.
- Un finding Confirmé « on le saura plus tard ».
- Un copier-coller d’un autre client.
- Un exploit, un PoC, une payload.
- Un silence : si tu t’arrêtes, écris `action: note` avec la raison. `ENGINE/resume.md` s’en servira.

## Relecture avant rapport

Avant d’appeler le mode 8 ou l’agent `11-rapport-final` :

1. Tous les Confirmé ont une preuve datée.
2. Tous les C respectent le plafond du statut.
3. Tous les `priority` ont un calcul dans le journal ou dans `notes`.
4. `qa/signoff.md` existe et `qa.passed=true`. Sinon : pas de rapport final.

## Exemple

`examples/demo-journal/` : trois findings fictifs, preuves, sign-off QA. Recopie la forme.

# Reprise après coupure

La mission a été interrompue (contexte plein, crash, humain parti, clé OpenRouter coupée). Tu ne recommences pas. Tu continues.

---

## Première action : ne rien écrire

Avant toute collecte ou finding :

1. Vérifie la clé OpenRouter avec `sh bin/check-openrouter-key.sh` (`RULES/00-openrouter.md`). N’ouvre pas `.env`. Absente → STOP, message 30–50 € + `GUIDES/deposit-key.md`. La coupure n’autorise pas un audit « de mémoire ».
2. Lis `projects/<slug>/project.yaml`. Pas de fichier → ce n’est pas une reprise, c’est une ouverture (`ENGINE/projects.md`).
3. Lis les **20 dernières** entrées de `journal/entries/` (ordre lexicographique = ordre temporel si le nommage est respecté). S’il y en a moins, lis-les toutes.
4. Lis `journal/qa/signoff.md` s’il existe.
5. Lis `journal/coverage.md` et `surface.md`.

Interdit : inventer ce qui « a dû » se passer. Si le journal est muet, la tâche n’est pas faite.

## Reconstruire la position

Dresse, dans une entrée `action: resume` (oui, **après** la lecture, c’est la première écriture) :

| Question | Source |
| --- | --- |
| Quel mode ? | `project.yaml` → `mode` |
| Quel agent tournait ? | dernière entrée `agent` + `action` non `note` |
| Qu’est-ce qui est **clos** ? | findings scorés + preuves liées + agents déjà passés dans le pipeline du mode |
| Qu’est-ce qui est **en cours** ? | dernière action sans sortie complète (collecte sans `surface.md`, finding sans score, QA commencée sans sign-off) |
| Qu’est-ce qui est **bloqué** ? | `qa.passed`, `AUTHORIZED`, second tenant manquant, hors-scope |

Recopie le pipeline du mode (`ENGINE/modes/0X-….md`). Coche ce qui a une trace journal. Ce qui n’a pas de trace n’est pas fait.

## Règles de non-régression

- Ne relance pas un agent dont les sorties existent et sont cohérentes, sauf si l’entrée de reprise signale une preuve manquante ou un statut illégal (Confirmé sans URL).
- Ne change pas les ids `F-NNN` / `E-NNN` / `J-…`.
- Ne recrée pas un projet « -reprise » ou « -2 ».
- Ne relance pas le crawl entier : reprends à la dernière URL ou classe non cochée dans `surface.md`.
- Si la dernière entrée dit « plafond 200 URLs atteint », tu n’élargis pas en silence. Tu demandes, ou tu restes au plafond.

## Cas fréquents

### Coupure pendant la collecte

Reprendre `ENGINE/collect.md` au bloc suivant le dernier bloc prouvé. Relire les preuves déjà écrites pour ne pas dupliquer un `E-NNN`.

### Coupure pendant le scoring

Les findings sans `priority` se calculent maintenant (`ENGINE/score.md`). Ceux qui ont déjà priority + entrée `score` restent.

### Coupure pendant la QA

Lire les findings contestés dans la dernière note QA. Corriger **par nouvelles preuves / nouveaux statuts**, pas en négociant le texte. Relancer la QA ensuite. Un `qa.passed=true` écrit avant la coupure reste vrai seulement si aucun finding n’a été modifié depuis. Si tu as touché un finding, `qa.passed` repasse à `false` et tu le consigne.

### Coupure avant le rapport

Si `qa.passed=true` et journal intact → enchaîne `11-rapport-final` ou le mode 8. Si `qa.passed` est faux ou absent → pas de rapport. Dis-le.

### Mode 7 interrompu

Re-vérifie `AUTHORIZED=yes` **et** `authorization.md` avant le moindre GET. Une reprise n’hérite pas d’une autorisation « on l’avait en tête ».

### Mode 8 interrompu

Toujours : zéro test neuf. Reprends la rédaction là où `reports/board.md` s’arrête. Si le journal a changé depuis le début de rédaction, relis tout le top P0/P1.

### Clé OpenRouter revenue après STOP

Reprise normale. N’invente pas les analyses « que tu aurais faites » pendant l’arrêt.

## Entrée de reprise (forme)

Utilise `TEMPLATES/journal-entry.md` avec `action: resume`. Corps minimum :

- dernière entrée lue (id + ts)
- agents déjà passés
- prochain agent
- listes : findings sans preuve, findings sans score, surfaces non collectées
- portails durs encore fermés (QA, AUTHORIZED, tenants)

## Quand déclarer l’échec de reprise

Arrête-toi et demande à l’humain si :

- deux `project.yaml` existent pour le même client sans lien `related_projects` ;
- des ids de findings se chevauchent ;
- le journal parle d’un mode, `project.yaml` d’un autre, sans entrée de changement ;
- des extraits de preuves ont l’air génériques (pas d’URL, pas de date) sur des Confirmé.

Ne « répares » pas ça en inventant. Écris l’incohérence, statut des findings concernés abaissé jusqu’à re-preuve.

---
id: mode-05-delta
reads: [RULES/*, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md, ENGINE/projects.md, ENGINE/resume.md]
writes: [journal/entries, journal/findings, journal/evidence, snapshots/*, livrables/delta-compare.md]
forbids: [inventer une preuve, sortir du scope, produire un exploit, ouvrir un second projet pour la même cible]
---

# Mode 5 — Delta

Comparer l’état actuel au dernier snapshot du **même** projet. Pas un nouvel audit déguisé. Pas de dossier `…-delta`.

## Quand l’ouvrir

- Une passe 2, 3 ou 4 a déjà produit un journal et une QA.
- L’humain demande « qu’est-ce qui a bougé ? »
- Après une vague de correctifs.

S’il n’existe aucun finding antérieur : ce n’est pas un delta. Ouvre le mode qui convient (2/3/4).

## Portails

1. Clé OpenRouter. Sinon STOP.
2. `projects/<slug>/` existant, avec au moins une clôture partielle (findings + preuves).
3. Créer `snapshots/<YYYY-MM-DD>/` **avant** toute collecte neuve : copie de `project.yaml`, `journal/findings/`, `coverage.md`. Si un snapshot du jour existe déjà, réutilise-le, n’écrase pas.

## Pipeline

```
00 orchestrateur          (annonce mode 5, pointe le snapshot)
  → snapshot
  → 01 collecte ciblée    (mêmes classes que la fois précédente ;
                           nouvelles origines seulement si ajoutées au brief)
  → re-vérif des findings ouverts (GET/HEAD sur l’URL de la preuve)
  → 09 si le projet est un produit agent, ou si une surface agent apparaît
  → spécialiste saas-multitenant si le projet était en mode 3
  → rescore / status-change
  → 10 QA (porte sur le delta + les Confirmé encore ouverts)
  → livrable delta-compare
  → 11 seulement si un rapport complet est redemandé ET qa.passed=true
```

Tu ne relances pas 03–08 en entier « pour le plaisir ». Tu les rappelles si :

- une **nouvelle** classe de surface apparaît (nouvelle API, nouvel hôte) ;
- un finding Mitigé doit être compris (régression possible ailleurs).

Les nouvelles classes non rejouées restent **Non testé**.

## Re-vérification

Pour chaque finding encore Confirmé / Probable / Hypothèse du snapshot :

1. Relis la preuve ancienne.
2. Rejoue **la même** méthode non destructive (même URL, même verbe).
3. Si le fait a disparu (CSP maintenant présente, 500 devenue page générique) : statut **Mitigé**, nouvelle preuve, entrée `status-change`.
4. Si le fait est identique : garde le statut, ajoute une preuve « encore vrai à <date> ».
5. Si le fait a empiré (plus visible, plus d’impact) : rescore, entrée `score`, bande éventuellement plus haute.

N’efface pas le finding mitigé. Il reste, statut à jour.

## Classement delta

Chaque ligne du `TEMPLATES/delta-compare.md` :

| Classe | Sens |
| --- | --- |
| Nouveau | id créé après le snapshot |
| Inchangé | même statut, même bande |
| Régressé | Mitigé/Faux positif → rouvert, ou bande qui monte |
| Mitigé | Confirmé/Probable → Mitigé |
| Toujours non testé | toujours pas les prérequis (ex. un seul tenant) |

## Sorties

- `livrables/delta-compare.md` (obligatoire).
- Journal mis à jour.
- Rapports exec/impl seulement sur demande, après QA.

## Stop

- Comparer à un autre client ou à un souvenir → interdit.
- Confirmer un nouveau P0 sans preuve neuve → interdit.
- Mode 8 dans la même souffle sans QA du delta → interdit.

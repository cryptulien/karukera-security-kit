# Comparaison delta

Écris `projects/<slug>/livrables/delta-compare.md`. Exige un snapshot dans `snapshots/<date>/`. Mode 5 ou 6.

## Fenêtre

- Snapshot de référence :
- Date de re-observation :
- Mode :
- QA du delta : `passed` / `non requise` (run stérile du mode 6) / `refusée`

## Compteurs

| Classe | Nombre | ids |
| --- | --- | --- |
| Nouveau | 0 |  |
| Inchangé | 0 |  |
| Régressé | 0 |  |
| Mitigé | 0 |  |
| Toujours non testé | 0 |  |
| Faux positif nouveau | 0 |  |

Définitions : `ENGINE/modes/05-delta.md`.

## Nouveaux

Pour chaque id : titre, bande, statut, preuve datée du run courant.

## Régressions

Ancien statut → nouveau, ancienne bande → nouvelle, preuve de réapparition.

## Mitigés

Preuve de disparition du fait (même URL, même méthode). Date.

## Toujours non testé

Précondition toujours absente (ex. `tenants_available` encore à 1). Ne pas « fermer » ces lignes pour faire descendre le compteur.

## Surfaces nouvelles

URLs / tools apparus depuis le snapshot, hors brief initial : soit ajoutés au brief (entrée journal), soit hors-scope explicite.

## Alerte

`aucune` ou liste P0/P1 nouveaux ou régressés.

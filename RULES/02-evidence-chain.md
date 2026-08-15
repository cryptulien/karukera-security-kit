# Règle 02 — Chaîne de preuve

Chaque finding porte une chaîne. Pas de chaîne → pas de `Confirmé`.

## Chaîne minimale

| Champ | Règle |
| --- | --- |
| surface | URL, `path:ligne`, route API, tool MCP, en-tête ou fichier — assez pour retrouver le point |
| extrait | citation courte, telle qu’observée, bornée, sans secret entier |
| date | date-heure ISO de l’observation (`2026-08-15T14:32:00Z`) |
| méthode | ce que tu as fait (lecture de réponse, comparaison de deux comptes, revue de schéma) |

Un `Confirmé` exige les quatre. Un `Probable` exige au moins surface + date + méthode, et dit ce qui manque. Une `Hypothèse` dit sur quoi elle s’appuie et ce qui n’a pas été mesuré.

## Journal

Le journal est **append-only**. Tu ajoutes. Tu ne réécris pas une entrée passée. Pour corriger : nouvelle entrée qui référence l’id et change le statut (`Mitigé`, `Faux positif`, ou retranchement).

Reprise après coupure : `ENGINE/resume.md`. Relis le journal, ne recommence pas à zéro, n’efface rien.

## Secrets dans la preuve

Tronque les secrets (`sk-or-v1-…abcd`). Ne recopie pas de données personnelles, de jetons complets, de contenu d’un autre tenant. Note « secret tronqué » dans l’extrait.

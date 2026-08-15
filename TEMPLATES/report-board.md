# Rapport board

Écris `projects/<slug>/reports/board.md` **uniquement en mode 8**. Portail : `qa.passed=true` et aucun finding plus récent que la QA. Zéro test. 2–4 pages. Dix findings maximum dans le corps.

## Cartouche

- Organisation :
- Système :
- Période d’observation :
- Mode source (2 / 3 / 4 / 5 / 7) :
- QA : date, reviewer, `passed: true`
- Couverture de surface : … %
- Confiance de mission : … / 5
- Tenants fournis :
- Autorisation mode 7 : sans objet / signataire + dates

Phrase obligatoire :

> Ce texte ne dit pas que le système est sûr. Il dit ce qui a été mesuré, avec quel statut, sur quel périmètre.

## Décision en une minute

| | |
| --- | --- |
| P0 ouverts | n (dont Confirmé n) |
| P1 ouverts | n (dont Confirmé n) |
| Fait le plus coûteux à ignorer | F-NNN + une clause métier |
| Précondition manquante | second tenant / compte / 09 / néant |
| Demande au board | financer X, accepter le risque Y, fournir Z |

## Jauges (séparées)

- **Couverture** : parts de surface planifiée effectivement collectée. Chiffre. Une couverture haute n’augmente pas C des findings.
- **Confiance de mission** : qualité globale du dossier après QA. Chiffre 1–5. Une confiance 4 avec couverture 40 % est possible et doit se lire comme telle.

## Constats que le board peut citer

Pour chaque item (max 10), quatre lignes :

1. Titre + id + bande + statut.
2. Fait observable (une phrase).
3. Preuve : URL + date (pas d’extrait long).
4. Ce que l’organisation change (contrôle, pas un chantier-roman).

Interdit : promouvoir un Non testé en « probablement exposé » dans cette section. Les Non testé vont ci-dessous.

## Ce que nous n’avons pas mesuré

Liste à puces, brutale. Isolation si un tenant. Auth si pas de compte. Code source si hors mode. Fournisseurs hors-scope.

## Mitigés depuis la dernière passe

Si un snapshot existe : trois lignes max, ou « première passe, sans historique ».

## Annexes

Tableau compact de **tous** les findings actifs : id, bande, statut, priority. Les preuves restent dans le journal, pas en pièce jointe-payload.

Aucun chiffre d’amende, aucun « équivalent CVSS » inventé, aucun logo client.

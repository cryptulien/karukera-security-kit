# Rapport exécutif

Écris `projects/<slug>/reports/exec.md`. Interdit sans `qa.passed=true`. Aucun test pendant la rédaction.

## En-tête

- Client / projet :
- Mode d’origine :
- Période :
- Sign-off QA : date + `passed: true`
- Couverture : `tested / planned` = … %
- Confiance de mission : … / 5
- Tenants disponibles :
- Fictif : oui / non

## Chiffres

| Bande | Actifs (Confirmé + Probable + Hypothèse + Non testé) | Dont Confirmé |
| --- | --- | --- |
| P0 |  |  |
| P1 |  |  |
| P2 |  |  |
| P3 |  |  |

Les deux jauges (couverture, confiance) ne se déduisent pas l’une de l’autre. Écris une phrase qui les sépare.

## Ce qui compte cette semaine

5 lignes max. P0 et P1 Confirmé d’abord. Chaque ligne : id, titre, bande, date de preuve. Pas de Non testé vendu comme trou démontré.

## Ce qui n’a pas été vu

Compte-test manquant, second tenant manquant, 09 sauté ou exécuté à vide, hors-scope. Impératif : le lecteur board ne doit pas croire à l’exhaustivité.

## Décisions demandées

Budget / ordre (reprendre les F des P0/P1). Une décision = un verbe + un owner + un délai que le client peut tenir. Pas de délai inventé si le client n’en a pas donné : écris `à dater par le client`.

## Renvois

`reports/impl.md` pour le détail. `journal/` pour les preuves. Mode 8 si un board pack est demandé.

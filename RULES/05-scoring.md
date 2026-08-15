# Règle 05 — Scoring

Cinq dimensions, chacune de 1 à 5, entiers uniquement.

| Lettre | Nom | 1 | 5 |
| --- | --- | --- | --- |
| I | Impact | gêne cosmétique | perte de données, prise de compte, rupture d’isolation |
| E | Exploitabilité | prérequis lourds, fenêtre étroite | un utilisateur normal y arrive sans aide |
| C | Confiance | faible, peu tenu | observé, reproductible, chaîne complète |
| F | Effort de fix | correctif trivial | refonte longue |
| V | Visibilité | interne, peu exposé | attaquant externe le voit sans compte privilégié |

Plafonne C selon le statut (`RULES/03-measurement-status.md`) **avant** le calcul.

## Formule

```
priority = 10 * (0.30*I + 0.25*E + 0.20*C + 0.15*V) - 2*F
```

Arrondis au dixième. Un F bas (fix facile) **monte** la priorité.

## Bandes

| Bande | Score | Lecture |
| --- | --- | --- |
| P0 | ≥ 35 | traiter maintenant |
| P1 | 25–34 | traiter dans le sprint |
| P2 | 15–24 | planifier |
| P3 | < 15 | backlog / hygiène |

`Faux positif` : priority = 0, hors bande.

## Interdit

- Ajuster I/E/C/F/V pour viser une bande.
- Mettre C = 5 sur une `Hypothèse` (plafond 2) ou un `Probable` (plafond 3).
- Remplacer la formule par un CVSS inventé.
- Scorer un `Non testé` comme s’il était confirmé : C = 1, et dis-le.

Exemple chiffré : `GUIDES/scoring-worked-example.md`.

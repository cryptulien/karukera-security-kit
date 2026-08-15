# Règle 01 — Anti-invention

N’invente aucune preuve, aucun extrait, aucune URL, aucun en-tête, aucun compte, aucun identifiant de ticket.

## Statut selon ce que tu as vraiment fait

- Tu as observé et tu tiens URL + extrait + date → `Confirmé`.
- Plusieurs indices convergents, preuve incomplète → `Probable`.
- Tu déduis sans avoir mesuré → `Hypothèse`.
- Le mode ou le temps n’a pas couvert le point → `Non testé`.
- Un contrôle réduit le risque et tu l’as vu → `Mitigé`.
- Tu as réfuté avec une contre-preuve → `Faux positif`.

Jamais `Confirmé` par analogie (« c’est courant sur ce framework »). Jamais de capture fictive. Jamais de log inventé pour « faire complet ».

## Interdit aussi

- Compléter un trou du journal avec un finding plausible.
- Reprendre un finding d’une autre mission ou d’un exemple comme s’il appartenait à cette cible.
- Forcer un P0 pour impressionner. Le score sort de la formule (`RULES/05-scoring.md`).
- Écrire un exploit, un payload ou un PoC « pour prouver ». Décris l’observation. S’arrête à l’extrait.

Si tu doutes : descends le statut. Le silence (`Non testé`) vaut mieux qu’une invention.

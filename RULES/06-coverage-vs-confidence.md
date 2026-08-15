# Règle 06 — Couverture ≠ confiance

Deux jauges. Jamais une seule. Jamais fusionnées dans une phrase du type « on est confiants à 80 % parce qu’on a beaucoup crawlé ».

## Couverture

Part du **scope déclaré** effectivement mesurée dans cette mission.

Écris-la en pourcentage **et** en périmètre : routes, rôles, tenants, tools MCP, environnements.

Une couverture haute avec beaucoup de `Non testé` internes est une erreur de compte : ce qui n’est pas mesuré n’entre pas dans le numérateur.

## Confiance

Tenue d’**un** finding (dimension C, plafonnée par le statut).

Un seul `Confirmé` avec C = 5 reste valide si la couverture globale est à 30 %. Une couverture à 90 % ne hisse pas une `Hypothèse` au-dessus de C = 2.

## Rapport

Le livrable porte les deux jauges, séparées :

- Couverture : « 12 / 40 routes authentifiées, 1 / 3 rôles, 0 / 2 tenants hors le nôtre. »
- Confiance : portée par finding, jamais agrégée en « score de confiance du rapport ».

Le mode `01-express` a une couverture basse **par contrat**. Ne la déguise pas.

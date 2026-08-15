# Rapport d’implémentation

Écris `projects/<slug>/reports/impl.md`. Interdit sans `qa.passed=true`. S’adresse à qui corrige.

## En-tête

Même bloc que `report-exec.md` (projet, mode, QA, couverture, confiance, tenants).

## File priorisée

Tableau, tri `priority` décroissant. Findings actifs seulement.

| id | titre | statut | I | E | C | F | V | priority | bande | asset |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| F-000 |  |  |  |  |  |  |  |  |  |  |

## Fiches

Pour chaque P0 et P1, puis pour les P2 Confirmé :

### F-000 — titre

- Statut / bande / priority (calcul recopié).
- Asset.
- Constat (le fait).
- Preuves (ids + URL + date).
- Remédiation vérifiable.
- Test de sortie (ce que le mode 5 rejouera).
- Dépendances (autre finding, change-window).

Pas de payload. Pas d’exploit de vérification. Le test de sortie est un GET/HEAD ou une lecture de config.

## Isolation (si mode 3 ou tenancy)

Tableau dédié, y compris les **Non testé**. Répète `tenants_available`.

## Surface agent (si 09 a tourné)

Inventaire des tools / skills : nom, verbe réel, identité d’exécution, finding lié ou « rien à scorer ».

## Mitigés et faux positifs

Liste courte, ids + date de status-change. Sert au delta suivant.

## Hors journal

Rien. Si ce n’est pas dans `findings/`, ce n’est pas dans ce rapport.

---
id: squad-06-api-backend
role: squad
reads: [RULES/*, ENGINE/journal.md, journal/surface, journal/threat-model, brief]
writes: [journal/findings, journal/evidence]
forbids: [inventer une preuve, sortir du scope, produire un exploit, DoS, fuzz massif, introspection GraphQL abusive hors brief]
---

# 06 — API / backend

## Mission

Éprouve les API REST, GraphQL ou RPC du scope : verbes, mass assignment, rate-limit, fuites d’erreur. Tu t’appuies sur les routes découvertes par 01 et les objets de 05. Tu n’inventes pas un endpoint. Tu ne satures pas la cible.

## Checklist déclenchée

Exécute `SQUAD/06-api-backend.checklist.md`. Chaque route testée cite l’artefact qui l’a révélée (JS, OpenAPI, UI).

## Méthode

1. **Catalogue.** Fusionne 01 + appels réellement émis par le front (onglet réseau du compte de test). Host, chemin, verbe, auth exigée, content-type.
2. **Verbes.** Sur une ressource de test, observe GET, HEAD, OPTIONS, POST, PUT, PATCH, DELETE **une fois chacun**. Note 405 vs 200 vs 401. N’enchaîne pas de DELETE destructeur : seulement un objet jetable du brief.
3. **Mass assignment.** Si le client envoie un sous-ensemble de champs, observe la réponse à un champ déjà présent dans le schéma (doc, OpenAPI, exemple JS) : `role`, `price`, `verified`, `tenant_id`. N’invente pas 30 champs. Un echo inattendu = finding.
4. **Auth de l’API.** Même ressource : sans cookie, cookie d’un autre tenant (compte B), Bearer expiré, mauvaise `Origin`. 200 anonyme sur une ressource privée = Confirmé.
5. **Rate-limit.** Quelques requêtes rapides sur login ou endpoint coûteux du compte de test. 429 présent / headers `Retry-After` / absence. Arrête-toi. Pas de flood.
6. **GraphQL.** Si exposé : requête `{ __typename }` ou une query déjà utilisée par le front. Introspection : une tentative. Ouverte sans auth → Confirmé d’exposition. Ne dump pas le schéma entier dans le rapport : 10 lignes max. Mutations dangereuses : ne les exécute pas hors objets de test.
7. **Erreurs.** Déclenche une erreur bénigne (id mal formé, champ manquant). Copie la stack, le chemin fichier, la version, la requête SQL éventuellement reflétée. Masque les secrets.
8. **Pagination et export.** `limit`, `offset`, `page` : une valeur déjà vue dans le front (ex. `limit=100` si le front l’envoie). Export CSV : périmètre tenant.
9. **Idempotence et rejeu.** Un webhook ou une action d’abonnement (si in-scope) : le même `Idempotency-Key` / le même event-id. Observe. Ne rejoue pas un paiement réel.
10. **Versioning et verbosité.** `/v1` vs `/v2`, debug (`?debug=1`) s’il apparaît dans le JS. Pas de paramètre inventé hors ceux vus.

## Sorties

```yaml
routes_tested: []
graphql: absent | auth | public_introspection | not_tested
rate_limit: present | absent | not_tested
error_leakage: []
not_tested: []
```

Findings : `priority = 10*(0.30I + 0.25E + 0.20C + 0.15V) - 2*F`.

## Pièges

- Fuzzer 10 000 routes : hors contrat, risque de DoS.
- Dump d’introspection GraphQL de 200 kL dans le journal.
- Confondre une 500 avec une RCE.
- Tester Stripe / l’IdP hors scope.
- Déclarer « pas de rate-limit » après deux requêtes espacées.
- Mass-assignment avec des champs jamais vus dans le produit.

## Exemple de finding fictif

Cible inventée. Aucune vulnérabilité réelle.

```yaml
id: F-API-DEMO-009
title: "PATCH /api/projects accepte le champ archived_by_admin exposé dans OpenAPI"
agent: squad-06-api-backend
status: Confirmé
impact: 3
exploitability: 4
confidence: 5
fix_effort: 2
visibility: 3
priority: 29.5
band: P1
evidence:
  - url: "https://demo.acme-audit.test/api/projects/p-test-a"
    excerpt: "OpenAPI: archived_by_admin:boolean ; PATCH {\"archived_by_admin\":true} → 200 {\"archived_by_admin\":true}"
    date: "2026-03-12"
    method: "Champ documenté, objet jetable du compte A. Pas d’autre champ ajouté."
notes: "Mass assignment borné à un champ déjà publié. Effet métier à faire valider par le client."
```

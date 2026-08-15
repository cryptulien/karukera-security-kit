---
id: mode-03-complet-saas
reads: [RULES/*, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md, SPECIALISTS/saas-multitenant]
writes: [journal/*, reports/exec.md, reports/impl.md, livrables/*]
forbids: [inventer une preuve, sortir du scope, produire un exploit, confirmer une isolation sans deux tenants]
---

# Mode 3 — Audit Complet SaaS

Mode par défaut d’un produit B2B. L’isolation entre tenants est le risque central. **09 tourne toujours. Le spécialiste `saas-multitenant` tourne toujours.**

## Quand l’ouvrir

- SaaS avec organisations, workspaces, équipes, ou simplement plusieurs clients sur la même app.
- Tout produit qui promet « vos données restent les vôtres ».

Si le produit est surtout un agent / MCP : ouvre **aussi** l’esprit du mode 4 — ici 09 est déjà obligatoire ; le mode 4 le place au centre.

## Portails

1. Clé OpenRouter. Sinon STOP.
2. Brief avec hôtes, rôles, **combien de tenants** le client met à disposition.
3. Compte-test : au moins un. Deux tenants complets (deux orgs, deux jeux d’identifiants) : exigés pour toute conclusion d’isolation.

### Règle des deux tenants

```
si scope.tenants_available < 2
alors tout finding d’isolation / IDOR trans-tenant / fuite cross-org
     reste au statut « Non testé »
     C = 1
     I et E peuvent décrire le risque *potentiel*
     le rapport le dit en tête, pas en note de bas de page
```

Un seul tenant + « on voit un `org_id` dans l’URL » = **Non testé** (ou Hypothèse si le code client JS montre un paramètre clairement commutable — toujours pas Confirmé). Tu ne confirmes pas une rupture d’isolation sans deux contextes distincts observés.

Remplir `project.yaml` → `scope.tenants_available` avec le nombre **réellement utilisable** (comptes qui marchent), pas le nombre promis au téléphone.

## Pipeline

```
00 orchestrateur
  → 01 surface-mapper          (collecte complète, y compris API)
  → 02 threat-modeling
  → 03 audit-onpage
  → 04 auth-session            (invitation, SSO si in-scope, session, reset)
  → 05 authz-privilege         (rôles intra-tenant d’abord)
  → spécialiste saas-multitenant   TOUJOURS
  → 06 api-backend             (object IDs, exports, webhooks, admin)
  → 07 config-secrets
  → 08 supply-chain
  → 09 agent-mcp-skills        TOUJOURS (produit SaaS moderne = surface agent fréquente)
  → 10 adversarial-qa
  → 11 rapport-final           si qa.passed=true
```

09 ne se saute pas. Si aucune surface agent n’existe, 09 écrit une entrée : « surface agent absente après recherche X, Y, Z » + un finding **Non testé** seulement si un indice existe, sinon une note de couverture « 09 exécuté, rien à scorer ».

Le spécialiste `saas-multitenant` lit 04 et 07. Il ne les remplace pas. Il cherche : IDs d’org dans l’URL et le corps, exports, recherche globale, webhooks, avatars, S3, caches, logs, impersonation support.

## Méthode d’isolation (non destructive)

Avec **deux** tenants A et B fournis par le brief :

- Authentifie A, note les ids que l’UI et l’API exposent.
- Authentifie B (session séparée).
- Demande, avec la session B, une ressource de A **dont l’id a été vu dans l’UI A** (un GET). Pas d’énumération de toute la clé, pas de bruteforce.
- Compare le code et le corps : 200 avec données de A = preuve. 403/404 = preuve d’un contrôle (pas un finding Confirmé d’IDOR).
- Recopie extraits masqués (pas de PII client réelle en clair au-delà de ce qui illustre le trou).

Avec **un** tenant : décris la surface (`org_id`, routes `/t/:id/…`) en Non testé. Score selon le cas H de `ENGINE/score.md`.

## Sorties

Mêmes livrables que le mode 2, plus :

- une section dédiée « Isolation » dans exec et impl, même si tous les items sont Non testé ;
- le compte `scope.tenants_available` répété en tête de rapport.

## Couverture

Sans second tenant, `coverage.confidence_globale` ≤ 3, même si le reste est soigné. La jauge couverture d’isolation = 0 % si tenants < 2.

## Stop

- Confirmer un IDOR trans-tenant sans deux sessions → interdit.
- Mode 7 déguisé (« on essaie des ids au hasard ») → interdit ici.
- QA : tout Confirmé d’isolation sans deux preuves de contexte (tenant A et tenant B) est rejeté.

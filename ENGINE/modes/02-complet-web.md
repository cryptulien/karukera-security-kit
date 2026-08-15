---
id: mode-02-complet-web
reads: [RULES/*, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md, ENGINE/projects.md, ENGINE/resume.md]
writes: [journal/*, reports/exec.md, reports/impl.md, livrables/*]
forbids: [inventer une preuve, sortir du scope, produire un exploit]
---

# Mode 2 — Audit Complet Web

Pipeline web classique. Un site, une appli rendue serveur ou SPA, éventuellement une API publique du même origine. Ce n’est **pas** le mode SaaS multi-tenant (→ 03) ni le mode produit agent (→ 04).

## Quand l’ouvrir

- Site marketing, blog, e-commerce single-tenant, app web sans promesse d’isolation B2B.
- L’humain veut un rapport implémentable, pas un tri Express.

## Portails

1. Clé OpenRouter. Sinon STOP.
2. `brief.md` avec hôtes, hors-scope, plage horaire, postures.
3. Compte-test : recommandé. S’il manque, toute la branche authentifiée reste **Non testé** — tu ne l’inventes pas.
4. `scope.code_path` présent → `SPECIALISTS/code-source`. Absent → code `Non testé`.

Observation non destructive. Les seuls POST/PUT sont ceux **documentés** dans le brief (login compte-test).

## Pipeline

```
00 orchestrateur
  → 01 surface-mapper          (ENGINE/collect.md, plafond 800 URLs / origine)
  → 02 threat-modeling
  → 03 audit-onpage            (observation : reflets, encodage, messages d’erreur — zéro payload)
  → 04 auth-session            (si compte-test ou flux login visible)
  → 05 authz-privilege         (objets du même utilisateur / rôles ; pas de second tenant exigé)
  → 06 api-backend             (si apis.md n’est pas vide)
  → 07 config-secrets
  → 08 supply-chain
  → 09 agent-mcp-skills        inventaire négatif si aucune surface agent
  → 10 adversarial-qa
  → 11 rapport-final           seulement si qa.passed=true
```

Spécialistes : selon surface (auth atypique, paiement, upload). Pas de `saas-multitenant` obligatoire ici. Si tu découvres une tenancy réelle, **bascule** le projet en mode 3 (entrée journal + `project.yaml`) et applique alors la règle des deux tenants.

### Règle 09 dans ce mode

- Surface agent = endpoint MCP, host `llms.txt` qui annonce des tools, UI « agent », Skills, webhook d’assistant.
- Détectée → 09 **tourne** en profondeur.
- Absente après collecte → 09 tourne en **inventaire négatif** : documente l’absence, `coverage.md` le dit, ne score rien.
- En doute (un simple chatbot décoratif) → 09 tourne en version courte, findings plutôt Hypothèse / Non testé.

## Méthode

- Collecte d’abord, findings ensuite. Pas de score au feeling pendant le crawl.
- Auth : sessions, cookies, reset, MFA si présent, fixation de session **observée** (tu ne voles pas de session).
- Access-control : ressources dont l’id apparaît dans l’UI du compte-test. Tu ne bruteforces pas les ids hors de ce qui est lié. Un id deviné non fourni par le brief → Non testé.
- Input-output : tu documentes les reflets (valeur renvoyée telle quelle). Tu n’injectes pas.

## Sorties

- Journal complet + threat-model.
- `reports/exec.md`, `reports/impl.md`.
- `livrables/audit-strategique.md`, `livrables/plan-implementation.md`, `livrables/checklist-actions.md`.
- `reports/board.md` seulement si l’humain enchaîne le mode 8 **après** QA.

## Couverture

`coverage.confidence_globale` typique : 3–4. 5 seulement si compte-test + API inventoriée + 09 traité ou explicitement sans objet, et QA sans réserve majeure.

## Stop

- QA refusée → pas d’agent 11.
- Demande d’exploit ou de PoC → refuse, reste sur preuves d’observation.
- Découverte d’une surface hors-scope (paiement hébergé, IdP) → note, n’y va pas.

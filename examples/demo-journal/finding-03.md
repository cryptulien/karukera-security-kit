---
id: F-003
title: "Isolation multi-tenant non mesurée (un seul tenant fourni)"
status: Non testé
fictif: true
asset: "https://app-fictive.example/o/{org_id}/invoices"
impact: 5
exploitability: 3
confidence: 1
fix_effort: 3
visibility: 3
I: 5
E: 3
C: 1
F: 3
V: 3
priority: 23.0
band: P2
evidence:
  - id: E-003
    url: "https://app-fictive.example/app.js"
    excerpt: "lecture-js : routes.push({path:'/o/:org_id/invoices', name:'Invoices'}) ; fetch('/api/orgs/'+orgId+'/invoices')"
    date: "2026-04-12"
    method: lecture-js
notes: "priority = 10*(0,30*5 + 0,25*3 + 0,20*1 + 0,15*3) - 2*3 = 10*(2,90) - 6 = 23,0 (cas H). C=1 imposé par Non testé. tenants_available=1 ⇒ interdiction de Confirmer."
---

# F-003 — Isolation multi-tenant non mesurée (un seul tenant fourni)

**Fictif.** `app-fictive.example` n’existe pas. Le finding enseigne la règle du mode 3.

## Constat

Le bundle JS de l’app fictive expose des routes `/o/:org_id/invoices` et des appels `/api/orgs/{orgId}/invoices`. Le brief ne fournit **qu’un** compte, une seule organisation. Aucune session B n’existe. Conformément à `ENGINE/modes/03-complet-saas.md`, l’isolation reste **Non testé**.

## Pourquoi c’est un risque

Si `org_id` est commutable côté API, un utilisateur d’une org pourrait lire les factures d’une autre. I=5 décrit ce **potentiel**. Ce n’est pas un trou démontré. Le rapport board doit le dire en tête, pas en note.

## Preuves

- E-003 — lecture du JS — 2026-04-12 — présence du paramètre `org_id`. Cette preuve **ne suffit pas** à un Confirmé.

## Remédiation

Côté mesure : fournir un second tenant de staging (vague 3 du plan). Côté code, une fois mesurable : autoriser uniquement l’`org_id` de la session, ignorer le paramètre client. F=3 reste indicatif tant que le statut est Non testé.

Critère de sortie : `tenants_available >= 2`, puis GET documenté de B sur un id vu chez A → 403/404 (Mitigé / contrôle vu) ou 200+données A (alors Confirmé, nouvelle preuve).

## Limites

Pas de compte B. Pas de mode 7. Pas d’énumération d’ids. 09 n’a pas trouvé de tool MCP sur cette démo.

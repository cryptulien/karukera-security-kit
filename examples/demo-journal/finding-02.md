---
id: F-002
title: "Réponse 500 verbeuse sur l’API fictive /v1/orders"
status: Confirmé
fictif: true
asset: "https://api-fictive.example/v1/orders/karukera-collect-probe-20260412"
impact: 2
exploitability: 4
confidence: 5
fix_effort: 2
visibility: 3
I: 2
E: 4
C: 5
F: 2
V: 3
priority: 26.5
band: P1
evidence:
  - id: E-002
    url: "https://api-fictive.example/v1/orders/karukera-collect-probe-20260412"
    excerpt: "HTTP/1.1 500 Internal Server Error | content-type: application/json | x-powered-by: Express | body: {\"error\":\"TypeError: Cannot read properties of undefined (reading 'id')\",\"stack\":\"TypeError: Cannot read properties of undefined (reading 'id')\\n    at /usr/src/app/routes/orders.js:84:19\"}"
    date: "2026-04-12"
    method: GET
notes: "priority = 10*(0,30*2 + 0,25*4 + 0,20*5 + 0,15*3) - 2*2 = 10*(3,05) - 4 = 26,5 (cas C). Hôte fictif, probe 404/500 du bloc 7 de collect.md."
---

# F-002 — Réponse 500 verbeuse sur l’API fictive /v1/orders

**Fictif.** L’hôte `api-fictive.example` n’existe pas. L’extrait est un exemple pédagogique.

## Constat

Un `GET` vers un identifiant volontairement inexistant (`/v1/orders/karukera-collect-probe-20260412`) renvoie 500 JSON avec `x-powered-by: Express`, un message `TypeError` et un chemin disque `/usr/src/app/routes/orders.js:84`.

## Pourquoi c’est un risque

Fuite d’implémentation (stack, chemin, framework). I=2. E=4 : un GET anonyme sur un id non issu d’une wordlist, conforme au probe unique de collecte. Pas d’injection.

## Preuves

- E-002 — URL ci-dessus — 2026-04-12 — GET — corps JSON et en-tête `x-powered-by`.

## Remédiation

Page d’erreur générique (code opaque + id de corrélation). Retirer `X-Powered-By`. Journaliser la stack côté serveur seulement. F=2.

Critère de sortie : le même GET renvoie 404 ou 400 sans stack, sans chemin, sans `X-Powered-By`.

## Limites

Un seul chemin probe. Les autres routes `/v1/*` restent Non testé pour ce type de fuite.

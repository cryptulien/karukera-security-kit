---
id: F-001
title: "Politique CSP absente sur https://example.com"
status: Confirmé
fictif: true
asset: "https://example.com/"
impact: 2
exploitability: 3
confidence: 5
fix_effort: 1
visibility: 5
I: 2
E: 3
C: 5
F: 1
V: 5
priority: 29.0
band: P1
evidence:
  - id: E-001
    url: "https://example.com/"
    excerpt: "HTTP/2 200 | content-type: text/html; charset=UTF-8 | cache-control: max-age=604800 | — en-têtes observés, Content-Security-Policy absent, Content-Security-Policy-Report-Only absent"
    date: "2026-04-12"
    method: GET
notes: "priority = 10*(0,30*2 + 0,25*3 + 0,20*5 + 0,15*5) - 2*1 = 10*(3,10) - 2 = 29,0 (cas B)."
---

# F-001 — Politique CSP absente sur https://example.com

**Fictif.** Illustration de kit. Ne pas attribuer à un client.

## Constat

Le `GET https://example.com/` du 2026-04-12 répond 200. Les en-têtes de réponse ne portent ni `Content-Security-Policy` ni `Content-Security-Policy-Report-Only`. Les autres en-têtes lus figurent dans E-001.

## Pourquoi c’est un risque

Sans CSP, le navigateur n’a pas de politique déclarée pour limiter les scripts. I=2 : défense en profondeur, pas une exécution observée. V=5 : chaque réponse publique.

## Preuves

- E-001 — `https://example.com/` — 2026-04-12 — GET — CSP absente de la liste d’en-têtes.

## Remédiation

Poser une `Content-Security-Policy` sur l’origine (commencer en `Report-Only` si le HTML est chargé de scripts tiers, puis passer en enforce). F=1.

Critère de sortie (mode 5) : un GET sur `https://example.com/` montre une CSP non vide.

## Limites

Aucune XSS n’a été cherchée (mode 3, observation, zéro payload). L’absence de CSP n’est pas une preuve d’XSS.

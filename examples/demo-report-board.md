# Rapport board — Boutique Démo

**Fictif.** Dossier pédagogique. Aucun système réel n’a été audité. Ne pas citer comme preuve client.

## Cartouche

- Organisation : Société fictive Karukera Exemples
- Système : Boutique Démo (`prj-demo-boutique`)
- Période d’observation : 2026-04-10 → 2026-04-12
- Mode source : 03 Complet SaaS, puis rédaction en mode 8
- QA : 2026-04-12, `squad-10-adversarial-qa`, `passed: true`
- Couverture de surface : 9 / 12 = 75 %
- Confiance de mission : 3 / 5
- Tenants fournis : 1
- Autorisation mode 7 : sans objet

> Ce texte ne dit pas que le système est sûr. Il dit ce qui a été mesuré, avec quel statut, sur quel périmètre.

## Décision en une minute

| | |
| --- | --- |
| P0 ouverts | 0 (dont Confirmé 0) |
| P1 ouverts | 2 (dont Confirmé 2) |
| Fait le plus coûteux à ignorer | F-001 — aucune CSP sur l’origine publique ; F-002 — l’API raconte sa stack au premier GET probe |
| Précondition manquante | second tenant (F-003 reste Non testé) |
| Demande au board | financer la vague F=1–2 (CSP + erreurs API) ; fournir une org B de staging avant de parler d’isolation |

## Jauges (séparées)

- **Couverture 75 %** : 9 classes collectées sur 12 planifiées (politiques, accueil, JS, API probe, app routes). Trois classes auth avancées non jouées (pas de second rôle).
- **Confiance de mission 3 / 5** : deux Confirmé publics solides, une tenancy seulement décrite. Une couverture correcte n’autorise pas à dire « l’isolation tient ».

## Constats que le board peut citer

### F-001 — P1 Confirmé — CSP absente

1. `https://example.com/` n’envoie pas de `Content-Security-Policy`.
2. Fait : liste d’en-têtes du GET 2026-04-12, CSP absente.
3. Preuve E-001, URL `https://example.com/`, date 2026-04-12.
4. Changement : poser une CSP (Report-Only puis enforce). Effort F=1.

### F-002 — P1 Confirmé — 500 verbeuse

1. `GET /v1/orders/karukera-collect-probe-20260412` sur l’API fictive renvoie 500 + stack + `X-Powered-By: Express`.
2. Fait : fuite d’implémentation, pas une injection.
3. Preuve E-002, date 2026-04-12.
4. Changement : erreur générique, plus de stack ni de `X-Powered-By`. F=2.

### F-003 — hors citation « trou démontré »

Non testé, P2, C=1. Le JS montre `/o/:org_id/invoices`. Un seul tenant. Le board ne peut pas dire que l’isolation est rompue, ni qu’elle tient.

## Ce que nous n’avons pas mesuré

- Isolation trans-org (un tenant).
- SSO / reset (flux hors brief).
- Paiement (hôte hors-scope).
- Surface agent : 09 exécuté, rien à scorer.
- Code source, revues d’infra, red-team (mode 7 non ouvert).

## Mitigés depuis la dernière passe

Première passe, sans historique.

## Annexes — findings actifs

| id | bande | statut | priority | titre |
| --- | --- | --- | --- | --- |
| F-001 | P1 | Confirmé | 29,0 | CSP absente sur example.com |
| F-002 | P1 | Confirmé | 26,5 | 500 verbeuse API /v1/orders |
| F-003 | P2 | Non testé | 23,0 | Isolation multi-tenant non mesurée |

Preuves dans `examples/demo-journal/`. Aucun payload. Aucun chiffre d’amende.

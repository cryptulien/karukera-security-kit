# Audit stratégique — fond à transposer

Destination : `projects/<slug>/livrables/audit-strategique.md`.  
Public : founder, CISO, sponsor. Une lecture de dix minutes. Interdit sans QA.

Remplis les sections. N’ajoute pas de chapitre décoratif. N’invente aucun fait hors journal.

## 1. Cadre

- Projet, mode, période.
- Périmètre en une phrase (origines, tenants fournis, compte-test oui/non).
- Autorisation : observation seulement, ou mode 7 daté + signataire.
- QA : date, `passed: true`.
- Fictif : oui / non.

## 2. Thèse

Huit lignes max. Quel est le risque **mesuré** le plus coûteux à ignorer, et quelle précondition empêche de mieux mesurer (un tenant, pas de 09, pas de compte). La thèse cite des ids. Elle ne promet pas l’exhaustivité.

## 3. Jauges

| Jauges | Valeur | Lecture |
| --- | --- | --- |
| Couverture | tested/planned = … % | Ce qui a été vu / ce qui était planifié |
| Confiance de mission | … / 5 | Qualité du dossier, pas la moyenne des C |

Sépare-les en une phrase. Une couverture 90 % et une confiance 2 veulent dire : on a beaucoup marché, on a peu prouvé.

## 4. Portefeuille de risques

Regroupe les findings actifs par **décision**, pas par CVE :

- Isolation / tenancy
- Authentification et session
- Surface publique (en-têtes, fuites)
- Agents / MCP / tools
- Secrets et chaîne d’approvisionnement

Chaque groupe : ids, pire bande, pire statut, une action de sponsor (financer, fournir un second tenant, accepter).

Un groupe sans finding = « rien de scoré », pas « sain ».

## 5. Ce que le sponsor tranche

Trois cases, pas quinze :

1. Traiter maintenant (P0 Confirmé + P1 Confirmé faciles, F=1–2).
2. Débloquer la mesure (second tenant, compte-test, inventaire MCP).
3. Accepter en connaissance (P3, ou Non testé dont le coût d’accès à la preuve est jugé trop haut — alors le texte le dit).

## 6. Hors cadre

Paiement tiers, revue de code, social engineering, red-team lourd. Une ligne chacun, « non fait, non implicite ».

## 7. Suite de mission

Mode 5 après correctifs. Mode 6 si une origine doit rester sous garde-fou. Mode 8 si un board pack est exigé (il relira ce dossier, il ne retestera pas).

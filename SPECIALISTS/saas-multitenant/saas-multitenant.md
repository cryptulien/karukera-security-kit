---
id: specialist-saas-multitenant
role: specialist
reads: [RULES/*, ENGINE/journal.md, TEMPLATES/finding.md, USAGE.md, brief]
writes: [journal/findings, journal/evidence, LIVRABLES/saas-multitenant-rapport.md]
forbids: [inventer une preuve, sortir du scope, produire un exploit, confirmer une isolation sans deux comptes tenants, payload IDOR, accès à des données hors comptes de test]
---

# Spécialiste SaaS multi-tenant

## Mission

Mesure l’isolation entre organisations : données, fichiers, recherche, exports, webhooks, facturation, invitations, rôles. Deux comptes de test appartenant à **deux tenants distincts** sont obligatoires pour tout `Confirmé` d’isolation ou d’IDOR. Sans ces deux comptes, les constats restent `Non testé` ou `Hypothèse`.

## Quand l’appeler

- Le produit a des organisations, workspaces, équipes, cliniques, cabinets, comptes facturés séparément.
- Un Complet SaaS, ou un founder qui demande « un client peut-il voir l’autre ? ».
- Après Express, quand la surface est connue et que l’authz objet est le vrai risque.
- Ne l’appelle pas sur un site vitrine, un blog, ou une API monotenant sans notion d’organisation.
- Ne l’appelle pas avec un seul compte « admin de tout ».

## Checklist déclenchée

Exécute `SPECIALISTS/saas-multitenant/saas-multitenant.checklist.md`. Le gate deux-tenants est le premier item métier. S’il échoue, tu documentes et tu n’inventes pas de Confirmé.

## Méthode

1. **Stop OpenRouter.** Clé absente → STOP + message 30–50 €.
2. **Gate deux tenants.** Exige, dans le brief ou les secrets de mission :
   - Tenant A + utilisateur A1 (rôle courant, pas forcément admin) ;
   - Tenant B + utilisateur B1 ;
   - idéalement A2 (second rôle dans A) pour les invitations / élévation.
   Même e-mail sur deux tenants ≠ deux tenants. Même organisation « demo » recopiée ≠ deux tenants. Si le gate échoue : tous les items d’isolation passent `Non testé` ; une lecture de code ou de doc peut produire des `Hypothèse` uniquement.
3. **Carte des objets.** Liste les ressources qui portent un id : factures, patients / records, fichiers, webhooks, tokens API, invitations, sièges, exports, notes, logs. Une ligne par type. N’invente pas un type non vu.
4. **Isolation lecture.** Avec la session A1, ouvre les URLs / IDs **que B1 t’a montrés** (le brief échange les IDs, ou tu les copies depuis la session B, pas depuis un dump). Une lecture réussie du document B sous session A = finding. Une lecture refusée (403/404 identique) = contrôle observé, note-le comme preuve négative, ce n’est pas un finding.
5. **Isolation écriture / suppression.** Même discipline, actions **légitimes du produit** (renommer, changer un champ prévu). Pas de payload. Succès cross-tenant = finding. Reste sur les objets de test.
6. **Recherche, listes, exports.** Recherche le nom unique d’un objet B depuis A. Export CSV / PDF / zip de A : vérifie qu’aucune ligne B n’apparaît. Logs / audit trail de A : pas d’événements B.
7. **Fichiers et URLs signées.** Télécharge un fichier B avec l’URL obtenue dans B, puis rejoue **la même URL** avec la session A (ou sans session). Consigne. N’essaie pas de forger une signature.
8. **Invitations et rôles.** Crée une invite A vers une boîte de test. Observe : lien réutilisable, expiration, rôle proposé, acceptation cross-tenant, utilisateur B qui s’ajoute à A sans invite, conservation d’accès après révocation. Sans A2, les élévations de rôle restent `Non testé`.
9. **Facturation.** Depuis A, tente l’affichage d’une facture / d’un moyen de paiement / d’un usage dont l’id vient de B. Observe le changement de plan, les sièges, le portail Stripe/Paddle **uniquement** via l’UI prévue. Ne manipule pas l’API du prestataire de paiement.
10. **Webhooks et tokens.** Liste les endpoints webhook et tokens API de A. Vérifie qu’ils n’apparaissent pas dans B. Un secret de webhook B visible dans A = Confirmé si preuve.
11. **Statuts.** Confirmé seulement avec les deux sessions et une preuve (URL + extrait redacté + date). Un schéma d’ID prévisible sans second tenant = `Hypothèse`. Un seul tenant = `Non testé`.
12. **Données.** Tu n’as le droit de voir que les données des comptes de test. Si un id hors test renvoie des données réelles : arrête cet item, redacte, signale au commanditaire, ne parcours pas.

Modèles : analyse Kimi K3.

## Sorties

```yaml
id: MT-006
title: ""
status: Confirmé | Probable | Hypothèse | Non testé | Mitigé | Faux positif
impact: 1-5
exploitability: 1-5
confidence: 1-5
fix_effort: 1-5
visibility: 1-5
priority: 0.0
priority_band: P0 | P1 | P2 | P3
tenants_used: ["A", "B"] # obligatoire pour Confirmé
object_type: invoice | record | file | invite | seat | webhook | export | other
evidence:
  - url: ""
    excerpt: ""
    date: YYYY-MM-DD
notes: ""
```

Livre `LIVRABLES/saas-multitenant-rapport.md` :

- gate deux-tenants : passé / échoué, avec identifiants **de test** seulement ;
- matrice objet × lecture × écriture × liste/recherche × export (Confirmé / contrôle observé / Non testé) ;
- invitations, rôles, facturation, webhooks ;
- findings triés par priorité ;
- si gate échoué : zéro Confirmé d’isolation, couverture isolation affichée à 0 %.

## Pièges

- Un seul compte superadmin « qui voit tout » pris pour une preuve d’IDOR. C’est le rôle, pas l’isolation.
- Confirmer un IDOR parce que l’id est un entier. Sans lecture cross-tenant, c’est `Hypothèse`.
- Envoyer un payload (`../`, id négatif massif, injection). Change d’id **fourni par l’autre tenant**, rien d’autre.
- Lire des données hors comptes de test. Stop item.
- Tester Stripe en live sur de vrais clients. Portail de test seulement.
- Oublier recherche / export : l’UI d’un objet peut être isolée et l’export ne pas l’être.

## Exemple de finding fictif

```yaml
id: MT-006
title: GET /api/invoices/{id} de B renvoie 200 sous la session A
status: Confirmé
impact: 5
exploitability: 4
confidence: 5
fix_effort: 3
visibility: 2
priority: 37.0
priority_band: P0
tenants_used: ["A", "B"]
object_type: invoice
evidence:
  - url: https://app.example-client.test/api/invoices/inv_b_19c2
    excerpt: "HTTP/2 200 ; {\"id\":\"inv_b_19c2\",\"tenant\":\"B-démo\",\"total\":14900}"
    date: 2026-03-18
notes: >
  Session cookie de A1. ID copié depuis l’écran facture de B1 (compte de test).
  Aucun autre id essayé. Montant et raison sociale de la démo B visibles.
  Extrait limité à l’objet de test.
```

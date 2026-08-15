---
id: specialist-saas-multitenant-checklist
role: specialist
reads: [SPECIALISTS/saas-multitenant/saas-multitenant.md, RULES/*, ENGINE/journal.md, brief]
writes: [journal/findings, journal/evidence, LIVRABLES/saas-multitenant-rapport.md]
forbids: [inventer une preuve, confirmer sans deux tenants, produire un exploit, lire des données hors comptes de test]
---

# Checklist — SaaS multi-tenant

## Mission

Prouve ou infirme l’isolation avec deux tenants de test. Sinon `Non testé` / `Hypothèse`.

## Quand l’appeler

Produit multi-organisation, deux comptes de test promis ou à exiger tout de suite.

## Méthode

### Stop et gate

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] Scope et autorisation relus. Données hors test interdites.
- [ ] Tenant A + user A1 identifiés. Tenant B + user B1 identifiés. Organisations distinctes vérifiées.
- [ ] Gate échoué → tous les items d’isolation `Non testé` ; lecture doc/code = `Hypothèse` seulement. Aucun Confirmé d’IDOR / isolation.
- [ ] A2 (second rôle dans A) noté présent ou absent. Absent → élévations `Non testé`.

### Carte et discipline

- [ ] Types d’objets réellement vus listés (pas un catalogue fantaisiste).
- [ ] IDs échangés depuis les sessions de test, jamais devinés en masse.
- [ ] Aucun payload offensif. Aucune signature forgée.

### Isolation

- [ ] Lecture : chaque type d’objet critique, ID de B sous session A. 200 croisé = finding ; 403/404 identique = contrôle observé.
- [ ] Écriture / suppression : action produit normale sur objet B sous session A.
- [ ] Listes et recherche : nom unique de B cherché depuis A.
- [ ] Export / CSV / PDF / zip de A : aucune ligne B.
- [ ] Fichier / URL signée de B rejouée sous A et en anonyme.
- [ ] Audit log / activité de A : pas d’événements B.

### Invitations, rôles, billing

- [ ] Invite A : réutilisation du lien, expiration, rôle proposé.
- [ ] Acceptation depuis une boîte de test. B qui rejoint A sans invite testé ou `Non testé`.
- [ ] Révocation : accès de l’invité retiré réellement.
- [ ] Élévation de rôle seulement si A2 existe.
- [ ] Facture / moyen de paiement / usage : id B sous session A.
- [ ] Sièges et plan : actions UI prévues uniquement, pas l’API du PSP.
- [ ] Webhooks et tokens API de B invisibles depuis A.

### Clôture

- [ ] Tout Confirmé d’isolation porte `tenants_used: [A, B]` + URL + extrait redacté + date.
- [ ] Données hors test rencontrées : item stoppé, extraits redactés, commanditaire prévenu.
- [ ] Matrice objet × action dans le livrable. Gate échoué → couverture isolation 0 %.
- [ ] Scores I/E/C/F/V, C plafonné, journal append-only.

## Sorties

Matrice d’isolation. Findings avec tenants. Rapport. Zéro Confirmé si le gate a échoué.

## Pièges

- Superadmin pris pour un IDOR.
- Entier auto-inc pris pour une preuve.
- Export oublié.
- Vraies données client ouvertes.

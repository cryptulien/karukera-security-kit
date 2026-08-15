---
id: specialist-implementation-companion-checklist
role: specialist
reads: [SPECIALISTS/implementation-companion/implementation-companion.md, ENGINE/journal.md, LIVRABLES/, brief]
writes: [LIVRABLES/plan-correctifs.md, LIVRABLES/prs/, journal/fix-tasks]
forbids: [inventer un finding, produire un exploit, réécrire un finding, PR mammouth non découpée]
---

# Checklist — Compagnon d’implémentation

## Mission

Découper le rapport en PRs guidées, défensives, priorisées. Pas d’audit nouveau.

## Quand l’appeler

Dès qu’un journal contient des findings à corriger.

## Méthode

### Stop et ingest

- [ ] `sh bin/check-openrouter-key.sh` → `status=present`. Sinon STOP + message canonique.
- [ ] Journal / rapport présents. Vides → STOP, renvoyer vers l’audit.
- [ ] Confirmé sans preuve → ne pas planifier comme Confirmé ; signaler le trou, renvoyer à l’auteur.
- [ ] Aucun finding ajouté.

### Tri

- [ ] `Faux positif` exclus. `Mitigé` = déjà fait, ligne « ne pas rouvrir ».
- [ ] `Hypothèse` / `Non testé` = file « à mesurer », zéro PR de code.
- [ ] Scores repris tels quels. Calcul uniquement si absent, formule écrite.
- [ ] Bandes P0–P3 appliquées sur `priority`, pas au feeling.

### Découpe

- [ ] Chaque Confirmé / Probable a au moins une fiche FIX ou une carte ops.
- [ ] Taille S/M. L seulement avec justification de non-découpe.
- [ ] Secret : rotation séparée du retrait de code.
- [ ] Headers / config plateforme non mélangés à une feature métier.
- [ ] Authz : une PR par objet ou par policy partagée, pas « toute l’authz ».
- [ ] Dépendances dans le bon ordre (rotation avant retrait, isolation avant nouvelle API).

### Guidage

- [ ] Couches / fichiers probables nommés sans inventer un path hors repo visible.
- [ ] Critères d’acceptation **défensifs** (403/404, absence de secret, header présent).
- [ ] Zéro payload, zéro script de pentest dans les fiches.
- [ ] Hors code (PSP, DNS, prestataire) = carte ops, pas une fausse PR.

### Clôture

- [ ] Tickets `livrables/tickets/` avec prompt à coller, zéro payload ; plan + fiches PR.
- [ ] Journal : `fix-task` en append. Findings intacts.
- [ ] Rappel écrit : le retest après merge = `delta-reaudit`.
- [ ] Pas de délai inventé.

## Sorties

Plan par vagues, fiches PR, file à mesurer, cartes ops. Findings d’origine inchangés.

## Pièges

- PoC « qui sert de test ».
- P0 politique.
- Mitigé anticipé.
- Une seule PR pour tout.

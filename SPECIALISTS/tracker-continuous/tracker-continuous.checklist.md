---
id: specialist-tracker-continuous-checklist
role: specialist
reads: [SPECIALISTS/tracker-continuous/tracker-continuous.md, ENGINE/journal.md, journal/snapshots, brief]
writes: [journal/snapshots, LIVRABLES/snapshot-YYYY-MM.md, LIVRABLES/seuils.md]
forbids: [se présenter comme un SOC, service hébergé, réécrire un snapshot, inventer une couverture, audit complet déguisé]
---

# Checklist — Tracker continu

## Mission

Photographier le journal et quelques sondes. Comparer. Signaler les seuils. S’arrêter.

## Quand l’appeler

Cadence mensuelle (défaut) ou post-release écrite. Jamais en 24/7.

## Méthode

### Stop et contrat

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] Disclaimer écrit : local, pas un SOC, pas hébergé, pas temps réel.
- [ ] Cadence lue. Run < 6 jours sans release → demander confirmation.
- [ ] Refuse toute demande de pager / SLA / sonde hébergée Karukera.

### Premier run / runs suivants

- [ ] Premier run : `LIVRABLES/seuils.md` créé avec les seuils défaut (P0 nouveau, +1 P1, −10 pts couverture, HSTS/`security.txt` perdu, secret encore servi, trou 45 jours).
- [ ] Brief qui change un seuil : nouvelle version append, ancienne conservée.
- [ ] Snapshot précédent chargé s’il existe. Jamais modifié.

### Mesure

- [ ] Compteurs ouverts : Confirmé, Probable, bandes P0–P3, sur le **dernier** statut de chaque id racine.
- [ ] Mitigé / FP totaux depuis le début.
- [ ] Couverture = celle du dernier audit, ou `inconnue`. Jamais inventée.
- [ ] Confiance = moyenne des Confirmé+Probable ouverts seulement.
- [ ] Sondes GET uniques : HSTS sur l’entrée, `security.txt`, URL de preuve d’un secret encore ouvert. Pas d’autre crawl.

### Comparaison et suite

- [ ] Table précédent / actuel / delta / seuil.
- [ ] Seuil franchi → recommandation d’agent (`delta-reaudit`, `express`, `saas-multitenant`), pas un mail automatique.
- [ ] Fichier `journal/snapshots/YYYY-MM-DD.yaml` + livrable humain.
- [ ] Append-only. Correction = nouveau snapshot qui référence l’ancien.

## Sorties

Snapshot YAML, livrable du mois, seuils (premier run). Recommandations, pas d’alerte live.

## Pièges

- Complet furtif.
- Couverture cosmétique.
- « On surveille pour vous ».
- Réécriture de l’histoire.

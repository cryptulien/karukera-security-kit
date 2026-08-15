---
id: specialist-delta-reaudit-checklist
role: specialist
reads: [SPECIALISTS/delta-reaudit/delta-reaudit.md, RULES/*, ENGINE/journal.md, ENGINE/resume.md, journal/previous, brief]
writes: [journal/findings, journal/evidence, journal/delta, LIVRABLES/delta-rapport.md]
forbids: [inventer une preuve, réécrire l’historique, supprimer un finding, produire un exploit]
---

# Checklist — Delta / Réaudit

## Mission

Reteste sans réécrire. Chaque changement de statut est une ligne nouvelle.

## Quand l’appeler

Dès qu’un journal antérieur existe et qu’on demande « qu’est-ce qui a bougé ? ».

## Méthode

### Stop et charge

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] Journal précédent localisé. Absent → STOP, oriente Express / Complet.
- [ ] `ENGINE/resume.md` suivi si la mission précédente était coupée.
- [ ] Inventaire `id + statut courant` dressé. Aucun rename.

### File de retest

- [ ] Tous les `Confirmé` listés.
- [ ] Tous les `Probable` listés.
- [ ] `Non testé` dont le bloqueur a disparu listés, avec la raison (« 2ᵉ tenant fourni », « session admin fournie »).
- [ ] `Hypothèse` exclues sauf brief + temps restant après la file.
- [ ] `Mitigé` / `Faux positif` exclus sauf seuil tracker ou brief « régression ».

### Exécution

- [ ] Chaque item de la file rejoué sur la **même** URL / même observation.
- [ ] Preuve fraîche : URL + extrait + **date du jour**.
- [ ] Nouvelle entrée avec `supersedes`, `previous_status`, `new_status`. Ancienne ligne intacte.
- [ ] Mitigé seulement si le comportement n’est plus reproductible. Le dire du dev ne suffit pas.
- [ ] URL morte : cherche l’emplacement de remplacement annoncé dans le brief ; sinon `Probable` + note, pas Mitigé silencieux.
- [ ] Constat nouveau uniquement s’il apparaît pendant un retest. Marqué `origin: retest`.

### Clôture

- [ ] Aucun fichier d’historique réécrit, tronqué, « nettoyé ».
- [ ] Scores recalculés sur les **nouvelles** entrées. C plafonné par le nouveau statut.
- [ ] `LIVRABLES/delta-rapport.md` : file, tableau de passage, régressions en tête, bloqueurs restants.
- [ ] Phrase explicite : « Historique non modifié. »

## Sorties

Journal allongé. Rapport delta. Zéro overwrite. File Confirmé/Probable + Non testé testables épuisée ou explicitement reportée.

## Pièges

- Complet furtif.
- Mitigé sur parole.
- Date de preuve recyclée.
- Delete « pour faire propre ».

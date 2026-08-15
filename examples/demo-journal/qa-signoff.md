---
qa:
  passed: true
  reviewer: squad-10-adversarial-qa
  date: 2026-04-12
  project: prj-demo-boutique
  findings_reviewed: 3
---

# Sign-off Double QA — demo-boutique

**Fictif.** Revue pédagogique des trois findings d’exemple.

## Contrôles

| # | Contrôle | ok / ko | Note |
| --- | --- | --- | --- |
| 1 | Chaque Confirmé a ≥ 1 preuve url + excerpt + date | ok | F-001 E-001 ; F-002 E-002 |
| 2 | Aucun extrait inventé hors étiquette fictif | ok | Tout le dossier porte `fictif: true` |
| 3 | Plafonds de C | ok | Confirmé C=5 ; Non testé C=1 |
| 4 | Priority recalculées | ok | 29,0 / 26,5 / 23,0 = cas B, C, H |
| 5 | Aucun payload | ok | Probe d’id lisible, pas d’injection |
| 6 | Isolation sans second tenant | ok | F-003 reste Non testé ; `tenants_available: 1` |
| 7 | 09 a tourné | ok | Entrée de couverture : surface agent absente (démo) |
| 8 | Mode 7 | ok | Sans objet (`authorized: no`, pas de tests actifs) |
| 9 | Deux jauges | ok | couverture 9/12 ; confiance de mission 3 |
| 10 | Périmètre | ok | example.com + hôtes fictifs du brief |

## Décision

PASS. Trois findings cohérents avec le contrat. Aucun Confirmé d’isolation. Le board peut citer F-001 et F-002 comme faits d’illustration, F-003 comme précondition manquante.

Findings déclassés : néant.  
Renvoyés : néant.

## Signature

`squad-10-adversarial-qa` · modèle budget `moonshotai/kimi-k3` · 2026-08-15T16:40:00Z  
Recopié dans `examples/demo-project.yaml` → `qa.passed: true`.

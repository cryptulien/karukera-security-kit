# Sign-off Double QA

Fichier courant : `projects/<slug>/journal/qa/signoff.md`. Un refus antérieur se conserve sous `journal/qa/signoff-YYYY-MM-DD.md`.

```yaml
---
qa:
  passed: false
  reviewer: squad-10-adversarial-qa
  date: 2026-01-01
  project: prj-slug
  findings_reviewed: 0
---
```

`qa.passed` reste `false` tant qu’une case ci-dessous échoue. L’agent `11` et le mode 8 lisent ce booléen, pas l’humeur du chat.

## Contrôles (tous obligatoires)

| # | Contrôle | ok / ko | Note |
| --- | --- | --- | --- |
| 1 | Chaque Confirmé a ≥ 1 preuve `url` + `excerpt` + `date` | | |
| 2 | Aucun extrait n’est inventé, générique ou copié d’un autre projet | | |
| 3 | C respecte le plafond du statut (Hypothèse ≤ 2, Probable ≤ 3, Non testé = 1) | | |
| 4 | Chaque `priority` recalculée égale le champ écrit | | |
| 5 | Aucun payload / exploit / PoC dans le journal | | |
| 6 | Isolation : aucun Confirmé trans-tenant si `tenants_available < 2` | | |
| 7 | Mode 4 / 3 : 09 a tourné (entrée journal) | | |
| 8 | Mode 7 : `authorization.md` présent et `authorized: yes` à la date des tests | | |
| 9 | Couverture et confiance de mission sont deux chiffres distincts | | |
| 10 | Périmètre : aucune preuve hors `scope.hosts` | | |

Un seul `ko` ⇒ `passed: false`. Liste alors les ids à reprendre. N’édite pas les findings toi-même pour « aider » sauf à ouvrir des `status-change` justifiés (Confirmé sans preuve → tu déclasse, tu ne fabriques pas la preuve).

## Décision

- Décision : `PASS` ou `REFUS`.
- Motif en 3–8 lignes.
- Findings déclassés par la QA (ids + ancien / nouveau statut).
- Findings renvoyés à l’agent métier.

## Signature

Agent QA, modèle utilisé (nom OpenRouter), date UTC. Recopie `qa.passed` dans `project.yaml` **seulement** après un PASS.

Si un finding ou une preuve est ajouté après `date`, ce sign-off est caduc. Nouveau fichier, nouvelle revue.

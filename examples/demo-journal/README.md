# Journal fictif — demo-boutique

**Tout ce dossier est fictif.** Aucune cible réelle n’a été attaquée. `example.com` sert d’origine d’illustration publique. `api-fictive.example` et `app-fictive.example` n’existent pas.

Projet : `examples/demo-project.yaml` (`prj-demo-boutique`).  
Mode source : Complet SaaS (03). Un seul tenant fourni. 09 a tourné : aucune surface agent. QA passée le 2026-04-12. Board : `examples/demo-report-board.md`.

## Contenu

| Fichier | Rôle |
| --- | --- |
| `finding-01.md` | F-001 — CSP absente sur example.com (Confirmé, P1) |
| `finding-02.md` | F-002 — 500 verbeuse sur API fictive (Confirmé, P1) |
| `finding-03.md` | F-003 — isolation multi-tenant (Non testé, P2) |
| `qa-signoff.md` | Double QA `passed: true` |

Les preuves sont embarquées dans les fiches (champ `evidence`) pour rester lisibles hors d’un dossier `projects/`. Dans une mission réelle, chaque preuve vit aussi sous `journal/evidence/E-NNN-*.md`.

## Scores

Voir les cas B, C, H de `ENGINE/score.md`.

## Ne pas faire

- Recopier ces faits sur un client réel.
- Prendre `tenants_available: 1` + F-003 Confirmé : le kit l’interdit.
- Oter l’étiquette `fictif`.

# Entrée de journal

Copie vers `projects/<slug>/journal/entries/<YYYY-MM-DDTHHMMSSZ>-<agent>-<action>.md`. N’édite jamais une entrée déjà écrite.

```yaml
---
id: J-20260101-001
ts: 2026-01-01T00:00:00Z
agent: squad-00-orchestrator
action: open
mode: 01-express
reads: []
writes: []
alerte: aucune
---
```

- `action` : `open` | `collect` | `find` | `score` | `status-change` | `qa` | `report` | `resume` | `snapshot` | `close` | `note`.
- `mode` : `01-express` … `08-rapport-board`.
- `reads` / `writes` : chemins relatifs au projet.
- `alerte` : `aucune` | `P0` | `P1` | `nouvelle-surface` | `qa-requise` | `portail-ferme` (mode 6 et 7 surtout).

## Fait

Ce qui s’est passé. Dates, URLs, ids. Pas de secret en clair. Pas de payload.

## Suite

Prochain agent, ou STOP avec motif (clé absente, QA, AUTHORIZED, tenants).

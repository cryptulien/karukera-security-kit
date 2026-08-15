# Finding

Copie ce fichier vers `projects/<slug>/journal/findings/F-NNN-slug.md`. Remplis tous les champs. Ne laisse aucun blanc. Calcule `priority` avec `ENGINE/score.md`.

```yaml
---
id: F-000
title: ""
status: Non testé
fictif: false
asset: ""
impact: 1
exploitability: 1
confidence: 1
fix_effort: 1
visibility: 1
priority: 0.0
band: P3
evidence: []
notes: ""
---
```

- `id` : `F-NNN` local au projet.
- `title` : une ligne, fait observable, pas un nom de CVE inventé.
- `status` : `Confirmé` | `Probable` | `Hypothèse` | `Non testé` | `Mitigé` | `Faux positif`.
- `fictif` : `true` si exemple de kit ou hors cible réelle.
- `asset` : URL ou surface (hôte + chemin, cookie, tool MCP).
- `impact` (I), `exploitability` (E), `confidence` (C), `fix_effort` (F), `visibility` (V) : entiers 1–5. C plafonné par le statut.
- `priority` : `10*(0.30*I + 0.25*E + 0.20*C + 0.15*V) - 2*F`, un décimal.
- `band` : `P0` | `P1` | `P2` | `P3`.
- `evidence` : tableau d’objets `{id, url, excerpt, date}` (`SCHEMAS/finding.schema.json`). Confirmé ⇒ au moins une preuve complète (url + excerpt + date).
- `notes` : calcul de priority en clair + limites. Pas de payload.

## Constat

Quel fait as-tu vu, où, quand. Une surface, un comportement. Pas un roman. Pas d’étapes d’exploitation.

## Pourquoi c’est un risque

Impact métier en une courte clause. Relie I à quelque chose que le client reconnaît (compte, tenant, secret, réputation).

## Preuves

Tableau ou liste : id, URL, date, extrait déjà stocké dans `journal/evidence/`. N’invente pas un extrait ici.

## Remédiation

Action vérifiable (poser une CSP, cacher la stack, refuser l’objet d’un autre tenant). Effort cohérent avec F. Critère de sortie : ce que le mode 5 re-GET pour passer à Mitigé.

## Limites

Ce que tu n’as pas testé. Si statut Non testé : quelle précondition manque (second tenant, compte, autorisation).

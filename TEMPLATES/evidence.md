# Preuve

Copie vers `projects/<slug>/journal/evidence/E-NNN-slug.md`. Append-only : une fois écrit, tu n’édites plus ce fichier.

```yaml
---
id: E-000
url: ""
surface: ""
excerpt: ""
date: 2026-01-01
method: GET
content_type: ""
http_status: 0
finding_ids: []
agent: squad-01-surface-mapper
fictif: false
---
```

- `url` : URL exacte observée. Si le fait n’a pas d’URL (cookie, tool), remplis `surface` et mets `url` à la page qui l’a révélé.
- `excerpt` : texte réellement reçu, tronqué. Secrets masqués (`sk_live_ab12…`). Pas de dump. Pas de payload.
- `date` : jour UTC de l’observation (`YYYY-MM-DD`).
- `method` : `GET` | `HEAD` | `OPTIONS` | `lecture-js` | `lecture-header` | `lecture-manifest` | `compte-test-documenté`.
- `http_status` : 0 si non HTTP.
- `finding_ids` : liste `F-NNN` qui s’appuient sur cette preuve.
- `fictif` : `true` pour les exemples du kit.

## Contexte

Une phrase : pourquoi ce GET, dans quel bloc de `ENGINE/collect.md` ou quel agent.

## Extrait

Bloc cité, borné. Indique ce qui manque (« en-tête CSP absent » est un fait si tu listes les en-têtes réellement présents).

## Chaîne

Qui a collecté (`agent`), à quelle date. Toute ré-observation = **nouvelle** preuve, nouvel id.

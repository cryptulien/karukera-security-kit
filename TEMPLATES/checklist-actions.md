# Checklist d’actions

Écris `projects/<slug>/livrables/checklist-actions.md`. Une ligne = une action vérifiable, issue d’un finding. Interdit d’ajouter une action sans `F-NNN`.

Tri : bande puis priority décroissante.

| # | finding | action | owner | F | bande | critère de sortie | état |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | F-000 |  | à nommer par le client | 1 | P3 | GET … montre … | ouverte |

- `owner` : rôle réel (`tech-lead`, `devops`). Si inconnu : `à nommer par le client`, jamais un nom inventé.
- `état` : `ouverte` | `en cours` | `vérifiable` | `fermée`. `fermée` seulement après une preuve de re-GET (mode 5) et un `status-change` → Mitigé.
- Pas de sous-tâche cachée. Si deux équipes, deux lignes, même finding permis.

Bloc de suivi (bas de fichier) : date de dernière revue, entrée journal associée, nombre d’actions encore ouvertes par bande.

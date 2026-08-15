# Plan d’implémentation — fond à transposer

Destination : `projects/<slug>/livrables/plan-implementation.md`.  
Public : tech lead, devops, appsec. Interdit sans QA. Chaque ligne descend d’un `F-NNN`.

## 1. Ordre

Travaille par vagues, pas par envie.

| Vague | Entrée | Sortie | Findings |
| --- | --- | --- | --- |
| 0 — hygiène immédiate | aujourd’hui | en-têtes / stacks cachées / secrets retirés du JS | F à F=1 |
| 1 — P0 Confirmé | cette itération | critères de sortie verts en mode 5 | |
| 2 — P1 Confirmé | itération suivante | idem | |
| 3 — débloquer la mesure | le sponsor fournit préconditions | Non testé rejoués | |
| 4 — P2 / P3 | backlog | | |

Recopie les ids. Une vague vide s’écrit `néant`, elle ne disparaît pas.

## 2. Tickets

Pour chaque finding des vagues 0–2 (et les Confirmé P2 si peu nombreux), un fichier `livrables/tickets/TICKET-NNN.md` (`TEMPLATES/fix-ticket.md`) :

- id, titre, bande, F, finding source
- action (verbe + artefact : « poser `Content-Security-Policy` sur l’origine X »)
- owner : rôle du brief ou `à nommer par le client`
- prérequis (fenêtre, feature flag, second tenant)
- critère de sortie = la re-observation non destructive (GET de la preuve, ou relecture du fichier)
- **prompt à coller** dans le LLM de correctif — déjà rédigé, sans payload
- risque de régression (ce que le mode 6 surveillera)

Pas de snippet d’exploit pour « tester le ticket ». Un test interne du client peut exister : tu n’en écris pas le payload ici.

## 3. Isolation

Si mode 3 / tenancy :

- `tenants_available` recopié
- si < 2 : vague 3 = « fournir org B » avant tout ticket Confirmé d’IDOR
- si ≥ 2 : tickets d’isolation en vague 1 dès qu’un Confirmé existe

## 4. Agents / MCP

Si 09 a tourné : une table tools → action (borner le filesystem, séparer l’identité de service, retirer un tool du manifest). Un tool non revu reste une ligne Non testé, pas un oubli.

## 5. Vérification

Le client ne te croit pas sur parole. Prévois une passe mode 5 : snapshot, re-GET, `status-change` vers Mitigé, delta. La checklist (`TEMPLATES/checklist-actions.md`) est le tableau opérationnel de ce plan. Les deux doivent porter les mêmes ids.

## 6. Ce que ce plan ne fait pas

Il ne remplace pas le journal. Il ne change pas un statut. Il ne calendrier pas d’amende. Il ne promet pas une date si le client n’en a pas donnée.

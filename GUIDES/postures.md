# Trois approches, une mission

Le kit ne commence pas par une liste de modes internes. Tu choisis **quoi regarder**. L’orchestrateur traduit ensuite vers un mode (`config/mission-modes.yaml`).

On peut combiner les trois. Ce qui n’est pas choisi reste `Non testé`.

## Extérieur

Ce que voit un inconnu : pages publiques, en-têtes, JS servi, fichiers exposés, login.

- Pas besoin de compte.
- Mode typique : `01-express` ou `02-complet-web`.

## Code

Le dépôt **local**, chez toi. L’agent lit les fichiers. Preuve = chemin + extrait + date, pas un payload.

- Fournis un chemin dans le brief (`scope.code_path`), jamais dans le chat si le dossier contient des secrets.
- Spécialiste : `SPECIALISTS/code-source/`.
- S’ajoute à un mode Express / Complet / Red-team. Ce n’est pas un mode à part.

## Intérieur

Depuis un compte réel du SaaS : un utilisateur, deux tenants, un admin.

- Sert à l’authz, l’isolation, « ce que voit le client A vs le client B ».
- Sans compte : ces tests restent `Non testé`. Ne les invente pas.
- Mode typique : `03-complet-saas`. Red-team : `07-redteam-leger` + mandat.

## Accès utilisateurs — hors chat

E-mails et rôles : `projects/<slug>/brief.md`.

Mots de passe, cookies, tokens de session : `projects/<slug>/accounts.local.md` (modèle `TEMPLATES/accounts.local.md`). Jamais le chat. L’agent peut lire ce fichier pour se connecter. Il ne le recopie pas, ne le journalise pas, ne l’écrit pas dans un rapport.

Mieux : tu es déjà connecté dans le navigateur que l’agent pilote. Alors le fichier peut rester vide.

## Profondeur

| Tu dis | Mode |
| --- | --- |
| Express, premier signal | `01-express` |
| Complet, site / app | `02-complet-web` |
| Complet, SaaS / orgs / intérieur | `03-complet-saas` |
| Agents, MCP, skills | `04-agents-mcp` |
| Re-audit après correctifs | `05-delta` |
| Garde-fou périodique | `06-continuous` |
| Exercice adverse (mandat écrit) | `07-redteam-leger` |
| Synthèse décideur, plus de test | `08-rapport-board` |

## Phrase type

> Audite ce projet chez moi. URL : https://app.exemple.tld. Code : ./mon-app. Complet. Extérieur + intérieur. Les comptes sont dans le brief, pas ici.

Remplace l’URL et le chemin. N’invente aucun compte.

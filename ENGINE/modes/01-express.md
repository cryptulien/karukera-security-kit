---
id: mode-01-express
reads: [RULES/*, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md, ENGINE/projects.md]
writes: [journal/entries, journal/findings, journal/evidence, journal/surface.md, journal/coverage.md]
forbids: [inventer une preuve, sortir du scope, produire un exploit, prétendre à un audit complet]
---

# Mode 1 — Express

Passe courte sur une origine publique. Sert à un tri, pas à un certificat. Dis-le dès la première entrée.

## Quand l’ouvrir

- Un founder veut savoir « s’il y a un trou évident » avant une démo.
- Un freelance prépare un devis et doit borner le vrai chantier.
- Le périmètre tient en une origine, sans compte-test, sans second tenant.

N’ouvre pas ce mode pour un SaaS multi-tenant, un produit MCP, ou un rapport board. Oriente vers 03, 04 ou 08.

## Portails

1. Clé OpenRouter présente. Sinon STOP.
2. Périmètre écrit (`brief.md` ou `project.yaml`). Sinon STOP.
3. Usage autorisé (`USAGE.md`) : système que l’humain contrôle.
4. `scope.code_path` présent → `SPECIALISTS/code-source` après la surface. Absent → code `Non testé`.

Pas de `AUTHORIZED=yes` au sens du mode 7 : tu restes en **observation** (`GET`/`HEAD`/`OPTIONS` lecture).

## Pipeline

Durée cible : une session. Plafond collecte : 80 URLs HTML / origine.

| Étape | Agent | Obligatoire |
| --- | --- | --- |
| 0 | `squad-00-orchestrator` | oui — ouvre le projet, pose le mode |
| 1 | `squad-01-surface-mapper` via `ENGINE/collect.md` blocs 1–4 et 7 | oui |
| 2 | `squad-02-threat-modeling` (version courte) | oui |
| 3 | `squad-03-audit-onpage` | oui |
| 7 | `squad-07-config-secrets` (JS : secrets masqués, source maps) | oui si un bundle in-scope existe |
| — | Score (`ENGINE/score.md`) sur chaque finding | oui |
| 10 | `squad-10-adversarial-qa` | oui, version courte : chaque Confirmé a une preuve |
| 11 | `squad-11-rapport-final` | seulement si `qa.passed=true` |

N’enchaîne pas 04-auth-session, 05-authz-privilege, 06-api-backend, 08-supply-chain, 09-agent-mcp-skills, ni le spécialiste `saas-multitenant`. S’ils apparaissent dans le JS, ouvre des findings **Non testé** ou **Hypothèse** et recommande le mode 2 ou 3.

`09` : si une surface agent / MCP / skill est **détectée**, crée un finding Non testé « surface agent hors mode Express » et signale le mode 4. Ne l’audite pas ici.

## Couverture attendue

- Planifié : fichiers de politique + accueil + 1 page interne publique + 1 probe 404 + en-têtes de ces classes.
- `coverage.confidence_globale` ≤ 2. Écrire ce plafond dans `coverage.md`. Une Express à confiance 5 est une faute.

## Sorties

- Journal complet (entrées, preuves, findings).
- `reports/exec.md` court (une page) si QA passée.
- Pas de `report-board`. Pas de livrable « audit stratégique » qui imite un complet.

Chaque finding hors observation porte le statut honnête. Le rapport liste explicitement : auth, IDOR, isolation, MCP = **non parcourus**.

## Stop

- Sortie de périmètre demandée par l’humain → refuse.
- Envie d’« aller plus loin » avec un POST d’essai → refuse, propose mode 2/3/7 selon le cas.
- QA refuse un Confirmé → corrige ou déclasse, pas de rapport.

## Exemple de cadrage (fictif)

« Express sur https://example.com, pas de compte, pas d’API authentifiée. » → findings du type CSP absente, `Server` bavard, 404 générique ou non. Tout étiqueté selon le statut réel ; les exemples du kit portent `fictif: true`.

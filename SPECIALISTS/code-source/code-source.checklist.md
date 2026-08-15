---
id: specialist-code-source-checklist
role: specialist
reads: [SPECIALISTS/code-source/code-source.md, RULES/*, brief]
writes: [journal/findings, journal/evidence, journal/coverage]
forbids: [inventer une preuve, sortir de code_path, produire un exploit, utiliser un secret trouvé]
---

# Checklist — Code source

- [ ] `sh bin/check-openrouter-key.sh` → `status=present`
- [ ] `scope.code_path` présent et sur disque. Sinon `Non testé` + stop de ce spécialiste
- [ ] Hors `node_modules/`, `.git/`, caches, builds
- [ ] Secrets commités cherchés, extraits redactés, jamais réutilisés
- [ ] Authn / authz lues dans le code ; Confirmé code-seul limité aux secrets et configs ouvertes
- [ ] IDOR / isolation : `Probable` ou `Hypothèse` tant qu’un test intérieur n’a pas confirmé
- [ ] CORS, debug, CI, lockfiles notés ; passés à 07 / 08 si le mode les a
- [ ] Manifests agent / MCP passés à 09
- [ ] `.env` du kit et `accounts.local.md` non traités comme cible
- [ ] Chaque Confirmé a surface `path:ligne` + extrait + date + `lecture-source`
- [ ] Aucun payload, aucun dump de dépôt

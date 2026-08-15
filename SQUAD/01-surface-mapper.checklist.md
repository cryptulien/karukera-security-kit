# Checklist — 01 Surface Mapper

Coche uniquement ce que tu as observé dans le scope. Sinon laisse décoché et journalise `Non testé`.

- [ ] Hôtes du brief listés ; tout hôte vu hors scope consigné comme `hors-scope`
- [ ] URL racine ouverte : statut, redirections, cookies posés, auth-wall
- [ ] `robots.txt` et `sitemap.xml` lus s’ils existent
- [ ] `/.well-known/` parcouru (security.txt, change-password, oauth-authorization-server, mcp)
- [ ] Crawl borné des liens internes du scope, pages hors auth et pages avec compte de test
- [ ] En-têtes de sécurité relevés par copie sur `/`, une page app, un asset, un endpoint API
- [ ] `Set-Cookie` relevé (noms, flags visibles : Secure, HttpOnly, SameSite)
- [ ] Bundles JS, sourcemaps publics, service workers, workers inventoriés
- [ ] Indices de framework / langage / CDN consignés avec artefact, version seulement si écrite
- [ ] Routes API / SDK JS / GraphQL / Swagger / OpenAPI publics listés
- [ ] Verbes HTTP réellement observés (pas supposés) notés par route
- [ ] Recherche MCP : chemins `/mcp`, SSE, manifests, `mcp.json`, configs client
- [ ] Recherche copilote / chat / « Ask AI » / widgets LLM / function-calling
- [ ] Recherche Skills : `SKILL.md`, `AGENTS.md`, `.cursor/`, `.claude/`, stores de prompts
- [ ] Présence ou absence de surface agent écrite noir sur blanc
- [ ] Fichiers publics sensibles constatés par URL (`/.git/HEAD`, `.env`, lockfiles, backups)
- [ ] Formulaire de login, SSO, reset, inscription repérés pour 04
- [ ] Multi-tenant / IDs dans l’URL repérés pour 05
- [ ] Volume visité vs volume annoncé dans le sitemap : trou de couverture écrit
- [ ] Carte `journal/surface` clôturée et signal 09 envoyé à l’orchestrateur

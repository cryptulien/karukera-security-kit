# Checklist — 07 Config / secrets

Toute clé est masquée. Toute clé est inutilisée.

- [ ] HSTS, X-Content-Type-Options, frame-ancestors / XFO, Referrer-Policy, Permissions-Policy relevés
- [ ] COOP / COEP / CORP relevés s’ils existent
- [ ] CORS : réponse à une origine du scope et à une origine étrangère de démo
- [ ] `Access-Control-Allow-Credentials` croisé avec `Allow-Origin: *`
- [ ] `/.env`, `.env.production`, `config.js`, `window.__ENV` cherchés
- [ ] Préfixes `NEXT_PUBLIC_`, `VITE_`, `REACT_APP_` distingués (public vs secret)
- [ ] `/.git/HEAD` et `/.git/config` : une requête chacun, stop si 404
- [ ] `.svn`, backups, `*.bak`, `*~`, `.DS_Store` cherchés sans téléchargement massif
- [ ] JS : motifs de clés (`sk_live`, `AKIA`, `AIza`, `ghp_`, `BEGIN PRIVATE KEY`)
- [ ] Secrets masqués dans le journal (`***`)
- [ ] Aucune clé réutilisée contre un fournisseur
- [ ] `phpinfo`, toolbar de debug, `server-status` : présence / absence
- [ ] Cache-Control des pages authentifiées
- [ ] Sourcemaps publics déjà vus en 01 relus pour secrets
- [ ] `security.txt` noté (informatif)
- [ ] WebSocket : origine du handshake si un WS applicatif existe
- [ ] Lockfiles publics signalés à 08 ; clés LLM/MCP signalées à 09
- [ ] Items non atteints listés en `Non testé`

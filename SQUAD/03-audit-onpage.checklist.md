# Checklist — 03 Audit on-page

Coche ce qui a été observé. N’envoie aucun caractère de balise, d’événement ou de javascript: comme « test ».

- [ ] Pages publiques et pages authentifiées de test passées en revue
- [ ] Puits `innerHTML` / `outerHTML` / `document.write` / `dangerouslySetInnerHTML` / `v-html` cherchés
- [ ] `eval`, `new Function`, `setTimeout(string)` cherchés dans le JS livré
- [ ] Assignation à `location`, `href`, `src` construits depuis une entrée utilisateur
- [ ] `postMessage` : présence ou absence de contrôle `event.origin`
- [ ] Réflexion d’un témoin alphanumérique dans le HTML (query, nom, message)
- [ ] CSP copiée ; `unsafe-inline`, `unsafe-eval`, wildcards, Report-Only notés
- [ ] Cookies de session : Secure, HttpOnly, SameSite, Domain, Path
- [ ] Cookie de session lisible en JS isolé comme finding si HttpOnly absent
- [ ] Contenu mixte (script / iframe / WS en HTTP sur page HTTPS)
- [ ] HSTS présent ou absent, `max-age` relevé
- [ ] Tokens, clés, PII, e-mails étrangers cherchés dans HTML, JS, state SSR, sourcemaps
- [ ] Secrets éventuels masqués dans le journal (`***`)
- [ ] Iframes d’action : `X-Frame-Options` / `frame-ancestors` / `sandbox`
- [ ] Service worker : scope et origine
- [ ] Widget copilote / chat embarqué inspecté comme page à part si présent
- [ ] Aucun payload XSS rédigé dans le journal ni dans un finding
- [ ] Items non regardés listés en `Non testé`

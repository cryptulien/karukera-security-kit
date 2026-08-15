# Checklist — 06 API / backend

Chaque route testée doit figurer dans 01, l’OpenAPI ou le réseau du front.

- [ ] Catalogue des routes fusionné (01 + réseau + OpenAPI/Swagger)
- [ ] Auth exigée / anonyme relevée par route
- [ ] OPTIONS / Allow observés sur une ressource représentative
- [ ] GET, POST, PUT, PATCH, DELETE essayés **une fois** sur un objet jetable
- [ ] Champ de schéma déjà documenté envoyé en trop (mass assignment ciblé)
- [ ] Même ressource sans auth, puis avec session de l’autre tenant de test
- [ ] Bearer expiré ou mal formé : statut relevé
- [ ] Rate-limit : courte rafale sur login ou endpoint sensible, puis stop
- [ ] GraphQL : existence, auth, une sonde d’introspection, pas de dump
- [ ] Erreur bénigne : stack, chemin, SQL, version — extraits masqués
- [ ] Pagination / `limit` : seulement des valeurs déjà vues dans le front
- [ ] Export CSV / dump : borné au tenant du compte de test
- [ ] Webhook / idempotence observés s’ils sont in-scope
- [ ] Paramètre `debug` / `verbose` seulement s’il apparaît dans le JS
- [ ] Hosts API hors scope (paiement, IdP) non sollicités
- [ ] Aucun flood, aucun fuzz massif
- [ ] Routes vues et non testées listées en `Non testé`

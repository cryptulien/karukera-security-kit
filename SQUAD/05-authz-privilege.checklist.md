# Checklist — 05 Autorisation / privilèges

Deux comptes de test distincts sont le minimum pour tout item cross-tenant. Sinon : `Non testé`.

- [ ] Matrice rôles × objets dressée depuis 02 et l’UI
- [ ] Schéma d’identifiants relevé (id numérique, UUID, slug) sans balayage
- [ ] GET de l’objet de B avec la session de A
- [ ] Mutation non destructive de l’objet de B avec la session de A (si le brief l’autorise)
- [ ] Verbes distincts testés (GET refusé ≠ PUT/PATCH/DELETE refusés)
- [ ] Endpoint API testé, pas seulement le bouton UI
- [ ] Action admin appelée avec un compte low-priv (URL ou verbe déjà exposé)
- [ ] `org_id` / header tenant / sous-domaine permutés entre orgs de test
- [ ] Champ `role` / `is_admin` / `plan` observé dans le client : acceptation ou rejet documenté
- [ ] Liste de membres, fichiers, webhooks, clés API : même protocole A→B
- [ ] Partage de lien / token d’objet : périmètre (auth obligatoire ou non)
- [ ] Impersonation support : présence, trace d’audit, fin de session
- [ ] Principal des tools agents (user vs service vs admin) noté si surface 09
- [ ] 403/404 distingués et consignés (mitigation vs obscurcissement)
- [ ] Aucun ID hors jeu fourni par l’UI ou le brief
- [ ] Aucune donnée de client réel ouverte
- [ ] Extraits masqués, orgs de test nommées comme telles
- [ ] Cases non jouables listées en `Non testé`

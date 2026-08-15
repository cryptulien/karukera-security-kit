# Checklist — 04 Auth / session

Sans compte de test : coche uniquement les portes publiques, le reste en `Non testé`.

- [ ] Portes d’auth inventoriées (password, magic link, SSO, social, tokens API)
- [ ] Messages d’erreur de login comparés (énumération d’e-mail)
- [ ] Rate-limit / lockout constaté ou absent après peu d’essais du compte de test
- [ ] CSRF du formulaire de login observé (token présent / absent)
- [ ] Flags du cookie de session relevés (Secure, HttpOnly, SameSite, Domain, Path, durée)
- [ ] Stockage de session (cookie vs localStorage vs mémoire) identifié
- [ ] JWT visible lu (alg, exp, aud, iss, rôles) sans jeton forgé
- [ ] Reset demandé sur le compte de test : host du lien, token dans l’URL, usage unique
- [ ] Paramètre de redirection post-login / post-reset inspecté (`next`, `redirect`, `returnTo`)
- [ ] MFA : présence, enrollment, accès à une page suivante sans second facteur
- [ ] Identifiant de session comparé avant et après login (fixation)
- [ ] Logout UI suivi d’un appel API avec l’ancien cookie / Bearer
- [ ] Remember-me / refresh : durée et lieu de stockage
- [ ] Impersonation / « login as » support : présence, trace, sortie
- [ ] Jetons et mots de passe masqués dans le journal
- [ ] SSO testé seulement s’il est in-scope et avec un compte de test
- [ ] Aucun stuffing, aucun dictionnaire, aucun contournement de captcha
- [ ] Items inaccessibles listés en `Non testé`

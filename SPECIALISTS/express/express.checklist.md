---
id: specialist-express-checklist
role: specialist
reads: [SPECIALISTS/express/express.md, RULES/*, ENGINE/journal.md, brief]
writes: [journal/findings, journal/evidence, journal/coverage, LIVRABLES/express-rapport.md]
forbids: [inventer une preuve, sortir du scope, produire un exploit, afficher une couverture hors de 25–35 %]
---

# Checklist — Express

## Mission

Coche chaque item pendant la passe 30–45 min. Ce qui n’est pas coché à la fin du timebox devient `Non testé` dans le journal.

## Quand l’appeler

Dès que le spécialiste Express démarre. Ne commence aucune collecte avant la section Stop.

## Méthode

### Stop

- [ ] `sh bin/check-openrouter-key.sh` → `status=present`. Sinon STOP + message 30–50 € + `GUIDES/deposit-key.md`. Pas de Read sur `.env`.
- [ ] Brief lu : cible, autorisation, hors-scope. Sinon STOP.
- [ ] Heure de début notée. Plafond 45 min rappelé à voix haute / dans le journal.

### Surface

- [ ] GET de l’URL d’entrée. Code, redirections, hôte final consignés.
- [ ] `robots.txt`, `sitemap.xml`, `/.well-known/security.txt`, `/.well-known/assetlinks.json` (ou équivalent Apple) : présence, extrait, date.
- [ ] GET unique sur les chemins de fuite triviaux du host du brief : `/.env`, `/.git/HEAD`, `/composer.json`, `/package.json`, `/.DS_Store`, sourcemap `*.js.map` liée depuis le HTML/JS déjà vu.
- [ ] Inventaire des hôtes rencontrés (www, api, cdn, preview). Tout hôte hors brief = hors scope, noté, non poursuivi.
- [ ] Techno visible notée (headers Server / x-powered-by, cookies, générateur HTML). Sans extrapolation « donc CVE ».

### En-têtes d’auth et de sécurité

- [ ] Page d’entrée : HSTS, CSP, frame-ancestors / XFO, nosniff, Referrer-Policy, Permissions-Policy.
- [ ] Réponse d’auth ou page de login si dans le brief : `Set-Cookie` (Secure, HttpOnly, SameSite), `Cache-Control`, `WWW-Authenticate`.
- [ ] API racine si dans le brief : CORS (`Allow-Origin`, `Allow-Credentials`, `Allow-Headers`).
- [ ] Absence consignée comme absence observée, pas comme « mal configuré » tant que la réponse n’est pas en main.
- [ ] Cookies de session : un finding par défaut manquant réellement vu, pas un roman par flag.

### Fuites de secrets

- [ ] HTML et JS publics déjà téléchargés relus pour jetons, mots de passe, `*_SECRET`, `apiKey`, query `access_token`.
- [ ] Sourcemaps publiques : chemins internes, secrets de build. Pas d’exploration d’arbre git.
- [ ] Tout secret trouvé : extrait redacté (préfixe + 4 caractères), URL, date. Secret non réutilisé.
- [ ] Si un secret est Confirmé : première action du rapport = révoquer / rotation, pas « patcher le header ».

### Clôture

- [ ] Timebox respecté (arrêt collecte ≤ 45 min).
- [ ] Findings au schéma `TEMPLATES/finding.md`, scores I/E/C/F/V, `priority` calculée, bande P0–P3.
- [ ] C plafonné par le statut. Pas de Confirmé sans URL + extrait + date.
- [ ] Authz, multi-tenant, logique, mobile, MCP, red-team : au moins une ligne `Non testé`.
- [ ] Couverture affichée entre 25 % et 35 % (valeur unique, justifiée en une phrase).
- [ ] Confiance affichée à part, calculée seulement sur Confirmé / Probable.
- [ ] Rapport court dans `LIVRABLES/express-rapport.md` : 5–12 findings, 3 actions, section « Non fait exprès ».
- [ ] Journal append-only. Aucune réécriture.

## Sorties

Checklist intégralement cochée ou explicitement `Non testé`. Rapport Express + findings + jauge 25–35 %. Pas de rapport board. Pas de `qa.passed`.

## Pièges

- Recoller un Complet « vite fait ».
- Oublier de redacter un secret.
- Afficher une couverture hors contrat.
- Tester hors timebox « pour le plaisir ».

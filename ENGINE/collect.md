# Collecte — crawl, en-têtes, JS, APIs

Instructions d’agent. Pas de code. Pas de payload. Pas d’exploit.

Lis `RULES/` avant d’agir. Sans clé OpenRouter → STOP (`RULES/00-openrouter.md`).

---

## Mission

Dresser l’inventaire factuel du périmètre : pages, en-têtes, cookies, scripts, points d’API, fichiers de politique. Chaque observation devient une preuve horodatée dans le journal. Tu ne juges pas encore (le score vient après). Tu ne sors pas du périmètre.

## Prévol

1. Lis `project.yaml` (ou le brief). Extraire `scope.urls`, `scope.hosts`, `scope.out_of_scope`.
2. Si le mode est `07-redteam-leger` : applique le portail dur de `ENGINE/modes/07-redteam-leger.md`. Sinon, reste en observation non destructive.
3. Confirme que chaque URL de départ est dans le périmètre écrit.
4. Fixe un rythme : au plus une requête toutes les 2 secondes par hôte, sauf consigne plus stricte dans `authorization.md`.
5. Méthodes autorisées ici : `GET` et `HEAD`. Un `OPTIONS` uniquement pour lire `Allow` / `Access-Control-*`. Aucun `POST` / `PUT` / `PATCH` / `DELETE` pendant la collecte, sauf si le brief le demande **et** fournit le corps exact (login de compte-test, jamais un payload d’attaque).

Hors périmètre → tu n’y touches pas. Tu notes « vu, non collecté » dans une entrée de journal.

## Ordre de collecte

Exécute les blocs dans cet ordre. À chaque bloc, écris les preuves **avant** de passer au suivant.

### 1. Fichiers de politique

Pour chaque origine in-scope, récupère s’ils existent (404 est un fait, pas une erreur de ta part) :

| Chemin | Ce que tu notes |
| --- | --- |
| `/robots.txt` | `Allow` / `Disallow` / `Sitemap` |
| `/.well-known/security.txt` | `Contact`, `Expires`, `Policy` |
| `/security.txt` | idem si le well-known est absent |
| `/llms.txt` | ce que le site autorise aux agents |
| `/llms-security.txt` | contact et exclusions pour revue IA |
| `/security-robots.txt` | rythme et chemins interdits aux scanners |
| `/sitemap.xml` et les sitemap index | URLs candidates, **filtrées** par le périmètre |

Une absence se consigne : URL, code HTTP, date. N’invente pas le contenu d’un fichier 404.

### 2. Crawl borné

- Pars des URLs de `scope.urls`.
- Suis les liens `a[href]`, les redirections 3xx (jusqu’à 5 sauts), les `canonical`.
- Reste sur les hôtes de `scope.hosts`. Un CDN d’assets in-scope (JS/CSS) peut être **listé**, pas attaqué.
- Ignore `mailto:`, `tel:`, `javascript:`.
- Ne suis pas un lien clairement `out_of_scope` (paiement tiers, IdP externe hors brief, admin d’un autre produit).
- Plafond : 200 URLs HTML uniques par origine, sauf si le mode Complet lève le plafond dans le brief (alors 800). Au plafond, tu t’arrêtes et tu marques la couverture.
- Classe chaque URL : page publique, page authentifiée (rejet 401/403), asset statique, endpoint API, formulaire, flux de redirection.

Écris `journal/surface.md` (ou mets à jour la projection) : tableau hôte / chemin / verbe observé / code / type / auth requise oui-non.

### 3. En-têtes HTTP

Pour chaque **classe** de chemin (pas forcément chaque URL), un `GET` et lecture des en-têtes de réponse :

- `Content-Security-Policy` / `Content-Security-Policy-Report-Only`
- `Strict-Transport-Security`
- `X-Content-Type-Options`
- `X-Frame-Options` / `frame-ancestors`
- `Referrer-Policy`
- `Permissions-Policy`
- `Cross-Origin-Opener-Policy` / `Cross-Origin-Resource-Policy` / `Cross-Origin-Embedder-Policy`
- `Access-Control-Allow-Origin` et `Access-Control-Allow-Credentials`
- `Cache-Control` / `Pragma` sur les réponses authentifiées
- `Server`, `X-Powered-By`, `X-AspNet-Version`, `Via` (fuite de stack)
- `Set-Cookie` : `Secure`, `HttpOnly`, `SameSite`, `Path`, `Domain`, préfixe `__Host-` / `__Secure-`

Consigne l’extrait **verbatim** (les lignes d’en-tête, pas un résumé). Date et URL obligatoires. Un en-tête absent est un fait : écris « absent » dans l’extrait, ne le déduis pas d’une autre page.

### 4. Cookies

Pour chaque `Set-Cookie` observé :

- nom (pas la valeur de session si elle ressemble à un secret — tronque après 6 caractères + `…`)
- attributs présents / absents
- contexte (page login, page publique, API)

N’essaie pas de forger, de rejouer ou de voler un cookie.

### 5. JavaScript

Pour chaque script in-scope (`script[src]` et bundles liés depuis le HTML) :

1. Note l’URL, le type (`module`, inline, third-party).
2. Cherche, en lecture seule :
   - bases d’API (`https://api.…`, `/api/`, `/v1/`, `graphql`)
   - clés publiquement destinées au front (Stripe `pk_`, maps) — note le **préfixe** et le produit, pas un secret privé
   - jetons qui ressemblent à des secrets (`sk_`, `AKIA`, `-----BEGIN`, `xox`, `ghp_`) : enregistre **l’existence**, le fichier, le voisinage (20 caractères autour, secret masqué). N’utilise pas le secret.
   - source maps (`.map`) exposées
   - noms de routes côté client (React Router, Next.js, etc.)
3. Les scripts inline : même traitement, preuve = extrait court.

Tu ne « testes » pas une clé trouvée. Tu la consigne et tu passes la main au scoring.

### 6. Découverte d’API

Sources, dans cet ordre, toutes en `GET`/`HEAD` :

1. Chemins évidents in-scope : `/openapi.json`, `/openapi.yaml`, `/swagger.json`, `/swagger/v1/swagger.json`, `/api-docs`, `/v3/api-docs`, `/.well-known/openapi`.
2. GraphQL : `GET /graphql` sans corps d’introspection offensive. Si une réponse révèle spontanément le schéma ou une UI GraphiQL, c’est une preuve. N’envoie pas de requête d’introspection construite pour forcer le schéma.
3. Liens et `fetch`/`axios` extraits du JS.
4. Formulaires HTML : `action`, `method`, champs (noms seulement).
5. En-têtes `Link`, redirections vers une API.
6. `OPTIONS` sur un endpoint déjà vu, pour lire les verbes déclarés.

Dresse `journal/apis.md` : verbe observé, chemin, auth exigée (oui / non / inconnu), type (REST, GraphQL, RPC, webhook), preuve.

Si le brief fournit un compte-test : un login **documenté**, puis re-collecte des en-têtes authentifiés. Tu n’inventes pas de compte. Tu n’énumères pas les utilisateurs.

### 7. Pages d’erreur (non destructif)

Un seul `GET` vers un chemin in-scope **certainement inexistant**, de la forme `/karukera-collect-probe-<date>`. Note le code, le `Content-Type`, et si la réponse contient une stack, un chemin disque, une version de framework, une SQL brute. C’est tout. Pas de caractères spéciaux, pas de fuzzing, pas de boucle.

## Sorties obligatoires

Écris, sans écraser une preuve existante :

- `journal/entries/<ts>-collect.md` — ce que tu as fait, les plafonds atteints, les refus.
- `journal/surface.md` — inventaire des URLs / classes.
- `journal/apis.md` — inventaire API.
- `journal/evidence/E-*.md` — une preuve par fait réutilisable (en-têtes d’une origine, un secret masqué, une page 500).
- Mets à jour `project.yaml` : `coverage.planned` = nombre de classes identifiées, `coverage.tested` = nombre effectivement collectées.

Ne rédige **aucun** finding « Confirmé » ici sans preuve déjà écrite. Si tu ouvres un finding pendant la collecte, statut `Hypothèse` ou `Non testé` jusqu’à ce que la preuve soit liée.

## Couverture ≠ confiance

La collecte mesure la **couverture** (ce qui a été vu / ce qui était planifié). Elle ne mesure pas la confiance d’un constat. Un crawl à 100 % avec zéro finding Confirmé est un succès de collecte, pas un certificat de sécurité.

## Interdits

- Sortir du périmètre, « juste pour voir ».
- Produire ou coller un payload d’injection, d’XSS, de SSRF, de désérialisation.
- Envoyer un corps qui n’est pas fourni par le brief.
- DoS, parallélisation agressive, retry en rafale sur 5xx.
- Utiliser un secret découvert.
- Inventer un en-tête, un endpoint ou un extrait.

## Pièges

- Un CDN et l’origine n’ont pas les mêmes en-têtes. Consigne les deux si les deux sont in-scope.
- `example.com` et `www.example.com` sont deux origines.
- Une CSP en `Report-Only` n’est pas une CSP appliquée. Note-le clairement.
- Un 403 n’est pas une preuve d’absence d’endpoint.
- Le HTML d’une SPA peut être vide : la surface réelle est dans le JS.

## Exemple d’entrée (fictif)

Voir `examples/demo-journal/` : en-têtes de `https://example.com` sans CSP, consignés comme preuve `E-001`, finding lié étiqueté **fictif**.

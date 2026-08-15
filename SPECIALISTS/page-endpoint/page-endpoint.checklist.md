---
id: specialist-page-endpoint-checklist
role: specialist
reads: [SPECIALISTS/page-endpoint/page-endpoint.md, RULES/*, ENGINE/journal.md, brief]
writes: [journal/findings, journal/evidence, LIVRABLES/page-endpoint-rapport.md]
forbids: [inventer une preuve, sortir du scope, produire un exploit, élargir à une deuxième ressource]
---

# Checklist — Page / Endpoint

## Mission

Verrouille une ressource, mesure-la, sors. Tout élargissement casse la mission.

## Quand l’appeler

Au lancement du spécialiste Page / Endpoint, avant la première requête.

## Méthode

### Stop et verrou

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] Autorisation et scope écrits relus.
- [ ] Le brief contient **une** URL ou **un** verbe+chemin. Sinon refuse et demande de choisir.
- [ ] Ressource canonique écrite en tête du journal. Relue à chaque requête.

### Prise de contact

- [ ] Une requête légitime anonyme. Statut, en-têtes, extrait, date.
- [ ] Si le brief fournit une session : une requête authentifiée, mêmes champs.
- [ ] Sans session sur ressource protégée : le reste authentifié = `Non testé`, pas d’invention de 200.
- [ ] Redirect 3xx : cible notée, non auditée comme nouvelle page.

### Contrat d’accès

- [ ] Rôle attendu (anonyme / user / admin / service) écrit d’après le brief, pas d’après l’intuition.
- [ ] Écart observé (200 anonyme, 500 au lieu de 401, 200 pour un rôle trop bas) consigné avec preuve.
- [ ] 401/403 attendu consigné comme contrôle, pas comme finding.

### Contenu et cache

- [ ] `Cache-Control`, `Vary`, `ETag`, `Set-Cookie` sur la réponse.
- [ ] Finding si réponse authentifiée ou personnelle est `public` / sans `private`.
- [ ] En-têtes de sécurité présents sur **cette** réponse (pas « le site en général »).
- [ ] Corps : données personnelles, secrets, stack trace, chemins internes, tokens. Extrait redacté.

### Surface d’entrée (observation)

- [ ] Paramètres query, champs JSON, en-têtes custom, fichiers : listés.
- [ ] Aucun payload d’injection envoyé.
- [ ] Erreur verbeuse sur usage **normal** du compte de test : extraite.
- [ ] `Allow` / `OPTIONS` seulement s’il arrive tout seul ou si le brief le demande. Pas de balayage de verbes.
- [ ] Identifiants d’objet vus : notés en `Hypothèse` / `Non testé` « à passer authz / multi-tenant ». Ids non pivotés.

### Clôture

- [ ] Zéro finding attaché à une autre URL ou un autre verbe.
- [ ] Scores I/E/C/F/V, priorité, C plafonné, Confirmé avec preuve.
- [ ] Rapport : ressource, contrat d’accès, findings, paramètres, « Non exploré ».
- [ ] Couverture : 100 % de la ressource sur items faits / 0 % du produit. Les deux chiffres écrits.
- [ ] Journal append-only.

## Sorties

Un rapport d’une ressource. Des findings de cette ressource. Une liste explicite de ce qui a été refusé (autres URLs, autres verbes, pivot d’id).

## Pièges

- Deuxième URL « vite faite ».
- Payload offensif « pour confirmer ».
- IDOR Confirmé sans second objet — et sans le tester ici.
- Confondre la page et son XHR.

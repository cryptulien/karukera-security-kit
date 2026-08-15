# Modèle de menace

Copie vers `projects/<slug>/journal/threat-model.md`. Remplis après la collecte, avant le rapport. Aucun blanc « à plus tard » : si une case est inconnue, écris `inconnu` et baisse la jauge de confiance de mission.

## Identité

- Projet :
- Mode :
- Date :
- Auteur (agent) :

## Biens

Liste 3–8 biens que le produit protège réellement (données d’un tenant, secrets d’API, sessions, outils MCP, files de patients, factures). Pas de bien générique « la réputation » sans relier à un fait.

## Acteurs

| Acteur | Position | Ce qu’il peut déjà faire sans faille |
| --- | --- | --- |
| Anonyme Internet | hors auth | |
| Utilisateur d’un tenant | compte-test A | |
| Utilisateur d’un autre tenant | compte-test B ou `non fourni` | |
| Opérateur interne | admin produit | |
| Auteur d’un tool / skill tiers | si mode 4 | |
| Fournisseur du modèle | si un LLM voit des données | |

## Surfaces

Recopie les classes de `surface.md` et `apis.md` : UI publique, UI auth, API, webhooks, MCP, jobs, stockage.

## Hypothèses de menace

5–10 lignes max. Chaque ligne : acteur → action déjà possible ou **observée** → bien touché. Statut du soutien : Confirmé / Probable / Hypothèse / Non testé. Relie un `F-NNN` si un finding existe.

N’écris pas de scénario d’attaque pas-à-pas. N’invente pas un acteur « APT » sans fait.

## Contrôles déjà vus

Ce qui **existe** (CSP, SSO, séparation d’org dans l’UI, allowlist de tools). Preuve ou `Non testé`.

## Trous de modèle

Ce que ce mode ne couvre pas (pas de second tenant, pas de revue de code, hors-scope paiement). Ces trous apparaissent dans le rapport board.

## Révision

Date + entrée journal `action: note` si tu mets à jour cette projection.

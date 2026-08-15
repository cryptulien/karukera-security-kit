---
id: squad-02-threat-modeling
role: squad
reads: [RULES/*, ENGINE/journal.md, journal/surface, brief]
writes: [journal/findings, journal/evidence, journal/threat-model]
forbids: [inventer une preuve, sortir du scope, produire un exploit, inventer un acteur ou un actif non étayé]
---

# 02 — Threat Modeling

## Mission

Dis **ce qu’est le produit**, ce qu’il protège, qui le menace, où la confiance change de mains. Tu ne produis pas une liste de CVE. Tu produis un modèle que les agents 03–09 doivent respecter.

Un audit qui saute cette étape confond un blog, un SaaS multi-tenant et un runtime d’agents. Le positionnement est une contrainte de mesure, pas un paragraphe marketing.

## Checklist déclenchée

Exécute `SQUAD/02-threat-modeling.checklist.md`. Chaque affirmation d’actif, d’acteur ou de frontière cite un artefact de 01 ou du brief.

## Méthode

1. **Positionnement.** En une phrase impérative et sourcée : « Ce produit est un ____ qui fait ____ pour ____. » Sources : page d’accueil, docs, signup, README public, brief. Si les sources se contredisent, note la contradiction (`Probable` / `Hypothèse`), ne choisis pas la version la plus dramatique.
2. **Actifs.** Classe ce qui a de la valeur : comptes, sessions, secrets, données métier, objets multi-tenant, outils agents, mémoire / RAG, webhooks, clés d’API tierces, facturation. Chaque actif pointe vers une URL, un écran ou un extrait.
3. **Acteurs.** Utilisateur anonyme, utilisateur authentifié, rôle interne, tenant voisin, intégrateur, agent / MCP client, fournisseur OAuth, admin. N’ajoute un « attaquant nation-state » que si le brief le demande. Par défaut : opportuniste + tenant voisin + abus d’agent.
4. **Frontières de confiance.** Dessine (liste structurée, pas de diagramme obligatoire) : navigateur ↔ origine, SPA ↔ API, IdP ↔ app, tenant A ↔ tenant B, humain ↔ agent, agent ↔ tools, MCP client ↔ serveur, CI ↔ runtime, CDN ↔ origine. Toute donnée qui traverse une frontière sans contrôle observable est une hypothèse de risque, pas un Confirmé.
5. **Données et flux.** Pour 3 à 7 flux critiques (signup, login, lecture d’objet, action admin, appel tool, paiement si in-scope) : entrée, sortie, store, tiers. Reste dans le scope.
6. **Abus crédibles.** Formule des hypothèses d’abus liées au positionnement (« un tenant lit l’objet d’un autre », « un document empoisonne l’agent qui a `db.query` »). Statut `Hypothèse` jusqu’à test par 03–09.
7. **Hors-modèle.** Écris ce que ce produit n’est pas (ex. : pas une banque, pas un runtime d’agents, pas un marketplace). Ça empêche 11 de surpondérer un risque cosmétique.
8. **Priorités de test.** Ordonne les surfaces pour 03–09. Un SaaS multi-tenant pousse 05. Un copilote pousse 09. Un site vitrine pousse 03 et 07, pas une épopée IDOR.

## Sorties

`journal/threat-model` :

```yaml
positioning:
  statement:
  sources: []
assets: []
actors: []
trust_boundaries: []
critical_flows: []
abuse_hypotheses: []
not_this_product: []
test_priority_for_later_agents: []
```

Findings rares ici : contradiction documentaire, secret de positionnement (ex. admin lié public), frontière absente **observable**. Le reste reste `Hypothèse` à tester.

Score : `priority = 10*(0.30I + 0.25E + 0.20C + 0.15V) - 2*F` — C plafonné par le statut.

## Pièges

- Recopier un STRIDE générique sans regarder le produit.
- Traiter un site vitrine comme un core bancaire pour « faire sérieux ».
- Inventer un acteur « insider malveillant admin » sans rôle admin observé.
- Transformer une hypothèse d’abus en Confirmé avant 03–09.
- Oublier l’agent comme acteur alors que 01 a vu un MCP.
- Confondre « donnée personnelle » et « secret d’intégration » : ce sont deux actifs.

## Exemple de finding fictif

Cible inventée. Aucune vulnérabilité réelle.

```yaml
id: F-TM-DEMO-002
title: "Frontière tenant absente du discours produit — IDs d’organisation dans l’URL"
agent: squad-02-threat-modeling
status: Hypothèse
impact: 4
exploitability: 3
confidence: 2
fix_effort: 3
visibility: 4
priority: 23.5
band: P2
evidence:
  - url: "https://demo.acme-audit.test/app/org/1842/invoices"
    excerpt: "Factures — Organisation #1842 (page d’accueil : « espaces isolés par équipe »)"
    date: "2026-03-12"
    method: "Lecture UI + URL après login compte de test A. Aucune tentative sur l’org B."
notes: "À tester par 05. Confirmé interdit tant que l’objet de B n’a pas été demandé avec le compte A, dans le scope."
```

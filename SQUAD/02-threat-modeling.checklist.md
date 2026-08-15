# Checklist — 02 Threat Modeling

Coche uniquement ce qui s’appuie sur le brief ou sur `journal/surface`. Pas d’actif fantôme.

- [ ] Phrase de positionnement écrite et sourcée (home, docs, signup, brief)
- [ ] Contradictions produit / docs / UI consignées
- [ ] Actifs listés : comptes, sessions, secrets, données métier, objets tenant, tools agents, mémoire
- [ ] Chaque actif lié à un artefact (URL, écran, extrait)
- [ ] Acteurs listés, y compris tenant voisin et client MCP s’ils existent
- [ ] Pas d’acteur « nation-state » hors brief
- [ ] Frontières navigateur / API / IdP / tenant / humain-agent / agent-tool / CI-runtime
- [ ] Au moins un flux d’authentification décrit
- [ ] Au moins un flux de lecture d’objet métier décrit
- [ ] Flux agent / tool décrit si 01 a vu une surface IA, sinon explicitement hors surface
- [ ] Flux paiement décrit seulement s’il est in-scope
- [ ] Hypothèses d’abus rédigées au statut `Hypothèse`
- [ ] Section « ce produit n’est pas » rédigée
- [ ] Priorité de test transmise à 03–09 (quoi pousser, quoi rester léger)
- [ ] Aucun Confirmé émis sans observation directe d’un défaut
- [ ] Modèle écrit dans `journal/threat-model` et clôturé

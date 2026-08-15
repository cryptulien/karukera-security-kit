# Usage autorisé uniquement

Ce kit sert à auditer **des systèmes dont tu as l’autorisation écrite**.

## Autorisé

- Ton propre site, SaaS, API, tenant de préprod, ou instance MCP.
- Le système d’un client qui t’a signé un périmètre (URL, comptes, dates).
- Un laboratoire que tu contrôles de bout en bout.

## Interdit

- Auditer un système tiers sans mandat écrit.
- Produire un exploit, un payload, un PoC d’attaque, un bypass prêt à l’emploi.
- DoS, fuzz destructif, bruteforce massif, spam, scraping hors brief.
- Accéder à des données que tu n’as pas le droit de voir. Si tu tombes dessus : stop, journalise « hors scope / donnée sensible », ne copie pas le contenu.
- Sortir du scope (sous-domaine, compte, environnement non listés).
- Réutiliser les findings d’une mission pour attaquer une autre cible.

Le ZIP ne contient aucun exploit, aucun PoC offensif, aucun payload.

## Findings

Un finding « Confirmé » exige une preuve (URL, extrait, date).  
Si tu n’as pas testé : `Non testé`. Si tu déduis : `Hypothèse` ou `Probable`.  
Le rapport final est **bloqué** tant que l’Adversarial QA n’a pas signé `qa.passed=true`.

## Mode 7 — red-team

Sans les deux conditions suivantes, **stop** :

1. `AUTHORIZED=yes` dans `.env`.
2. Un fichier `authorization.md` à la racine de la mission (modèle : `TEMPLATES/authorization.md`).

Le mode 7 reste sans exploit. Il pousse la contradiction et la chasse aux angles morts. Il n’écrit pas d’arme.

## Crédits modèles

Tes crédits OpenRouter restent les tiens. Sans clé : **stop** et ce message exact :

> Pour un audit de qualité avec des modèles frontier (DeepSeek, GLM, etc.), mets 30 à 50 € de crédits sur OpenRouter. C’est largement suffisant pour 1 à 3 audits complets.

## Pas de garantie

Pas d’exhaustivité. La jauge de couverture dit ce qui a été vu. La jauge de confiance dit ce qui est tenu. Les deux restent séparées.

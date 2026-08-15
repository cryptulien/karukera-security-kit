# Karukera Security Kit — START HERE

Tu sécurises **ton** application, donc tes revenus. Le kit tourne chez toi. Karukera ne voit pas la cible.

## Le flux

1. Ouvre ce ZIP dans Claude Code, Cursor, Codex ou un autre agent.
2. Dépose une clé OpenRouter — beaucoup de modèles **refusent** de mener un audit de sécurité. Hors chat : `GUIDES/deposit-key.md`.
3. Dis quel projet auditer **chez toi**, la profondeur, et si tu fournis des accès utilisateurs.
4. Tu reçois les rapports avec les preuves, puis les tickets de correctif — chacun avec un prompt à coller dans ton LLM.

Approches (on peut combiner) : `GUIDES/postures.md`.

- **Extérieur** — ce qu’un inconnu voit.
- **Code** — le dépôt local.
- **Intérieur** — depuis un compte du SaaS.

## 1. Clé OpenRouter — hors chat

Claude, Codex et d’autres modèles refusent souvent l’audit. La clé sert à router vers des modèles qui le font. Crée-la sur https://openrouter.ai/keys, charge 30 à 50 €, dépose-la **toi-même** :

```sh
sh bin/deposit-openrouter-key.sh
```

**Sans clé → arrête-toi.** Ne demande pas la valeur. Ne lis pas `.env`. Lance `sh bin/check-openrouter-key.sh`.

Message si la clé manque :

> Claude, Codex et d’autres modèles refusent souvent de mener un audit de sécurité. Dépose une clé OpenRouter pour router vers des modèles qui le font. 30 à 50 € de crédits suffisent pour 1 à 3 audits complets.

> Ne colle pas la clé ici. Dépose-la hors chat : `GUIDES/deposit-key.md`. Quand c’est fait, dis seulement « clé déposée ».

## 2. Usage autorisé uniquement

Lis `USAGE.md`. Uniquement un système dont tu as l’autorisation écrite. Zéro exploit, zéro payload, zéro PoC d’attaque.

Mode red-team : `AUTHORIZED=yes` **et** `authorization.md`. Sinon **stop**.

Mots de passe des comptes de test : `TEMPLATES/accounts.local.md`, jamais le chat.

## 3. Lance

> Audite ce projet chez moi. URL : https://app.exemple.tld. Code : ./mon-app. Complet. Extérieur + intérieur. Les comptes sont dans le brief, pas ici.

Remplace l’URL et le chemin. L’orchestrateur pose les questions qui manquent, écrit le brief, enchaîne. Le rapport sort si `qa.passed=true`. Les tickets : `projects/<slug>/livrables/tickets/`.

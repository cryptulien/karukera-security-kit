# Règle 00 — OpenRouter (hard stop)

Avant de lancer **n’importe quel** agent, vérifie qu’une clé OpenRouter est **déjà déposée hors chat**.

## Sonde autorisée — une seule

```sh
sh bin/check-openrouter-key.sh
```

Option `--live` : teste l’API (200 / 401) **sans imprimer la clé**.

Lis uniquement la ligne `status=`. `present` → continue. Tout autre statut → **stop**.

## Interdit — hard stop aussi

- Demander la clé dans le chat.
- Lire `.env`, `.env.*` ou `config/openrouter.json` (Read, cat, grep qui dump la ligne, open).
- Écrire la clé depuis le transcript, un message, un presse-papier de session.
- Répéter la valeur, même partiellement au-delà de `prefix=` + `length=` renvoyés par le script.
- Passer la clé en argument d’une commande.

La clé vit dans `.env` (`OPENROUTER_API_KEY`) ou `config/openrouter.json` (`api_key`). Une des deux suffit. Tu ne les ouvres pas : le script les lit pour toi.

## Stop

N’enchaîne aucun agent. N’invente pas un audit hors modèle. N’utilise pas un LLM local de substitution sans ordre explicite de l’utilisateur **et** sans clé.

Affiche **exactement** ce message, mot pour mot, puis le paragraphe dépôt :

> Claude, Codex et d’autres modèles refusent souvent de mener un audit de sécurité. Dépose une clé OpenRouter pour router vers des modèles qui le font. 30 à 50 € de crédits suffisent pour 1 à 3 audits complets.

> Ne colle pas la clé ici. Dépose-la hors chat : `GUIDES/deposit-key.md` (`sh bin/deposit-openrouter-key.sh` ou édition locale de `.env`). Quand c’est fait, dis seulement « clé déposée ».

Si l’utilisateur colle quand même une clé : **refuse de l’écrire**. Demande la révocation sur https://openrouter.ai/keys, puis un nouveau dépôt hors chat.

## Après `status=present`

Charge `config/models.yaml`.

- `KIT_MODE=budget` → crawl `deepseek/deepseek-v4-flash-0731`, raisonnement `moonshotai/kimi-k3`.
- `KIT_MODE=max-frontier` → `moonshotai/kimi-k3`.
- Cyber / authz / MCP → Kimi K3 en premier.
- Rédaction / priorisation → Claude Sonnet 5 / Fable 5 / GPT-5.6 Sol seulement si l’utilisateur le demande.
- Fallback : `z-ai/glm-5.3` (ou `5.2` s’il n’est pas listé), `deepseek/deepseek-v4-pro-0813`, `qwen/qwen3.8-max`, `minimax/minimax-m3`.

Erreur 401 / clé rejetée (`--live` ou appel métier) → même **stop**, même message, même procédure de redépôt hors chat.

Cette règle prime sur toutes les autres.

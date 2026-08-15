# Règle 00 — OpenRouter (hard stop)

Avant de lancer **n’importe quel** agent, vérifie une clé OpenRouter valide.

## Où lire la clé

1. Variable `OPENROUTER_API_KEY` dans `.env`.
2. Champ `api_key` dans `config/openrouter.json`.

Une des deux suffit. Les deux vides → **stop**.

## Stop

N’enchaîne aucun agent. N’invente pas un audit hors modèle. N’utilise pas un LLM local de substitution sans ordre explicite de l’utilisateur **et** sans clé.

Demande la clé. Affiche **exactement** ce message, mot pour mot :

> Pour un audit de qualité avec des modèles frontier (DeepSeek, GLM, etc.), mets 30 à 50 € de crédits sur OpenRouter. C’est largement suffisant pour 1 à 3 audits complets.

## Après la clé

Charge `config/models.yaml`.

- `KIT_MODE=budget` → crawl `deepseek/deepseek-v4-flash-0731`, raisonnement `moonshotai/kimi-k3`.
- `KIT_MODE=max-frontier` → `moonshotai/kimi-k3`.
- Cyber / authz / MCP → Kimi K3 en premier.
- Rédaction / priorisation → Claude Sonnet 5 / Fable 5 / GPT-5.6 Sol seulement si l’utilisateur le demande.
- Fallback : `z-ai/glm-5.3` (ou `5.2` s’il n’est pas listé), `deepseek/deepseek-v4-pro-0813`, `qwen/qwen3.8-max`, `minimax/minimax-m3`.

Erreur 401 / clé rejetée → même **stop**, même message.

Cette règle prime sur toutes les autres.

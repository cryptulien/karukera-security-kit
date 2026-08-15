# Guide — OpenRouter

Le kit ne démarre pas sans clé. Tu peux ouvrir le ZIP dans Claude, Codex ou un autre agent : beaucoup de ces modèles **refusent** de mener un audit de sécurité. La clé OpenRouter sert à router vers des modèles qui le font. Les crédits sont les tiens. Karukera ne proxy rien.

Table des IDs : `config/models.yaml` (datée du 2026-08-15). Les slugs bougent. Relis OpenRouter avant une mission longue.

## Créer et déposer la clé (hors chat)

La clé ne passe **jamais** par le LLM. Procédure : `GUIDES/deposit-key.md`.

1. Compte sur https://openrouter.ai
2. Clé sur https://openrouter.ai/keys
3. Dans un terminal local : `sh bin/deposit-openrouter-key.sh`
4. Ou édite `.env` / `config/openrouter.json` dans ton éditeur, pas dans le chat
5. Dis à l’agent `clé déposée` — ne recopie pas la valeur

L’agent vérifie avec `sh bin/check-openrouter-key.sh`. Il ne lit pas `.env`. Il ne demande pas la clé.

Sans clé, **stop**. Affiche exactement :

> Claude, Codex et d’autres modèles refusent souvent de mener un audit de sécurité. Dépose une clé OpenRouter pour router vers des modèles qui le font. 30 à 50 € de crédits suffisent pour 1 à 3 audits complets.

> Ne colle pas la clé ici. Dépose-la hors chat : `GUIDES/deposit-key.md`. Quand c’est fait, dis seulement « clé déposée ».

## Crédits

Charge 30 à 50 €. En `budget` (Flash pour le crawl, K3 pour le raisonnement) ça couvre 1 à 3 audits. En `max-frontier` (K3 partout) l’output est cher — recharge si un 402 arrive. Ne bascule pas sur un modèle hors liste pour « finir gratis ».

## Pourquoi Kimi K3

Premier choix du kit. Slug OpenRouter : `moonshotai/kimi-k3` (sorti le 16 juillet 2026, listé). 2,8 T de paramètres, 1 M de contexte, fort en agentic coding, tools, longs dépôts. C’est lui qui tient authz, MCP, statuts et QA.

GLM-5.3 (14 août) reste un **repli** intéressant pour le cyber (CyberGym 84.5) dès qu’OpenRouter le liste. Aujourd’hui le slug Z.ai vivant est `z-ai/glm-5.2`. Le kit n’en fait plus le premier appel.

**Le kit interdit toujours** d’écrire un exploit, un payload ou une chaîne d’exploitation. Un Confirmé = URL + extrait + date. Pas un PoC.

## Routage

Lis `config/models.yaml`. Choisis `KIT_MODE`.

| Mode | Analyse | Raisonnement / cyber | Write |
| --- | --- | --- | --- |
| `budget` | `deepseek/deepseek-v4-flash-0731` | `moonshotai/kimi-k3` | Kimi K3 |
| `max-frontier` | `moonshotai/kimi-k3` | `moonshotai/kimi-k3` | `anthropic/claude-sonnet-5` si write prudent |

Fallback, dans l’ordre : `z-ai/glm-5.3` (ou `5.2`), `deepseek/deepseek-v4-pro-0813`, `qwen/qwen3.8-max`, `minimax/minimax-m3`.

Ne plus utiliser : `kimi-k2.5`, `deepseek/deepseek-v4-flash` (snapshot avril), `deepseek/deepseek-v4-pro` (pré-GA), `minimax-m2.5`, `claude-sonnet-4.6`, `gpt-5.2`.

Règle de fond :

- Analyse profonde (authz, API, MCP, statuts) → Kimi K3.
- Crawl volume en budget → Flash 0731.
- Rédaction, priorisation, rapport board → Claude Sonnet 5 / Fable 5 / GPT-5.6 Sol seulement si tu le demandes (`write_optional`).
- QA : modèle `reason` ou write prudent. Jamais un modèle qui n’a pas lu les `RULES/`.

## Appels

Endpoint : `https://openrouter.ai/api/v1`.  
En-têtes recommandés : `HTTP-Referer: https://karukera.xyz`, `X-Title: Karukera Security Kit`.

401 / clé vide / clé révoquée → même stop, même message qu’en tête de guide, puis redépôt hors chat (`GUIDES/deposit-key.md`).

Ne commite jamais `.env` ni `config/openrouter.json`. Ne les ouvre jamais depuis un agent.

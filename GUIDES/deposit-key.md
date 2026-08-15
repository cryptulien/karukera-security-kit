# Déposer la clé OpenRouter hors LLM

La clé **ne passe jamais par le chat**. Ni collée dans un message, ni dictée à l’agent, ni écrite par un outil de l’agent.

Un transcript, un log provider, une compaction ou un `Read` sur `.env` exposent la clé. Dans un kit de sécurité, c’est un échec.

## Ce que tu fais toi, dans un terminal ou un éditeur

1. Crée la clé sur https://openrouter.ai/keys
2. Charge 30 à 50 € de crédits (1 à 3 audits complets en mode `budget`)
3. Dépose-la **localement** avec A ou B
4. Reviens dans le chat et dis seulement : `clé déposée`

### A — script (recommandé)

Dans un terminal **à toi**, à la racine du kit, pas dans le chat :

```sh
sh bin/deposit-openrouter-key.sh
```

Le script refuse les arguments, refuse les pipes, lit en silencieux depuis le TTY, écrit `.env` en mode `600`. La clé n’est pas réaffichée.

### B — éditeur, hors chat

1. Copie `.env.example` vers `.env`
2. Ouvre `.env` dans ton éditeur (VS Code, Notepad, nano) — **pas** dans le fil de l’agent
3. Remplis `OPENROUTER_API_KEY=`
4. Enregistre. Si tu peux : `chmod 600 .env`

Windows (PowerShell), toujours hors chat :

```powershell
Copy-Item .env.example .env
notepad .env
```

Variante fichier : copie `config/openrouter.json.example` vers `config/openrouter.json` et remplis `api_key` dans l’éditeur, pas dans le chat.

## Ce que l’agent a le droit de faire

- Lancer `sh bin/check-openrouter-key.sh` (option `--live` pour un 200/401 sans imprimer la clé)
- S’arrêter si `status` n’est pas `present`
- Pointer ce guide

Il n’a **pas** le droit de :

- demander la valeur de la clé
- lire `.env` ou `config/openrouter.json`
- écrire la clé depuis le transcript
- la répéter, même masquée au-delà de `prefix=sk-or-` + `length=`

## Si tu l’as déjà collée dans le chat

1. L’agent **refuse** de l’écrire. Le passage par le modèle est déjà une fuite.
2. Révoque cette clé sur https://openrouter.ai/keys
3. Crées-en une nouvelle
4. Dépose la nouvelle avec A ou B
5. Dis `clé déposée`

## Vérifier sans révéler

```sh
sh bin/check-openrouter-key.sh
# status=present source=.env prefix=sk-or- length=73

sh bin/check-openrouter-key.sh --live
# status=present … live=ok   → crédits et clé acceptés
# status=present … live=401  → révoquée ou mal copiée ; redépose hors chat
```

Ne commite jamais `.env` ni `config/openrouter.json`. Le `.gitignore` du kit les ignore déjà.

---
id: mode-04-agents-mcp
reads: [RULES/*, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md]
writes: [journal/*, reports/exec.md, reports/impl.md, livrables/*]
forbids: [inventer une preuve, sortir du scope, produire un exploit, sauter l’agent 09]
---

# Mode 4 — Agents / MCP / Skills

Produit dont la valeur est un agent, un serveur MCP, des tools, des Skills, un orchestrateur. **09 est l’étoile. 09 tourne toujours.** Un audit de ce produit sans 09 n’existe pas.

## Quand l’ouvrir

- Serveur MCP public ou interne.
- App « chat + tools » (fichiers, navigateur, SQL, tickets).
- Kit de Skills / prompts avec accès à des systèmes.
- Toute surface qui enchaîne un LLM sur des outils.

Si c’est un SaaS **et** un agent : ce mode prime pour le cadrage ; tu exécutes aussi le spécialiste `saas-multitenant` et la règle des deux tenants (mode 3). Annote `project.yaml` : `mode: 04-agents-mcp`, `addons: [saas-multitenant]`.

## Portails

1. Clé OpenRouter. Sinon STOP.
2. Brief : origines, serveurs MCP (`url` ou commande d’install **de staging**), liste de tools déclarés si le client la fournit.
3. Compte-test ou jeton de **staging**. Pas de jeton production à pouvoir large « pour voir ».

## Pipeline

```
00 orchestrateur
  → 01 surface-mapper          (y compris /.well-known, llms.txt, llms-security.txt,
                                manifests MCP, pages d’install de tools)
  → 09 agent-mcp-skills        PREMIER agent métier, pas le dernier
  → 02 threat-modeling         (acteurs : utilisateur, autre tenant, opérateur modèle, tool tiers)
  → 04 auth-session            (qui a le droit d’appeler quel tool)
  → 05 authz-privilege         (un tool + l’id d’un autre locataire)
  → 06 api-backend             (callbacks, webhooks, streaming)
  → 07 config-secrets          (prompts, system cards, repos de skills, .env exposés)
  → 08 supply-chain            (tools tiers, marketplace, modèles)
  → spécialiste saas-multitenant   si tenancy
  → 03 audit-onpage            (ce que l’UI agent renvoie : fuites de system prompt —
                                observation, pas jailbreak offensif)
  → 10 adversarial-qa
  → 11 rapport-final           si qa.passed=true
```

09 produit le threat-model **principal** (remplir `TEMPLATES/threat-model.md` avec acteurs : utilisateur, autre tenant, opérateur du modèle, auteur d’un tool tiers).

## Ce que 09 examine (toujours)

Pour chaque tool / skill / function :

| Question | Sortie si oui |
| --- | --- |
| Quel verbe réel (lecture fichier, écriture, HTTP, shell) ? | ligne dans l’inventaire |
| Le paramètre d’URL / chemin est-il libre ? | finding, statut selon preuve |
| Le tool tourne-t-il avec l’identité de l’utilisateur ou un service account global ? | finding si global + données client |
| Un tool « search » mélange-t-il les tenants ? | isolation, règle des 2 tenants |
| Les secrets d’outils sont-ils injectés dans le prompt visible ? | preuve = extrait de réponse **déjà** renvoyée, pas un vol |
| Le manifest MCP annonce-t-il plus que l’UI ? | écart = Hypothèse ou Confirmé selon lecture |
| `llms.txt` / `llms-security.txt` / `security-robots.txt` existent-ils et sont-ils cohérents ? | hygiène, souvent P3/P2 |

Tu n’écris pas un prompt d’évasion. Tu n’appelles pas un tool destructif (`rm`, envoi d’email de masse, paiement). Tu listes le droit déclaré et, si un appel **de lecture** documenté est dans le brief, tu observes le résultat.

## Interdits spécifiques

- Jailbreak, prompt d’exfiltration, payload d’outil.
- Brancher le MCP de production sur tes propres tools.
- Confirmer une « prise de contrôle de l’agent » sans preuve d’un appel réel in-scope.
- Sauter 09 parce que « on a déjà regardé les headers ».

## Sorties

- Inventaire des tools dans `journal/apis.md` (section MCP).
- Threat-model centré agent.
- Findings scorés, dont au moins une ligne de couverture 09 (finding ou note).
- Rapports exec + impl. Board via mode 8 après QA.

## Couverture

09 non exécuté ⇒ mission invalide. `coverage.confidence_globale` ne dépasse pas 2 si l’inventaire des tools est incomplet.

## Exemple de constat (fictif)

Un tool MCP `read_file` déclaré sans racine bornée sur `mcp-fictif.example` : si le manifest le dit, Confirmé sur la **déclaration** (preuve = extrait du manifest). L’abus réel n’est pas démontré et ne doit pas l’être. Étiquette `fictif` dans les exemples du kit.

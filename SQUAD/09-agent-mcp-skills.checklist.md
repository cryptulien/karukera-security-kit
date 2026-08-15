# Checklist — 09 Agents / MCP / Skills

Coche uniquement l’observé. Item sans surface : `hors surface`. N’écris aucune injection.

- [ ] Inventaire négatif ou positif clôturé (`present: true|false`) à partir de 01
- [ ] Runtimes listés (in-app, desktop, CI, Cursor/Claude Code/Codex/Hermes)
- [ ] Transports MCP relevés (stdio / SSE / HTTP) avec le manifeste ou la config
- [ ] Chaque tool : nom, description, schéma, effet (read / write / exec / réseau)
- [ ] Descriptions de tools éditables par un tenant ? (canal ASI01)
- [ ] Séparation visible instructions vs contenu récupéré (e-mails, tickets, pages, PDF)
- [ ] HITL / step-up / écran immuable sur les tools à effet de bord
- [ ] Identité d’exécution : user vs service vs admin ; standing token vs jeton de tâche
- [ ] Confused deputy : le serveur MCP a-t-il plus de droits que l’appelant ?
- [ ] Révocation agent distincte de la révocation utilisateur
- [ ] Skills : source, auteur, pin de version/hash, moment de chargement
- [ ] `SKILL.md` / `AGENTS.md` lus : élargissement de tools, webhook, demande de désactiver une règle
- [ ] Tool d’exécution de code / shell / navigateur : sandbox et egress documentés ou absents
- [ ] Mémoire / RAG : qui écrit, isolation tenant, survie hors thread
- [ ] Test cross-tenant de mémoire seulement avec deux comptes de test
- [ ] A2A / sous-agents / sampling MCP : auth, signature, allowlist
- [ ] Kill switch, plafond d’appels, budget tokens
- [ ] Consentement hors chat pour les actions irréversibles ; paramètres du tool visibles à l’humain
- [ ] Logs d’audit : `agent_id` distinct de `user_id`
- [ ] `resources` / roots / `file://` / `db://` relevés sans les parcourir hors test
- [ ] Secrets MCP (`mcp.json`, OAuth, `DATABASE_URL`) masqués, jamais réutilisés
- [ ] `tools/list_changed` : le serveur peut-il ajouter un tool en cours de session ?
- [ ] ASI01 à ASI10 chacun clôturé (`Confirmé` / `Probable` / `Hypothèse` / `Non testé` / `hors surface`)
- [ ] Aucun payload d’injection, aucun tool destructeur invoqué
- [ ] Versions de serveurs MCP transmises à 08 pour avis cités, sans CVE inventée

# Checklist — 00 Orchestrateur

Coche uniquement ce que tu as réellement vérifié. Un item non fait reste décoché et se journalise en `Non testé` ou `blocked`.

- [ ] `RULES/00-openrouter.md` lu avant tout autre fichier agent
- [ ] Ensemble de `RULES/` chargé (anti-invention, chaîne de preuve, six statuts, double QA)
- [ ] `sh bin/check-openrouter-key.sh` → `status=present` (jamais de Read sur `.env` / `config/openrouter.json`)
- [ ] Clé jamais demandée ni recopiée dans le chat ; dépôt pointé vers `GUIDES/deposit-key.md`
- [ ] Message 30–50 € + consignes de dépôt hors chat affichés, mission stoppée si la clé manque
- [ ] Brief lu : URL cible, comptes de test, hors-scope, mode
- [ ] Autorisation écrite présente ; mode 7 : `AUTHORIZED=yes` **et** `authorization.md`
- [ ] Mode chargé depuis `ENGINE/modes/` ; pipeline rappelé à l’opérateur
- [ ] Aucun agent métier lancé hors ordre canonique 01 → 11
- [ ] `11-rapport-final` non appelé tant que `qa.passed` n’est pas `true`
- [ ] Agent 09 planifié même en l’absence de surface (clôture négative obligatoire)
- [ ] Modèles choisis selon `config/models.yaml` (analyse DeepSeek/GLM, fallback documenté)
- [ ] Journal ouvert en append-only, horodaté, avec `mission_id`
- [ ] Pointeur de reprise écrit (`ENGINE/resume.md`) après chaque agent clôturé
- [ ] Tout Confirmé sans (URL + extrait + date + méthode) renvoyé à l’agent source
- [ ] Couverture et confiance suivies comme deux jauges distinctes
- [ ] Interdits rappelés à chaque agent : pas d’exploit, pas de payload, pas de sortie de scope

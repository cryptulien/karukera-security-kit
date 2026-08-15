# Checklist — 10 Adversarial QA

Tant qu’une case Confirmé/Probable est non revue, `qa.passed` reste `false`.

- [ ] Inventaire complet des findings 01–09 (aucun oublié)
- [ ] Chaque Confirmé a URL/chemin + extrait + date + méthode
- [ ] Chaque Probable a au moins un artefact et une raison de ne pas confirmer
- [ ] C plafonné : Hypothèse ≤ 2, Probable ≤ 3, Confirmé ≤ 5
- [ ] `priority` recalculée : `10*(0.30I+0.25E+0.20C+0.15V)-2*F`
- [ ] Bandes corrigées : ≥35 P0, 25–34 P1, 15–24 P2, <15 P3
- [ ] Headers isolés non vendus comme incidents
- [ ] Clés publishables distinguées des secrets
- [ ] IDOR : le corps montre bien l’objet de B, ressource non publique
- [ ] XSS : puits ou réflexion observés, aucun payload dans le dossier
- [ ] CVE : avis cité, version observée dans la plage, pas d’ID inventé
- [ ] Surface agent : pas d’ASI Confirmé sans artefact dans `journal/agent-surface`
- [ ] Findings hors scope écartés
- [ ] Aucun compte réel / aucune donnée tierce dans les extraits
- [ ] Aucun exploit, payload ou PoC dans le journal
- [ ] Mitigé vs Faux positif distingués
- [ ] Jauges couverture et confiance chiffrées séparément
- [ ] Renvois aux agents sources listés si un Confirmé nouveau serait nécessaire
- [ ] `qa.passed=true` seulement si tous les bloqueurs sont vides
- [ ] Signature horodatée écrite dans `journal/qa`

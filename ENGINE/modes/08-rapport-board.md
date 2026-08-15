---
id: mode-08-rapport-board
reads: [RULES/*, RULES/07-double-qa.md, ENGINE/score.md, ENGINE/journal.md, journal/qa/signoff.md]
writes: [reports/board.md, journal/entries]
forbids: [nouveau test, inventer une preuve, produire un exploit, rédiger sans qa.passed]
---

# Mode 8 — Rapport board

Rédaction uniquement. **Aucun test. Aucune collecte. Aucun finding nouveau.** Le board lit des faits déjà tenus par la QA.

## PORTAIL DUR

```
SI journal/qa/signoff.md est absent
   OU qa.passed ≠ true
   OU project.yaml.qa.passed ≠ true
ALORS
   STOP
   N’écris pas reports/board.md
   N’appelle pas l’agent 11
   Affiche : « Mode 8 refusé : la Double QA n’a pas signé (qa.passed=true). »
```

Un `qa.passed` oral, un « on sait que c’est bon », un sign-off daté **avant** des findings ajoutés ensuite : **insuffisant**. Si un finding ou une preuve a un `date` / un `ts` postérieur au `qa.date`, la QA est caduque → `qa.passed=false` et tu refuses le board.

## Quand l’ouvrir

- Un Complet (2/3/4), un delta, ou un red-team léger vient de passer la QA.
- Un COMEX / un board / un investisseur demande une page, pas un journal.

N’ouvre pas ce mode pour « avancer le texte pendant que l’audit tourne ».

## Pipeline

```
00 orchestrateur     (vérifie le portail, refuse sinon)
  → lecture seule du journal (findings actifs, coverage, sign-off, threat-model)
  → squad-11-rapport-final   (variante board : TEMPLATES/report-board.md)
  → une entrée action:report
```

Zéro agent 01–09. Zéro spécialiste. Zéro GET. Si l’humain demande « au passage, tu revérifies la CSP » : ce n’est plus le mode 8. Propose un mode 5, puis une nouvelle QA, puis on revient.

## Ce que le texte a le droit de dire

- Compteurs P0–P3 des findings **actifs** (Confirmé, Probable, Hypothèse, Non testé).
- Les Confirmé P0/P1 avec leur preuve (URL + date, extrait court déjà au journal).
- La jauge de **couverture** et la jauge de **confiance de mission**, séparées.
- Les Non testé structurels (un seul tenant, pas de compte-test, 09 sans surface).
- Les Mitigé depuis le dernier snapshot, en annexe courte.
- Le cadre : dates, mode d’origine, fictif ou réel.

## Ce que le texte refuse

- Promettre l’exhaustivité.
- Transformer un Non testé en « a priori sain ».
- Citer un Confirmé sans date de preuve.
- Ajouter une recommandation qui suppose un fait absent du journal.
- Coller un payload, un schéma d’attaque, un dump.
- Inventer un chiffre financier d’impact.

## Sortie

Un seul livrable principal : `projects/<slug>/reports/board.md` selon `TEMPLATES/report-board.md`.

Option : recopier une version client dans `livrables/` si le brief le demande, **identique** au rapport signé. Pas de version « adoucie » qui cache un P0.

Longueur : 2–4 pages équivalent. Dix findings maximum dans le corps (les plus prioritaires). Le reste = une ligne dans un tableau annexe.

## Stop

- Tentative de « juste un GET pour une capture plus propre » → STOP, reste en 8 ou change de mode.
- QA refusée ou expirée → STOP.
- Journal incohérent (Confirmé sans preuve) → STOP, renvoyer à la QA, pas au board.

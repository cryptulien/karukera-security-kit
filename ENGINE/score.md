# Score — I, E, C, F, V

Calcule chaque finding avec la formule du contrat. Pas d’autre barème. Pas d’intuition à la place du chiffre.

---

## Grandeurs

Toutes sur **1–5**, entiers.

| Lettre | Champ | Sens 1 | Sens 5 |
| --- | --- | --- | --- |
| **I** | `impact` | Gêne locale, cosmétique | Compromission large, données de masse, ou rupture d’isolation |
| **E** | `exploitability` | Conditions rares, privilège élevé, plusieurs astres alignés | Compte anonyme, peu d’étapes, préconditions faibles |
| **C** | `confidence` | Indice mince | Preuve directe, reproductible, datée |
| **F** | `fix_effort` | Changement de config, minutes | Refonte, semaines |
| **V** | `visibility` | Enterré, connaissance interne | Public, crawlable, présent sur chaque réponse |

**E** mesure la facilité **observée ou raisonnablement déduite**, pas un mode d’emploi d’attaque. N’écris jamais les étapes d’exploitation.

## Plafond de C selon le statut

| Statut | C max | C min conseillé |
| --- | --- | --- |
| Confirmé | 5 | 4 si une seule preuve, 5 si preuve + reproduction non destructive |
| Probable | 3 | 2–3 |
| Hypothèse | 2 | 1–2 |
| Non testé | 1 | 1 |
| Mitigé | conserver le C historique du constat d’origine | — |
| Faux positif | ne pas scorer ; retirer de la file de priorité | — |

Si le statut baisse (Confirmé → Probable), rabats C tout de suite. Si le statut monte, tu n’as le droit d’augmenter C **qu’avec une nouvelle preuve** dans le journal.

Un Confirmé sans preuve est invalide : refuse le score, renvoie l’agent à `RULES/01-anti-invention.md`.

## Formule

```
priority = 10 * (0.30*I + 0.25*E + 0.20*C + 0.15*V) - 2*F
```

- I, E, C, V pèsent le risque. F **abaisse** la priorité (plus c’est long à corriger, plus le chiffre descend — on ne noie pas un P0 facile derrière un chantier de six mois).
- Les poids I+E+C+V = 0,90. C’est voulu. Ne « renormalise » pas à 1.
- Résultat toujours en .0 ou .5. Écris **un chiffre après la virgule**.
- Forme développée utile pour vérifier : `priority = 3*I + 2.5*E + 2*C + 1.5*V - 2*F`.

## Bandes

| priority | Bande | Lecture |
| --- | --- | --- |
| ≥ 35 | **P0** | Traiter maintenant |
| 25–34 | **P1** | Sprint en cours |
| 15–24 | **P2** | Planifié |
| < 15 | **P3** | Backlog / hygiène |

Les frontières : 35,00 est P0 ; 34,50 est P1 ; 25,00 est P1 ; 24,50 est P2 ; 15,00 est P2 ; 14,50 est P3. Une priority négative (possible si I=E=C=V=1 et F=5 → −1,0) reste P3.

## Bornes de la formule

- Max usuel : I=E=C=V=5, F=1 → `10*(4,50) - 2 = 43,0`
- Min usuel : I=E=C=V=1, F=5 → `10*(0,90) - 10 = −1,0`

Si tu sors de [−1, 43], tu as mal lu une entrée.

## Cas travaillés

### Cas A — P0 Confirmé (isolation / données)

I=5, E=4, C=5, F=2, V=5

```
0,30*5 = 1,50
0,25*4 = 1,00
0,20*5 = 1,00
0,15*5 = 0,75
somme   = 4,25
×10     = 42,50
− 2*2   = 38,50
```

**priority = 38,5 → P0**

### Cas B — P1 Confirmé (CSP absente, site public)

I=2, E=3, C=5, F=1, V=5

```
0,30*2 + 0,25*3 + 0,20*5 + 0,15*5
= 0,60 + 0,75 + 1,00 + 0,75
= 3,10
×10 = 31,00
− 2*1 = 29,00
```

**priority = 29,0 → P1**

C’est le barème du finding fictif `F-001` (`examples/demo-journal/finding-01.md`).

### Cas C — P1 Confirmé (500 verbeuse)

I=2, E=4, C=5, F=2, V=3

```
0,60 + 1,00 + 1,00 + 0,45 = 3,05
×10 = 30,50
− 4  = 26,50
```

**priority = 26,5 → P1**

Barème du finding fictif `F-002`.

### Cas D — P2 Probable

I=3, E=3, C=3, F=3, V=3

```
0,90 + 0,75 + 0,60 + 0,45 = 2,70
×10 = 27,00
− 6  = 21,00
```

**priority = 21,0 → P2**

### Cas E — P3 hygiène

I=2, E=2, C=2, F=4, V=2

```
0,60 + 0,50 + 0,40 + 0,30 = 1,80
×10 = 18,00
− 8  = 10,00
```

**priority = 10,0 → P3**

### Cas F — le plafond de C change la bande

Même risque ressenti que le cas A, mais statut **Hypothèse** ⇒ C plafonné à 2 (pas 5).

I=5, E=4, C=2, F=2, V=5

```
1,50 + 1,00 + 0,40 + 0,75 = 3,65
×10 = 36,50
− 4  = 32,50
```

**priority = 32,5 → P1** (sans plafond : 38,5 P0). Le plafond existe pour ça : une hypothèse ne conduit pas un board comme une preuve.

### Cas G — frontière P0 / P1

I=4, E=4, C=5, F=2, V=4

```
1,20 + 1,00 + 1,00 + 0,60 = 3,80
×10 = 38,00
− 4  = 34,00  → P1
```

Même chose, F=1 :

```
38,00 − 2 = 36,00  → P0
```

Un point de fix_effort fait basculer la bande. Recalcule, ne « sens » pas la bande.

### Cas H — Non testé (isolation sans second tenant)

I=5, E=3, C=1, F=3, V=3 — statut **Non testé**

```
1,50 + 0,75 + 0,20 + 0,45 = 2,90
×10 = 29,00
− 6  = 23,00
```

**priority = 23,0 → P2**. Le chiffre reste visible pour le planning, mais le rapport doit crier le statut : ce n’est pas un trou démontré. Barème du finding fictif `F-003`.

## Ordre de travail

1. Fixe le statut (`RULES/03-measurement-status.md`).
2. Plafonne C.
3. Attribue I, E, F, V avec les grilles ci-dessous.
4. Calcule `priority` (forme développée pour relecture).
5. Lis la bande.
6. Écris les cinq entiers, la priority et la bande dans le finding. Montre le calcul dans `notes` ou dans l’entrée de journal.

## Grilles d’attribution

### Impact (I)

1. Cosmétique, info de version anodine, défense en profondeur sans scénario actuel.
2. Donnée non sensible d’un utilisateur, ou fuite d’implémentation (stack, chemins).
3. Données personnelles d’un compte, ou fonction métier d’un tenant dégradée.
4. Données d’un tenant entier, élévation dans un rôle, ou action financière limitée.
5. Trans-tenant, masse d’utilisateurs, prise de contrôle admin, ou sécurité des personnes.

### Exploitability (E)

1. Théorique, dépend d’une autre faille non vue.
2. Compte privilégié, fenêtre étroite, ou condition rarement réunie.
3. Un utilisateur authentifié standard suffit.
4. Un compte low-priv, peu d’étapes, préconditions faibles.
5. Sans authentification, depuis Internet, déclenchement banal (un GET).

N’augmente pas E parce que « un attaquant motivé pourrait ». E décrit ce qui est **déjà** facile avec ce qui est observé.

### Fix effort (F)

1. En-tête, flag, règle WAF, ligne de config.
2. Correctif local, quelques heures, tests simples.
3. Ticket de feature, quelques jours, revue.
4. Changement transversal, plusieurs services.
5. Refonte d’auth, de tenancy ou de modèle de données.

### Visibility (V)

1. Voie interne, non documentée, hors HTML public.
2. Outil interne ou staging lié par erreur.
3. Zone authentifiée, pas liée depuis l’accueil.
4. Page publique peu évidente, ou JS de production.
5. Chaque réponse, page d’accueil, ou fichier crawlable (`robots`, sitemap).

## Deux jauges distinctes

Le score d’un finding n’est **pas** la couverture de la mission.

| Jauges | Où | Formule |
| --- | --- | --- |
| Confiance | chaque finding, champ C | plafonnée par le statut |
| Couverture | `project.yaml` → `coverage` | `tested / planned` (0–100 %), classes de surface réellement collectées / planifiées |

Un rapport qui affiche 40,0 P0 et une couverture de 30 % dit : « un trou grave **sur ce qu’on a vu** ; on n’a pas tout vu ». N’infère pas la seconde jauge à partir de la première.

`coverage.confidence_globale` (1–5) est le jugement **de mission** (qualité de l’ensemble), distinct du C de chaque ligne. Un seul Confirmé mineur ne donne pas 5 à la mission.

## Agrégation pour un rapport

- Classe les findings **actifs** (Confirmé, Probable, Hypothèse, Non testé) par priority décroissante, puis par bande, puis par id.
- Exclus Faux positif.
- Mitigé : section séparée « fermés depuis la dernière passe », pas dans le top P0.
- Non testé reste dans la liste, jamais promu Confirmé pour « faire un plus joli board ».
- Compte : nP0, nP1, nP2, nP3. Ces comptes figurent en tête des templates `report-exec`, `report-impl`, `report-board`.

## Interdits

- Changer I ou E pour obtenir la bande que le client « attend ».
- Scorer un Confirmé sans preuve.
- Utiliser un autre calcul (CVSS brut, « sévérité haute », moyenne non pondérée).
- Omettre F pour gonfler un P0.
- Recopier un score d’un autre projet.

---
id: mode-07-redteam-leger
reads: [RULES/*, USAGE.md, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md, authorization.md]
writes: [journal/*]
forbids: [inventer une preuve, sortir du scope, produire un exploit, tout test sans AUTHORIZED=yes et authorization.md]
---

# Mode 7 — Red-team léger

Tests **actifs, non destructifs, autorisés par écrit**. Ce n’est pas un pentest offensif. Le ZIP ne contient aucun exploit ; tu n’en écris aucun.

## PORTAIL DUR — lire avant tout GET

```
SI project.yaml.authorization.authorized ≠ yes
   OU fichier projects/<slug>/authorization.md absent
   OU authorization.md sans les quatre clauses ci-dessous
ALORS
   STOP
   N’enchaîne aucun agent
   N’envoie aucune requête
   Écris une entrée action:note qui cite le portail fermé
   Affiche : « Mode 7 refusé : AUTHORIZED=yes et authorization.md signé exigés. »
```

Une autorisation orale, un Slack, un « c’est mon site » dans le chat : **insuffisant**. Le fichier doit exister dans le dossier projet.

### Quatre clauses minimales de `authorization.md`

1. Identité du signataire (nom, rôle, organisation qui possède la cible).
2. Périmètre d’hôtes / URLs **identique ou plus étroit** que `project.yaml`.
3. Phrase explicite : tests de sécurité non destructifs autorisés entre `<début>` et `<fin>` (dates).
4. Interdits du client (ex. pas de reset de mot de passe, pas de staging partagé, pas d’horaires de nuit).

`AUTHORIZED=yes` se met dans `project.yaml` **après** que tu as lu ces quatre clauses et constaté qu’elles sont présentes. Tu ne coches pas `yes` pour toi-même si le fichier est creux.

Reprise après coupure : tu re-vérifies le portail (`ENGINE/resume.md`). Une autorisation expirée (`fin` dépassée) = STOP.

## Ce que « léger » autorise (une fois le portail ouvert)

Toujours borné au fichier, toujours non destructif :

- Tout ce que `ENGINE/collect.md` permet.
- Rejouer un flux de login **compte-test** fourni.
- Un GET sur un id de ressource **déjà vu** dans l’UI du compte-test (contrôle d’accès).
- Créer un objet **jetable** prévu par le brief (« créer un ticket test, le relire, le supprimer si l’API de delete est documentée »).
- Changer un champ inoffensif de cet objet jetable (titre = `karukera-audit-<date>`).
- Observer les messages d’erreur renvoyés par ces actions légitimes.

## Ce que le mode refuse encore

- Tout payload d’injection (SQL, XSS, SSTI, LDAP, commande, template).
- Fuzzing, wordlists, bruteforce, credential stuffing, password spraying.
- DoS, flood, parallélisation, retry agressif.
- Exploitation d’une faille pour « aller plus loin » (pivot, dump, lecture `/etc/passwd`, accès S3 de masse).
- Atteindre un hors-scope « parce que le DNS répond ».
- Outils d’exploit, scripts de PoC, reverse shell, malware.
- Social engineering des employés du client.

Si un contrôle d’accès tombe (200 + données d’un autre objet jetable du brief) : tu **arrêtes l’approfondissement**, tu écris la preuve, tu scores, tu passes à la suite du périmètre. Tu ne te sers pas du trou.

## Pipeline (après portail ouvert)

```
00 orchestrateur          (écrit l’entrée « portail ouvert », cite la date de fin)
  → 01 surface-mapper
  → 02 threat-modeling
  → 03 audit-onpage / 04 auth-session / 05 authz-privilege
                          (actions jetables du brief seulement)
  → 06 api-backend / 07 config-secrets / 08 supply-chain
  → 09 agent-mcp-skills   si surface agent, tools de lecture seulement
  → spécialiste saas-multitenant si tenancy (toujours 2 tenants pour confirmer)
  → score
  → 10 adversarial-qa     (vérifie aussi qu’aucune preuve n’est un payload)
  → 11 rapport-final      si qa.passed=true
```

Tous les agents 01–09 tournent comme en mode 2/3, sans jamais franchir la ligne des payloads.

## Preuves

Même chaîne que le reste du kit. Un Confirmé = URL + extrait + date + méthode. L’extrait montre la **réponse** (code, fragment). Il ne montre pas une charge utile d’attaque. Si tu ne peux pas prouver sans coller un payload : le finding reste Probable ou Hypothèse.

## Sorties

Journal + rapports classiques après QA. Le rapport mentionne en tête : « Red-team léger autorisé du \<date\> au \<date\>, signataire \<nom\>. Aucun exploit produit. »

## Stop immédiat (même portail ouvert)

- Le client retire l’autorisation.
- Tu touches un système hors fichier.
- Un 5xx en série (tu recules, tu ne relances pas).
- Demande humaine d’un PoC offensif → refuse, cite `USAGE.md`.

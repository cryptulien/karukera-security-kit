# Projets clients — convention persistante

Un client = un dossier. La squad n’écrit nulle part ailleurs. Plusieurs missions sur le même client **enrichissent** ce dossier, elles n’en créent pas un second.

---

## Emplacement

```
projects/<slug>/
```

`<slug>` : minuscules ASCII, chiffres, tirets. Pas d’espace, pas d’accent. Exemples : `demo-boutique`, `acme-saas`, `clinique-ouest`.

Racine du kit : le dossier `projects/` vit **à côté** de `ENGINE/`, pas dedans. S’il n’existe pas, crée-le. Ne range jamais un journal dans `/tmp` ni dans le dossier d’un autre client.

## Arborescence obligatoire

```
projects/<slug>/
  project.yaml              # projection courante (schéma SCHEMAS/project.schema.json)
  brief.md                  # périmètre rédigé, comptes-test, hors-scope
  authorization.md          # présent dès que des tests actifs sont prévus (obligatoire en mode 7)
  contacts.md               # qui relit, qui reçoit le rapport
  journal/
    entries/                # append-only, une file
    findings/               # une fiche par id, projection courante
    evidence/               # append-only
    qa/
      signoff.md            # absent ou qa.passed=false → pas de rapport final
    surface.md              # inventaire crawl
    apis.md                 # inventaire API
    threat-model.md         # modèle de menace de la mission
    coverage.md             # jauge couverture
  snapshots/
    <YYYY-MM-DD>/           # copie figée avant une passe delta / continue
      project.yaml
      findings/
      coverage.md
  reports/
    exec.md
    impl.md
    board.md
  livrables/
    audit-strategique.md
    plan-implementation.md
    checklist-actions.md
    delta-compare.md        # si mode 5 ou 6
```

Crée les dossiers vides dès l’ouverture du projet. N’attends pas la fin de mission.

## Ouverture d’un projet

1. Vérifie qu’un `projects/<slug>/project.yaml` n’existe pas déjà. Si oui : c’est une **reprise** (`ENGINE/resume.md`) ou un **delta** (mode 5), pas une création.
2. Crée l’arborescence.
3. Écris `project.yaml` (champs du schéma, aucun champ fantôme).
4. Écris `brief.md` : URLs, hôtes, comptes-test, données interdites, plage horaire, interlocuteur.
5. Copie ou rédige `authorization.md` dès que le client a signé. En mode 7, son absence = STOP.
6. Première entrée dans `journal/entries/` : ouverture, mode choisi, périmètre recopié.

## `project.yaml` — règles

- `id` : identifiant stable, ex. `prj-demo-boutique`.
- `slug` : nom du dossier, identique.
- `mode` : un des huit identifiants `01-express` … `08-rapport-board`.
- `scope.tenants_available` : entier. `0` ou `1` ⇒ les findings d’isolation restent **Non testé** (mode 3).
- `authorization.authorized` : `yes` ou `no`. Le mode 7 exige `yes` **et** le fichier.
- `qa.passed` : `false` tant que `journal/qa/signoff.md` n’est pas signé.
- `coverage.planned` / `coverage.tested` : entiers, classes de surface, pas un pourcentage inventé.
- `fictif` : `true` uniquement pour les exemples du kit.

Tu peux mettre à jour `project.yaml` (c’est une projection). Chaque mutation notable (changement de mode, `qa.passed`, nouveau tenant, clôture) a une entrée de journal qui le dit.

## Un client, plusieurs missions

| Situation | Quoi faire |
| --- | --- |
| Même périmètre, nouvelle passe | Mode 5 (delta) ou 6 (continu). Snapshot d’abord. |
| Nouveau sous-domaine in-scope | Élargis `scope` + entrée de journal. Ne clone pas le projet. |
| Autre produit du même client, hors périmètre | Nouveau slug (`acme-billing`), lien `related_projects` dans les deux `project.yaml`. |
| Rapport board demandé plus tard | Mode 8 dans le **même** dossier. Aucun test neuf. |

## Nommage des artefacts

| Artefact | Motif | Exemple |
| --- | --- | --- |
| Finding | `F-NNN-slug.md` | `F-001-csp-absente.md` |
| Preuve | `E-NNN-slug.md` | `E-001-headers-example-com.md` |
| Entrée | `<ISO8601>-<agent>-<action>.md` | `2026-04-12T091400Z-squad-01-collect.md` |
| Snapshot | `snapshots/YYYY-MM-DD/` | `snapshots/2026-04-12/` |

Les numéros `NNN` sont locaux au projet, à trois chiffres, monotones. Pas de réutilisation d’id, même après un faux positif.

## Ce que tu ne mets pas dans le dossier

- Secrets de production en clair (utilise le gestionnaire du client ; dans le brief : « voir coffre, clé X »).
- Exports de données personnelles réelles. Une preuve cite un **extrait court** déjà visible par l’audit.
- Payloads, exploits, dumps.
- Fichiers d’un autre client.

## Clôture

1. QA signée ou refus documenté.
2. Rapports écrits seulement si `qa.passed=true` (sauf livrable intermédiaire explicitement non final).
3. `project.yaml` : `status: closed`, date.
4. Entrée de journal « clôture ».
5. Le dossier reste. On n’archive pas en détruisant.

## Exemple

`examples/demo-project.yaml` + `examples/demo-journal/` reproduisent un projet fictif déjà clôturé. Recopie la forme, pas les faits.

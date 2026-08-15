---
id: mode-06-continuous
reads: [RULES/*, ENGINE/collect.md, ENGINE/score.md, ENGINE/journal.md, ENGINE/modes/05-delta.md]
writes: [journal/entries, journal/findings, journal/evidence, snapshots/*, livrables/delta-compare.md]
forbids: [inventer une preuve, sortir du scope, produire un exploit, écrire un rapport board sans QA]
---

# Mode 6 — Continu

Garde-fou périodique sur un projet déjà ouvert. Même dossier client. Même journal append-only. Ce n’est pas un red-team. Ce n’est pas un mode 8.

## Quand l’ouvrir

- L’humain dit « surveille cette origine chaque semaine / chaque release ».
- Un cron, un hook de déploiement, ou une relance manuelle.
- Un mode 2/3/4 (ou un delta) a déjà posé la baseline.

Sans baseline : fais une Express ou un Complet d’abord, puis bascule en 6.

## Portails

1. Clé OpenRouter à **chaque** run. Une clé disparue = STOP, pas de run « allégé ».
2. Projet existant. `project.yaml` → `mode: 06-continuous` (tu notes l’ancien mode dans `mode_baseline`).
3. Snapshot si le dernier a plus de 24 h ou s’il n’existe pas encore pour cette baseline.

## Ce que chaque run fait

1. Entrée `action: open` avec le déclencheur (manuel, date de release, hook).
2. Collecte **étroite** : fichiers de politique, en-têtes des classes déjà connues, probe 404, liste des scripts (hash ou `content-length` + URL). Plafond 80 URLs sauf nouvelle origine dans le brief.
3. Compare aux preuves récentes (comme un delta automatique).
4. Si un en-tête de sécu disparaît, si une 500 redevient verbeuse, si un nouveau host in-scope apparaît : finding nouveau ou régression, scorés.
5. Si rien n’a bougé : entrée `note` « run stérile », pas de faux finding.
6. QA courte si et seulement si un Confirmé naît ou un P0/P1 bouge. Sinon, pas de sign-off neuf (l’ancien reste ; `qa.passed` du **dernier** rapport complet n’autorise pas un board automatique).
7. Met à jour `livrables/delta-compare.md` (écraser la projection delta est permis ; l’historique vit dans `entries/` et `snapshots/`).

## Ce que chaque run ne fait pas

- Pas de mode 7.
- Pas de nouveaux POST.
- Pas d’agent 11, pas de `report-board`. Un humain demande le mode 8 à part, après QA si des faits ont changé.
- Pas de relance 09 complète sauf : baseline mode 4, **ou** un manifest MCP / `llms.txt` a changé. Alors 09 rejoue l’inventaire des tools (lecture).
- Pas de second tenant magique : si `tenants_available < 2`, l’isolation reste Non testé pour toujours jusqu’à ce que le brief change.

## Alertes

Écris en tête de l’entrée de run, une ligne `alerte:` :

- `aucune`
- `P0` / `P1` suivi des ids
- `nouvelle-surface` suivi de l’URL
- `qa-requise`

N’envoie pas de données personnelles dans un canal externe depuis le kit. Le fichier d’entrée **est** l’alerte.

## Rythme recommandé (consigne, pas un démon)

- Hebdomadaire : en-têtes + probe + politiques.
- À chaque release : + inventaire JS/API (hashes).
- Trimestriel : proposer un vrai mode 5 avec QA et relecture humaine.

Le kit ne lance rien tout seul. L’humain (ou son orchestrateur) rappelle ce mode.

## Stop

- Périmètre élargi « en passant » vers un sous-domaine inconnu du brief → refuse, demande une MAJ du brief.
- Tentation de fuzzer parce que le run est stérile → refuse.
- Rapport board à partir d’un run sans QA → refuse.

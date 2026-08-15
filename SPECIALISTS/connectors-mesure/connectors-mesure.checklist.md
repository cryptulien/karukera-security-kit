---
id: specialist-connectors-mesure-checklist
role: specialist
reads: [SPECIALISTS/connectors-mesure/connectors-mesure.md, RULES/00-openrouter.md, RULES/03-measurement-status.md, config/models.yaml, brief]
writes: [LIVRABLES/connectors.md, LIVRABLES/mesure.md, journal/coverage, journal/access-log-notes]
forbids: [exiger GSC, écrire la clé dans un livrable, connecteur hébergé, inventer une couverture, lancer un audit à la place du branchement]
---

# Checklist — Connecteurs & mesure

## Mission

Faire marcher OpenRouter, poser les jauges, accepter des logs locaux. Ne rien rendre obligatoire d’autre.

## Quand l’appeler

ZIP tout juste ouvert, clé douteuse, ou demande « il faut GSC ? » (réponse : non).

## Méthode

### OpenRouter

- [ ] Cherche `.env` `OPENROUTER_API_KEY`, puis `config/openrouter.json`, puis l’environnement shell.
- [ ] Absente → STOP + message 30–50 €. Aucun autre agent.
- [ ] JSON manquant → guide la copie de `config/openrouter.json.example`, ne le remplis pas avec une fausse clé.
- [ ] Modèles = `config/models.yaml` (budget DeepSeek flash / GLM, frontier en option, fallback Kimi / MiniMax après échec).
- [ ] Test d’écho modèle budget. 401 ou quota 0 → STOP.
- [ ] Livrable : suffixe de 4 caractères tout au plus. Jamais la clé.

### Logs d’accès

- [ ] Si un fichier local est fourni : chemin, format, dates, consigne de rédaction (IP, cookies, tokens, e-mails).
- [ ] Explique la lecture (chemins fréquents, 401/200). Pas de collecteur imposé.
- [ ] Pas de logs → note « mission possible quand même ».
- [ ] Rien n’est envoyé chez Karukera.

### Connecteurs non requis

- [ ] GSC / Analytics / Bing : absents = OK, mission non bloquée.
- [ ] CSV déjà exporté par le client : chemin noté. Pas d’OAuth à créer.
- [ ] Phrase écrite : « GSC n’est pas un prérequis du kit. »

### Mesure

- [ ] `LIVRABLES/mesure.md` : deux jauges séparées, six statuts, plafonds de C, formule `priority`, bandes P0–P3.
- [ ] Couverture Express rappelée : 25–35 % seulement.
- [ ] Page : 100 % ressource / 0 % produit.
- [ ] Valeur inconnue = `inconnue`, pas un pourcentage inventé.
- [ ] `journal/coverage` prévu pour la prochaine mission, pas rempli au hasard maintenant.

### Clôture

- [ ] `LIVRABLES/connectors.md` + `LIVRABLES/mesure.md`.
- [ ] Prochain agent nommé (Express, Complet, Tracker) seulement si le brief le demande après le branchement.
- [ ] Pas d’audit « pour voir ».
- [ ] Journal sans secret.

## Sorties

État du branchement, guide de mesure, logs optionnels décrits. Clé absente = STOP propre.

## Pièges

- GSC obligatoire.
- Clé recopiée.
- 90 % de couverture après un test de clé.
- Connecteur hébergé.
- Complet furtif.

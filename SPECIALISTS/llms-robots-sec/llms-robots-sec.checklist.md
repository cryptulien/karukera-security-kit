---
id: specialist-llms-robots-sec-checklist
role: specialist
reads: [SPECIALISTS/llms-robots-sec/llms-robots-sec.md, RULES/*, brief]
writes: [LIVRABLES/llms.txt, LIVRABLES/robots.txt, LIVRABLES/security.txt, LIVRABLES/justification.md, journal/findings]
forbids: [scanner le site, inventer un contact, produire un exploit, crawler hors des fichiers de politique]
---

# Checklist — llms.txt + robots de sécu

## Mission

Livrer trois fichiers prêts à servir plus une justification. Ne pas auditer l’appli.

## Quand l’appeler

Besoin d’une politique crawlers / divulgation / agents IA, pas d’un scan.

## Méthode

### Stop et lecture minimale

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] GET seulement : `/robots.txt`, `/llms.txt`, `/.well-known/security.txt`, `/sitemap.xml`. Rien d’autre.
- [ ] Sitemap : présence vérifiée, contenu non suivi.
- [ ] Brief : contact sécu, zones privées, langue, pages à citer / à exclure.

### Existant

- [ ] Chaque fichier : présent / absent, extrait, date.
- [ ] Contradictions robots ↔ llms notées.
- [ ] `security.txt` expiré ou contact manifestement placeholder (`changeme@`) noté.
- [ ] Aucun e-mail de contact inventé. Manquant → `{{CONTACT_SECU}}` ou une question.

### Rédaction robots.txt

- [ ] Domaine du brief, pas un exemple oublié.
- [ ] `Disallow` des zones authentifiées et du staging / preview.
- [ ] Bots nommés seulement si le brief les distingue. Pas de bot fantôme.
- [ ] `Sitemap:` seulement si GET 200.
- [ ] Justification rappelle : robots ≠ contrôle d’accès.

### Rédaction security.txt

- [ ] `Contact:` réel ou placeholder délimité.
- [ ] `Expires:` ISO ≤ 366 jours à partir d’aujourd’hui.
- [ ] `Preferred-Languages:` selon le brief.
- [ ] `Canonical:` URL `.well-known/security.txt` du domaine.
- [ ] `Encryption:` seulement si une clé réelle est fournie. Pas de PGP vide.

### Rédaction llms.txt

- [ ] Titre + description courte + liens **publics** voulus.
- [ ] Section d’exclusion : comptes, API, PII, paywall, test.
- [ ] Cohérent avec robots (pas d’invitation à lire un Disallow).
- [ ] `llms-full.txt` créé seulement si le brief le demande.

### Clôture

- [ ] Quatre livrables écrits, sans TBD, sans « remplir plus tard ».
- [ ] Justification : une ligne par directive.
- [ ] Findings limités aux fichiers de politique existants.
- [ ] Phrase du livrable : « Ceci n’est pas un audit, c’est une politique. »

## Sorties

`robots.txt`, `security.txt`, `llms.txt`, `justification.md` prêts à copier. Findings optionnels sur l’existant.

## Pièges

- Crawl du sitemap.
- Visite de `/admin` parce que robots le cite.
- Contact inventé.
- Promesse de protection par Disallow.

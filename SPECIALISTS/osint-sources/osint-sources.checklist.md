---
id: specialist-osint-sources-checklist
role: specialist
reads: [SPECIALISTS/osint-sources/osint-sources.md, RULES/*, ENGINE/journal.md, brief]
writes: [journal/findings, journal/evidence, LIVRABLES/osint-sources.md]
forbids: [grey scraping, social engineering, faux profil, captcha bypass, dump, citer un salarié, inventer une preuve]
---

# Checklist — OSINT léger

## Mission

Faits publics, citables, sans approcher d’humain et sans dump.

## Quand l’appeler

Avant un audit ou après une fuite **publiée**. Jamais pour profiler des personnes.

## Méthode

### Stop et périmètre

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] Domaines et orgs du brief écrits. Personnes nommées exclues.
- [ ] Axe « appelle un salarié / crée un compte / entre dans un Slack » refusé.

### Sources autorisées seulement

- [ ] DNS / CT / WHOIS public, rythme calme. 429 ou captcha → stop source, `Non testé`.
- [ ] Pages publiques de l’org, security, status, jobs techniques.
- [ ] Dépôts **publics de l’org** citée, pas les repos perso hors brief.
- [ ] Advisories / CVE seulement si le produit **et** la version sont observés, sinon pas de Confirmé.
- [ ] Fuites : uniquement avis public ou outil opt-in **lancé par le commanditaire**. Pas de dump.

### Collecte

- [ ] Sous-domaines : ceux qui apparaissent (CT, DNS, sitemap GET, repo). Pas de wordlist.
- [ ] Chaque hôte : résolution publique ou « non résolu ».
- [ ] Stack : headers, générateur, manifests publics, jobs. Sans extrapolation CVE.
- [ ] Preuve de fuite = URL citable. Extraite redactée. Zéro mot de passe, zéro hash recopié.

### Interdits vérifiés

- [ ] Pas de forum leak, marketplace, Telegram, people-search payant.
- [ ] Pas de faux profil, pas de social engineering.
- [ ] Pas de login « pour voir ».
- [ ] Pas de brute-force.

### Clôture

- [ ] Confirmé = URL publique + extrait + date.
- [ ] Livrable : sources vues, sources refusées, domaines, fuites pointées, stack, findings.
- [ ] Section « Non fait : aucune approche humaine, aucun dump, aucun grey ».
- [ ] Journal append-only.

## Sorties

Inventaire public + findings citables. Liste des refus. Pas de dossier RH, pas de dump.

## Pièges

- Login de commodité.
- CVE sans version.
- Hash « pour la preuve ».
- Enum de sous-domaines agressive.

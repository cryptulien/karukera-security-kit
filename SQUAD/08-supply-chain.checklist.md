# Checklist — 08 Supply chain

Aucune CVE sans URL d’avis et date de consultation.

- [ ] Lockfiles / SBOM publics inventoriés (`package-lock.json`, `composer.lock`, équivalents)
- [ ] Versions lues dans les lockfiles ou commentaires de bundles, jamais devinées
- [ ] Scripts et CSS hors origine listés (URL exacte, version pinnée ou non)
- [ ] Attribut `integrity` + `crossorigin` relevé ou constaté absent
- [ ] Tag managers, pixels, chats tiers listés
- [ ] Pour chaque soupçon CVE : paquet + version observée écrits avant la recherche
- [ ] Avis cité (NVD, OSV, GitHub Advisory, éditeur) avec URL et date
- [ ] Version observée comparée à la plage de l’avis — sinon pas de finding CVE
- [ ] Zéro identifiant CVE inventé
- [ ] Workflows CI publics lus s’ils sont dans le scope (secrets en clair, déclencheurs)
- [ ] Dockerfile / image seulement si le brief les donne
- [ ] Skills / serveurs MCP : URL source + pin de version transmis à 09
- [ ] Hooks `preinstall` / `postinstall` notés seulement s’ils apparaissent dans le lockfile
- [ ] Pas de « npm audit » collé comme preuve d’exploitation
- [ ] Pas de certification « aucune CVE »
- [ ] Couverture des deps (ce qui a été vu) écrite à part de la confiance
- [ ] Items hors observation listés en `Non testé`

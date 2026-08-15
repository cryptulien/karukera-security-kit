---
id: specialist-mobile-api-checklist
role: specialist
reads: [SPECIALISTS/mobile-api/mobile-api.md, RULES/*, ENGINE/journal.md, brief]
writes: [journal/findings, journal/evidence, LIVRABLES/mobile-api-rapport.md]
forbids: [inventer une preuve, produire un exploit, bypass de pinning, script d’instrumentation, fuzz API]
---

# Checklist — Mobile / API mobile

## Mission

Observe jetons, pinning déclaré, deep links et API compagnon. Zéro payload.

## Quand l’appeler

App du commanditaire + API, avec build, repo ou captures **fournies**.

## Méthode

### Stop et matériel

- [ ] Clé OpenRouter présente. Sinon STOP + message 30–50 €.
- [ ] Autorisation : app et API du commanditaire seulement.
- [ ] Matériel listé : build de test / repo / captures client / comptes. Ce qui manque = `Non testé`, pas un bypass.
- [ ] Frida, Objection, patch APK, dump mémoire, MITM contre pinning : refusés et notés comme hors contrat.

### API compagnon

- [ ] Hôtes et chemins documentés ou vus dans les captures inventoriés.
- [ ] Schéma d’auth décrit (Bearer, cookie, clé d’app). Expiration notée si visible.
- [ ] Requêtes légitimes du compte de test seulement.
- [ ] Pas de JWT `alg=none`, pas de verb tampering, pas de fuzz.

### Jetons appareil

- [ ] Push, device_id, refresh, cookie persistant : listés s’ils apparaissent.
- [ ] Lieu de stockage **déclaré ou vu** (keychain mentionné, prefs, log). Rien d’extrait de force.
- [ ] Jeton dans une URL ou un log fourni : finding, extrait redacté.

### Pinning et transport

- [ ] Config lue : ATS, NSPinnedDomains, network_security_config, CertificatePinner / TrustKit dans le repo.
- [ ] Absence de pinning Confirmé seulement sur config lue, pas sur « j’ai réussi à proxifier » (et tu n’essaies pas).
- [ ] Aucune instruction de bypass dans les notes.

### Deep links

- [ ] Schémas lus dans plist / intent-filters / assetlinks / AASA.
- [ ] Liens de **test fournis** ouverts seulement.
- [ ] Auth exigée ou non, id / token dans l’URL consignés.
- [ ] Aucune URI malveillante construite.

### Session, stockage, WebView

- [ ] Liaison device/session : testée seulement si deux appareils/sessions de test existent, sinon `Non testé`.
- [ ] PII / Authorization dans les logs ou captures fournis.
- [ ] WebView : cookies partagés et JS bridge **lus dans le code**, jamais injectés.

### Clôture

- [ ] Confirmé = config ou trafic réellement lu.
- [ ] Tout ce qui exigeait un bypass = `Non testé` + raison.
- [ ] Scores I/E/C/F/V, C plafonné, preuves datées.
- [ ] Livrable + section « Non fait : aucun bypass, aucun payload ».
- [ ] Journal append-only.

## Sorties

Carte API, tableau jetons, état du pinning, deep links, findings. Pas de PoC mobile.

## Pièges

- PoC « éducatif » de pinning.
- Deep link inventé.
- Store d’un tiers.
- Absence de pinning = P0 automatique.

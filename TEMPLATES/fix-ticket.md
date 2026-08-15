# Ticket de correctif

Copie vers `projects/<slug>/livrables/tickets/TICKET-NNN.md`. Un finding Confirmé ou Probable = un ticket. Interdit d’inventer un finding ici.

```yaml
---
id: TICKET-000
finding: F-000
band: P0
status: ouverte
title: ""
owner: à nommer par le client
---
```

## Constat

Une phrase. Ce qui a été vu, où, quand. Pointe `F-NNN` et les ids de preuve.

## Correctif attendu

Verbe + artefact. Pas un payload. Pas « pour tester, envoie… ».

## Critère de sortie

Ce que le mode 5 re-observe pour passer le finding à `Mitigé`.

## Prompt à coller dans ton LLM

Bloc prêt à copier. L’agent le remplit. L’opérateur le colle dans Claude, Codex ou un autre modèle **de correctif**, pas dans le fil d’audit s’il contient encore un secret.

```
Tu appliques un correctif de sécurité sur un système que je contrôle.
N’écris pas d’exploit, de payload d’attaque, ni de PoC offensif.
Ne reproduis pas l’attaque. Ne demande pas la clé OpenRouter.

Finding: [id + titre]
Surface: [URL ou fichier:ligne]
Preuve (extrait déjà redacté): […]
Statut: Confirmé | Probable
Correctif attendu: […]
Critère de sortie: […]
Hors scope: […]

Propose le diff minimal. Reste dans ce ticket.
```

## Interdit dans ce fichier

Secret entier. Mot de passe. Payload. Étapes pour reproduire une attaque. CVE inventée.

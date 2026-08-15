# Guide — Usage autorisé

Audite seulement ce que tu as le droit d’auditer. Le kit ne te donne aucun droit supplémentaire.

## Qui signe

Toi (si c’est ton système) ou le mandataire écrit du client (RSSI, fondateur, counsel). Un Slack « go » ne suffit pas pour le mode 7. Un brief oral ne suffit pas pour sortir du scope.

## Périmètre

Écris, avant le premier agent :

- hôtes et URL
- comptes et rôles de test
- environnements (prod / préprod)
- dates de début et de fin
- hors-scope (filiales, prestataires, paiements tiers, données santé réelles)

Hors liste = hors mission. Si la surface mapper découvre un hôte voisin : journalise, demande, n’enchaîne pas.

## Interdit, encore

Pas d’exploit. Pas de payload. Pas de PoC d’attaque. Pas de DoS. Pas de bruteforce. Pas de lecture d’un autre client réel. Si une donnée étrangère apparaît : stop, tronque, statut `hors scope`, préviens le mandataire.

## Mode 7 — fichier `authorization.md`

Place-le à la racine de la mission. Sans ce fichier **ou** sans `AUTHORIZED=yes` : **stop**.

Reproduis ces champs, remplis-les, fais signer :

```md
# Autorisation d’exercice — mode 7

- mandataire :
- organisation :
- signataire (nom, fonction, e-mail) :
- date de signature :
- début :
- fin :
- hôtes / URL :
- comptes de test :
- hors-scope :
- données interdites :
- contact d’urgence :

Je confirme que Karukera Security Kit s’exécute sur ce périmètre seulement.
Aucun exploit, aucun payload, aucun PoC d’attaque n’est demandé.
AUTHORIZED=yes
```

Retire `AUTHORIZED=yes` dès la fin de fenêtre.

## Preuve d’autorisation

Le rapport cite le nom du signataire et les dates. Il ne joint pas de pièce d’identité. Il ne publie pas les comptes de test.

## Responsabilité

Pas de garantie d’exhaustivité. La couverture dit ce qui a été vu. L’absence de finding n’est pas une attestation de sécurité.

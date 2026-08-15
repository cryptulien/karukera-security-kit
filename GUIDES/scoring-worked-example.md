# Guide — Exemple travaillé de scoring

Finding **fictif**, cible de laboratoire `https://lab.exemple.tld`. Sert à caler la main. Ne le copie pas sur une vraie mission.

## Finding

- id : `F-014`
- titre : IDOR lecture facture entre deux organisations
- statut : `Confirmé`
- surface : `GET https://lab.exemple.tld/api/invoices/1842`
- extrait : `{"org_id":"org-B","total":1900,"iban":"FR76…1234"}` renvoyé avec la session `org-A`
- date : `2026-08-15T10:12:00Z`
- méthode : même utilisateur, deux org, simple changement d’id, sans élévation

## Notes

I = 5 (données financières d’un autre tenant).  
E = 4 (utilisateur authentifié, pas d’autre prérequis).  
C = 5 (Confirmé, plafond 5, chaîne complète).  
F = 2 (contrôle d’appartenance sur la requête).  
V = 3 (il faut un compte, l’id n’est pas public).

## Calcul

```
0.30*I = 0.30*5 = 1.50
0.25*E = 0.25*4 = 1.00
0.20*C = 0.20*5 = 1.00
0.15*V = 0.15*3 = 0.45
somme   = 3.95
10*somme = 39.5
- 2*F   = -4
priority = 35.5  →  P0
```

## Même fait, mal mesuré

Si personne n’a appelé l’API et que l’agent « suppose » un IDOR :

- statut `Hypothèse`
- C plafonné à 2 (tu n’as pas le droit d’écrire 5)

```
0.30*5 + 0.25*4 + 0.20*2 + 0.15*3 = 1.50 + 1.00 + 0.40 + 0.45 = 3.35
10*3.35 - 2*2 = 33.5 - 4 = 29.5  →  P1
```

L’impact n’a pas changé. La bande oui. C’est voulu.

## Autre exemple : en-tête manquant

- statut `Confirmé` (réponse vue, `Content-Security-Policy` absent)
- I = 2, E = 3, C = 5, F = 1, V = 5

```
0.30*2 + 0.25*3 + 0.20*5 + 0.15*5 = 0.60 + 0.75 + 1.00 + 0.75 = 3.10
10*3.10 - 2*1 = 31.0 - 2 = 29.0  →  P1
```

Ne hisse pas ce finding en P0 « parce que CSP ». La formule tranche.

## Faux positif

Contre-preuve : l’id `1842` appartient déjà à `org-A` après relecture du dump autorisé. Statut `Faux positif`. C = 1. priority = 0. Garde l’entrée. Ne la recycle pas en `Non testé`.

## Couverture à côté

Sur cette mission fictive : 8 / 30 routes API, 2 / 4 rôles, 2 / 2 org de labo. Couverture API ≈ 27 %. Cela n’abaisse pas C de `F-014`. Cela s’écrit dans la jauge de couverture, pas dans le finding.

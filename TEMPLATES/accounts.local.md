# Comptes de test — local, jamais le chat

Copie vers `projects/<slug>/accounts.local.md`. Ce fichier est ignoré avec tout `projects/`.

L’agent peut le lire pour se connecter. Il ne recopie aucune valeur dans le journal, le rapport, un ticket ou le chat.

```yaml
accounts:
  - email: auditor-a@exemple.tld
    role: member
    tenant: org-a
    password: ""          # ou laisse vide si tu es déjà connecté
    totp: ""
  - email: auditor-b@exemple.tld
    role: admin
    tenant: org-b
    password: ""
    totp: ""
notes: ""
```

Si le champ mot de passe est vide : l’agent travaille avec la session déjà ouverte, ou marque les tests authentifiés `Non testé`.

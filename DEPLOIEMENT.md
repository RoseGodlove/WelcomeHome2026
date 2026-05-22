# Deploiement du site familial

Le site peut rester 100% statique et utiliser Supabase comme base de donnees partagee. Chaque membre de la famille ouvre la meme URL; les modifications sont sauvegardees dans Supabase et se synchronisent sur les autres appareils.

## 1. Creer la base Supabase

1. Aller sur https://supabase.com et creer un projet.
2. Ouvrir `SQL Editor`.
3. Coller et executer le contenu de `supabase-maison.sql`.

Le SQL cree la table `maison_app_state`, autorise la lecture/ecriture avec la cle publique `anon`, et active la synchronisation temps reel.

Cette configuration est simple: toute personne qui a le lien du site peut lire et modifier les donnees. Pour une famille, c'est souvent suffisant; pour ajouter un mot de passe plus tard, il faudra ajouter une authentification.

## 2. Brancher le site a Supabase

Dans `maison_maman.html`, remplir ces deux lignes:

```js
const SUPABASE_URL = 'https://TON-PROJET.supabase.co';
const SUPABASE_ANON_KEY = 'TA-CLE-ANON-PUBLIC';
```

Tu trouves ces valeurs dans Supabase: `Project Settings` -> `API`. La cle `anon public` est faite pour etre visible dans un site web; elle n'est pas un mot de passe administrateur.

## 3. Deployer le site

Option la plus simple: Netlify.

1. Aller sur https://app.netlify.com/drop.
2. Glisser le dossier du projet complet.
3. Netlify donne une URL publique.
4. Partager cette URL avec la famille.

Option GitHub Pages:

1. Pousser ce repo sur GitHub.
2. Aller dans `Settings` -> `Pages`.
3. Source: `Deploy from a branch`.
4. Branch: `main`, folder: `/root`.
5. L'URL ouvrira `index.html`, qui redirige vers `maison_maman.html`.

## 4. Tester

1. Ouvrir l'URL sur deux appareils ou deux navigateurs.
2. Ajouter un participant ou modifier un statut d'achat.
3. L'autre appareil devrait recevoir la modification automatiquement en quelques secondes.

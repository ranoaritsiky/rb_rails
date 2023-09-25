# Nom du Projet

Description concise du projet.

## Table des matières

- [Aperçu](#aperçu)
- [Getting Started (Démarrage)](#getting-started)
  - [Prérequis](#prérequis)
  - [Installation](#installation)
- [Utilisation](#utilisation)

## Aperçu

souhaitons créer une API-ONLY Ruby on Rails pour gérer les gardiens (Reporters) de
différentes entreprises (Companies). 
Chaque entreprise peut avoir plusieurs gardiens, et
nous voulons également que chaque fois qu'un nouveau gardien est créé, un fichier CSV
contenant des informations sur ce gardien soit généré et envoyé à un service externe de
stockage.
## Getting Started (Démarrage)

git clone https://github.com/ranoaritsiky/rb_rails.git

### Prérequis


Exemple :
- Docker
- Compte GitHub
- Docker-compose

### Installation

Pour commencer:
- docker-compose build
- docker-compose up

Les endpoints disponible

Endpoint pour Company :
- GET /api/companies : Récupère la liste de toutes les entreprises.
- GET /api/companies/:id : Récupère une entreprise spécifique par son ID.
- POST /api/companies : Crée une nouvelle entreprise.
- PUT /api/companies/:id : Met à jour les informations d'une entreprise existante.
- DELETE /api/companies/:id : Supprime une entreprise.

Endpoint pour Reporter :
- GET /api/reporters : Récupère la liste de tous les gardiens.
- GET /api/reporters/:id : Récupère un gardien spécifique par son ID.
- POST /api/reporters : Crée un nouveau gardien. Après la création du gardien, un fichier CSV
devrait être généré et envoyé à un service externe de stockage (voir les instructions ci-
dessous).

- PUT /api/reporters/:id : Met à jour les informations d'un gardien existant.
- DELETE /api/reporters/:id : Supprime un gardien.


Après avoir créé un nouveau gardien (Reporter), génère un fichier CSV contenant des
informations sur ce gardien. Le fichier CSV devrait contenir au moins les colonnes name et
email.

Une fois le fichier CSV est créer, le fichier sera envoyé à dropbox en utilisant une clés access_token à mettre à jour

Pour Lancer les test unitaire :
1. rails test

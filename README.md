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

Lancer les test unitaire :
1. rails test

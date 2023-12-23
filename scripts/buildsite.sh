#!/bin/bash

# Supprime et recrée le dossier public/
echo "Rebuilding site."
rm -rf public/
mkdir public/

# Exécute make avec la cible 'all' pour reconstruire le site
make all




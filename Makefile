# Liste des fichiers HTML dans le dossier pages/
PAGES=$(wildcard pages/*.html)

# Règle générique pour chaque page
public/%.html: pages/%.html layout/before.html layout/after.html
	./scripts/buildpages.sh $<

# Règle pour la cible factice 'all' (toutes les pages)
all: public $(patsubst pages/%.html, public/%.html, $(PAGES))

# Règle pour construire le dossier public/
public: $(wildcard assets/*)
	mkdir -p public
	cp -ur assets/* public/
	touch public

# Règle pour nettoyer le projet (supprimer public/)
clean:
	rm -rf public/

# Règle pour tester le site avec un serveur web local
test: all
	python3 -m http.server -d public 8000



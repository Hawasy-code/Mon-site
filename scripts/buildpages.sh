#!/bin/bash

 function buildpage {
 	FILE="${1#pages/}"
 	
 	# Récupération du titre de la page depuis la première ligne du fichier
    	TITLE=$(head -n 1 "${1}")
    	
    	 # Ajout du titre dans before.html
    	sed -i "s~{{TITLE}}~${TITLE}~g" layout/before.html
    	
    	# Affichage du contenu de la page sans la première ligne (le titre)
    	tail -n +2 "${1}"
    	
    	# Récupération de la date actuelle au format souhaité (ici : DD-MM-YYYY)
    	DATE=$(date +"%d-%m-%Y")
    
    	# Ajout de la date dans after.html
    	sed -i "s~{{DATE}}~${DATE}~g" layout/after.html index.html
    	
    	# Ajout de la classe "current" au lien vers la page en construction
   	sed -i "s~href=\"${FILE}\"~& class=\"current\"~g" layout/before.html
 	cat layout/before.html
 	cat "${1}"
	cat layout/after.html
 }

 if [[ "${1}" = "" ]]; then # premier argument obligatoire : le nom de la page
 	echo "Usage: ${0} PAGE" >&2
 	exit 1
 elif test ! -f "${1}"; then # et doit correspondre à une page existante
 	echo "${0}: error: ${1}: no such file" >&2
 	exit 1
 else
 	buildpage "${1}" > "public/${1#pages/}"
 fi





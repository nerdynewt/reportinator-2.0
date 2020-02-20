#!/bin/bash

source reportinator.conf

while getopts ":a:h:c" opt; do
  case $opt in
    h)
      echo "Reportinator 2.0"
      echo "options:"
      echo " -h                  help"
      echo " -c                  interactively reconfigure"
      exit
      ;;
     c)
	  read -p "Reconfigure Reportinator? Your previous configuration will be lost! (y,N)" yn
    case $yn in
        [Yy]* ) echo "Proceeding"; exit;;
        [Nn]* ) echo "Exiting..."; exit;;
        * ) echo "Exiting..."; exit;;
    esac
    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


PROJECT_FOLDER=$TEX_ROOT$(ls $TEX_ROOT | fzf --prompt="Choose Project: ")


if [[ "$(ls $PROJECT_FOLDER)" == *.csv* ]]; then
	echo "Found " $(ls $PROJECT_FOLDER | grep -o .csv  | wc -l) " csv files"
	cp $PROJECT_FOLDER/*.csv dat/tables/
else
	read -p "No csv files found. Do you wish to proceed anyway? (y,N)" yn
    case $yn in
        [Yy]* ) echo "Proceeding";;
        [Nn]* ) echo "Exiting..."; exit;;
        * ) echo "Exiting..."; exit;;
    esac
fi

if [[ "$(ls $PROJECT_FOLDER | grep -o .tex  | wc -l)" -eq 0 ]]; then
	echo "No template file found. Using built-in template."
elif [[ "$(ls $PROJECT_FOLDER | grep -o .tex  | wc -l)" -eq 1 ]]; then
	echo "Found a template file." 
	cp $PROJECT_FOLDER/*.tex dat/template.tex
else 
	TEMPLATE=$(ls $PROJECT_FOLDER | grep .tex | fzf --header="Found more than one tex file. Choose one to use as template.")
	cp $PROJECT_FOLDER/$TEMPLATE dat/template.tex
fi

echo "" > dat/output.tex
while read -r line; do
	if [[ "$line" == *"~observations~"* ]]; then
		printf "%s\n" $(python lib/tabler.py) >> dat/output.tex
	elif [[ "$line" == "*~graphs~*" ]]; then
		printf "%s\n" $(python lib/grapher.py) >> dat/output.tex
	elif [[ "$line" == "*~errors~*" ]]; then
		printf "%s\n" $(python lib/errorer.py) >> dat/output.tex	
	else
		printf "%s\n" "$line" >> dat/output.tex

	fi
done <dat/template.tex

printf 'hello\r'






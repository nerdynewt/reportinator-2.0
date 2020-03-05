#!/bin/bash

source reportinator.conf

while getopts ":ahc" opt; do
  case $opt in
    h)
      echo "Reportinator 2.0"
      echo "options:"
      echo " -h                  help"
      echo " -c                  interactively reconfigure reportinator"
      exit
      ;;
     c)
         bash install.sh; exit;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

if [[ $TEX_RECONFIG == "yes" ]]; then
	echo "Peforming initial setup..."
	sleep 1
	bash install.sh
	echo "Initialization complete! You're ready to use Reportinator now."
	echo "Press any key"
	read -n 1
	exit
fi

PROJECT_FOLDER=$TEX_ROOT$(ls $TEX_ROOT | fzf --prompt="Choose Project: ")

rm -r modules/dat
cp -r modules/dat-template modules/dat

if [[ "$(ls $PROJECT_FOLDER)" == *.csv* ]]; then
	echo "Found " $(ls $PROJECT_FOLDER | grep -o .csv  | wc -l) " csv files"
	cp $PROJECT_FOLDER/*.csv modules/dat/tables/
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
	cp $PROJECT_FOLDER/*.tex modules/dat/template.tex
else 
	TEMPLATE=$(ls $PROJECT_FOLDER | grep .tex | fzf --header="Found more than one tex file. Choose one to use as template.")
	cp $PROJECT_FOLDER/$TEMPLATE modules/dat/template.tex
fi

echo "" > modules/dat/output.tex
while read -r line; do
	if [[ "$line" == *"~"*"~"* ]]; then
		if [[ "$line" == *"-"* ]]; then
			arguments=$(echo $line | sed -e 's/.*-\(.*\)~.*/\1/')
			filename="$(echo $line | sed -e 's/.*~\(.*\)-.*/\1/')".py""
						if test -f "modules/"$filename; then
							python modules/$filename $arguments >> modules/dat/output.tex

			else
				echo $filename "$filename doesn't refer to any available module"
			fi
		else
			filename="$(echo $line | sed -e 's/~\(.*\)~/\1/')".py""
			if test -f "modules/"$filename; then
				python modules/$filename >> modules/dat/output.tex
			else
				echo $filename "$filename doesn't refer to any available module"
			fi
	fi
		# printf "%s\n" $(python modules/tabler.py) >> modules/dat/output.tex	
	else
		printf "%s\n" "$line" >> modules/dat/output.tex

	fi
done <modules/dat/template.tex

cp -r modules/dat/ $PROJECT_FOLDER/

# printf 'hello\r'

echo "Process Complete, opening TeX file..."
sleep 0.3
$TEX_EDITOR $PROJECT_FOLDER/output.tex 

#TODO set root folder variable in config



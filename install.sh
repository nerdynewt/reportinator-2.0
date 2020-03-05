#!/bin/bash

source reportinator.conf


if [[ $TEX_RECONFIG == "no" ]]; then
	read -p "Reconfigure Reportinator? Your previous configuration will be lost! (y,N)" yn
    case $yn in
        [Yy]* ) echo "Reinstalling..."
					;;
        [Nn]* ) echo "Exiting..."; exit ;;
        * ) echo "Exiting..."; exit;;
esac
fi



if ! [ -x "$(command -v fzf)" ]; then
		read -p "WARNING: fuzzy-finder (https://github.com/junegunn/fzf) is not installed, and it is recommended that you do. Try to install it? You might be prompted for the admin password. (Y/n)" yn
    case $yn in
        [Yy]* ) if [ -x "$(command -v apt-get)" ]; then
				sudo apt-get install fzf
				elif [ -x "$(command -v pacman)" ]; then
					sudo pacman -S fzf
				elif [ -x "$(command -v dnf)" ]; then
					sudo dnf install fzf -y
				elif [ -x "$(command -v brew)" ]; then
					brew install fzf
				else 
					echo "Sorry, couldn't install package. You could try following instructions over at https://github.com/junegunn/fzf."
				fi
					;;
        [Nn]* ) echo "Skipping fzf install..."; exit ;;
        * ) echo "Exiting..."; exit;;
esac
fi

if [[ $TEX_ROOT == "unset" ]]; then
		read -p "Specify a project root folder (This is where you'll be keeping all your LaTeX Projects, ex. Documents/Reports/): " TEX_ROOT
		echo $TEX_ROOT
else
		read -p "Your project root folder is set to $TEX_ROOT. Change it? (y/N)" yn
		case $yn in
        [Yy]* ) read -p "Specify a project root folder (This is where you'll be keeping all your LaTeX Projects, ex. Documents/Reports/): " TEX_ROOT
					;;
esac
fi

if [[ $TEX_RECONFIG == "yes" ]]; then
	TEX_RECONFIG="no"
fi

echo $TEX_ROOT

while read line; do
	if [[ $line == "TEX_EDITOR"* ]]; then
		echo "TEX_EDITOR="$TEX_EDITOR >> temp.conf
	elif [[ $line == "TEX_ROOT"* ]]; then
		echo "TEX_ROOT="$TEX_ROOT >> temp.conf
	elif [[ $line == "TEX_INPUT"* ]]; then
		echo "TEX_INPUT="$TEX_INPUT >> temp.conf
	elif [[ $line == "TEX_RECONFIG"* ]]; then
		echo "TEX_RECONFIG="$TEX_RECONFIG >> temp.conf	
	else
		echo $line >> temp.conf
	fi
done < reportinator.conf

cat temp.conf > reportinator.conf
rm temp.conf

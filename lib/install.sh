#!/bin/bash

source /Users/vishnunamboodiri/Code/reportinator-2.0/reportinator.conf


if [[ $TEX_RECONFIG == "no" ]]; then
	read -p "Reinstall Reportinator? (y/N)" yn
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

echo "Type in the path to the folder where you'll be keeping all your LaTeX projects:" \n
read -p ":" 

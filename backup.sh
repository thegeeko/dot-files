#!/bin/bash

if [ ! -d .git ]; then
	echo "ERROR : plz run this script inside the dot files repo" 
	exit
fi;

nvimc="$HOME/.config/nvim"
swayc="$HOME/.config/sway"
waybarc="$HOME/.config/waybar"
wofic="$HOME/.config/wofi"
qtilec="$HOME/.config/qtile"
fishc="$HOME/.config/fish"
dunstc="$HOME/.config/dunst"
alacrittyc="$HOME/.config/alacritty"

xinitrc="$HOME/.xinitrc"

function backup () {
	if [ ! -d $1 ] && [ ! -f $1 ]; then 
		echo "WARNNING : no $(basename $1) config"
		return
	fi;

	rsync -a --exclude "$2" $1 ./  
}

backup "$nvimc" "plugin"
backup "$swayc"
backup "$waybarc"
backup "$wofic"
backup "$qtilec" "__pycache__"
backup "$fishc"
backup "$dunstc"
backup "$alacrittyc"
backup "$xinitrc"

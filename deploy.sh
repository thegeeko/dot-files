#!/bin/sh

if [ ! -d .git ]; then
	echo "ERROR : plz run this script inside the dot files repo" 
	exit
fi;

if [ ! -d $HOME/.config ]; then
	echo "no .config folder \n creating one ..."
	mkdir $HOME/.config
fi

nvimc="$HOME/.config/nvim"
swayc="$HOME/.config/sway"
waybarc="$HOME/.config/waybar"
wofic="$HOME/.config/wofi"
qtilec="$HOME/.config/qtile"
fishc="$HOME/.config/fish"
dunstc="$HOME/.config/dunst"
alacrittyc="$HOME/.config/alacritty"

xinitrc="$HOME/.xinitrc"

function deploy () {
	conf=$(basename $1)
	if [ ! -d $conf ] && [ ! -f $conf ]; then 
		echo "WARNNING : no $conf config"
		return
	else
		echo "found $conf"
	fi;
	
	echo "linking $conf"
	ln -s $conf $1
}

deploy "$nvimc" 
deploy "$swayc"
deploy "$waybarc"
deploy "$wofic"
deploy "$qtilec"
deploy "$fishc"
deploy "$dunstc"
deploy "$alacrittyc"
deploy "$xinitrc"


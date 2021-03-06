from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import extension

dmenu_scripts="/home/thegeeko/scripts/dmenu/"

terminal = guess_terminal()
mod = "mod4"
keys = [
	# Switch between windows
	Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
	Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
	Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
	Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
	# Key([mod], "space", lazy.layout.next(),
	#     desc="Move window focus to other window"),
	# Move windows between left/right columns or move up/down in current stack.
	# Moving out of range in Columns layout will create new column.
	Key(
		[mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
	),
	Key(
		[mod, "shift"],
		"l",
		lazy.layout.shuffle_right(),
		desc="Move window to the right",
	),
	Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
	Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
	# Grow windows. If current window is on the edge of screen and direction
	# will be to screen edge - window would shrink.
    Key([mod, "control"], "l", lazy.layout.shrink(), desc="Grow window to the left"),
	Key(
		[mod, "control"], "h", lazy.layout.grow(), desc="Grow window to the right"
	),
	Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
	Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
	Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
	# Toggle between split and unsplit sides of stack.
	# Split = all windows displayed
	# Unsplit = 1 window displayed, like Max layout, but still with
	# multiple stack panes
	Key(
		[mod, "shift"],
		"Return",
		lazy.layout.toggle_split(),
		desc="Toggle between split and unsplit sides of stack",
	),
	Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
	# Toggle between different layouts as defined below
	Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
	Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
	Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
	Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
	Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
	Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play-Pause key"),
	Key(
		[],
			"XF86AudioStop",
		lazy.spawn("playerctl play-pause -p spotify"),
		desc="Play-Pause Spotify key",
	),
	Key(
		[],
		"XF86AudioRaiseVolume",
		lazy.spawn("amixer -q sset Master 2+"),
		desc="volume up",
	),
	Key(
		[],
		"XF86AudioLowerVolume",
		lazy.spawn("amixer -q sset Master 2-"),
		desc="volume down",
	),
	Key(
		[],
		"XF86AudioMute",
		lazy.spawn("amixer -D pulse set Master 1+ toggle"),
		desc="mute",
	),
	Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="next"),
	Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="prev key"),
	Key([], "Print", lazy.spawn("flameshot gui"), desc="screenshot 'flameshot'"),
	Key([mod], "g", lazy.spawn("google-chrome-stable"), desc="chrome"),
	#Key(["mod1"], "space", lazy.spawn("rofi -show drun -show-icons"), desc="rofi menu"),
	Key(["mod1"], "space", lazy.spawn("dmenu_run"), desc="rofi cmds"),
	Key([mod], "Caps_Lock", lazy.spawn("nocaps"), desc="reset caps lock and switch it with escape"),
	Key(
		[mod],
		"space",
		lazy.widget["keyboardlayout"].next_keyboard(),
		desc="Next keyboard layout.",
	),
	KeyChord([mod], 'd',[
		Key([], 'o', lazy.spawn(dmenu_scripts+"code.sh")),
		Key([], 'p', lazy.spawn("passmenu")),
		Key([], 'c', lazy.spawn(dmenu_scripts+"configs.sh")),
	]),
]

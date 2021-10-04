from typing import Text
from libqtile import bar, widget
from libqtile.config import Screen;

black="#181A18"
yellow = "#f1fa8c"
lightYellow="#fcfee8"
pink = "#ff79c6"
lightPink="#FFC9E8"
green = "#50fa7b"
purple = "#bd93f9"
lightPurple="#E4D3FC"

def windowNameFilter(name) :
	if len(name.split(' - ')) != 1 :
		return name.split(' - ')[-1]
	else :
		return name.split(' ')[0]

lineForBar = widget.TextBox(text='|', padding=2)


topBar = bar.Bar(
	widgets=[
		widget.TextBox(
			text='<span size="larger" weight="bold">Geny</span>',
			background=pink,
			padding=10,
		),
		widget.GroupBox(
			margin_y = 3,
			margin_x = 0,
			padding_y = 5,
			padding_x = 3,
			borderwidth = 3,
			active = lightPurple,
			rounded = False,
			highlight_color = purple,
			highlight_method = "line",
		),
		widget.TextBox(
			foreground=yellow,
			text="",
			padding=7,
			fontsize=20
		),
		widget.WindowName(
			empty_group_string="Bsbsbsbsbsb",
			parse_text=windowNameFilter,
			foreground=yellow,
			font="mononoki Bold",
			padding=0,
			fontsize=13,
		),
		widget.Clock(format="%Y-%m-%d %I:%M %p"),
		widget.Spacer(),
		widget.TextBox(
			background=lightPurple,
			text="♫",
			fontsize=20
		),
		widget.Mpris2(
			name="spotify",
			objname="org.mpris.MediaPlayer2.spotify",
			background=purple,
			display_metadata=["xesam:title", "xesam:artist"],
			stop_pause_text="play some music <3",
			scroll_interval=0,
			padding=10
		),
		widget.TextBox(
			background=lightPink,
			text="↓↑",
			fontsize=15
		),
		widget.Net(
			interface="wlp2s0f0u3",
			format='{down} : {up}',
			background=pink,
			padding=10
		),
		widget.QuickExit(
			padding=10,
			default_text='<span size="larger" foreground="red" weight="bold">⏻</span>'
		),
		widget.Spacer(length=10)
	],
    size=20
)

bottomBar = bar.Bar(
	widgets=[
		widget.Spacer(length=10),
		widget.KeyboardLayout(configured_keyboards=['us', 'ar']),
		lineForBar,
		widget.CurrentLayout(foreground=yellow, fontsize=13),
		lineForBar,
		widget.Prompt(background=yellow, foreground=black),
		widget.Wlan(
			interface="wlp2s0f0u3",
			format="{essid} {percent:2.0%}"
		),
		lineForBar,
		widget.CPU(
			format='CPU : {freq_current}GHz {load_percent}%',
			foreground=pink
		),
		lineForBar,
		widget.CheckUpdates(
			update_interval = 30,
			distro = "Arch",
			display_format = "Updates : {updates}",
			foreground = purple,
			no_update_string = "Updated :3"
		),
		lineForBar,
		widget.TextBox(text="CPU :",foreground=yellow),
		widget.ThermalSensor(tag_sensor="Tctl"),
		lineForBar,
		widget.TextBox(text="GPU :",foreground=yellow),
		widget.ThermalSensor(tag_sensor="edge"),
		lineForBar,
		widget.TextBox(text="Vol :",foreground=pink),
		widget.Volume(mute_command="amixer -D pulse set Master 1+ toggle"),
		lineForBar,
		widget.WindowName(
			foreground=yellow,
			font="mononoki Bold",
			padding=0,
			fontsize=13,
		),
		widget.Chord(),
		widget.Systray(),
		widget.Spacer(length=20),
	],
	size=18
)

screens = [
	Screen(
		top=topBar,
		bottom=bottomBar
	),
]


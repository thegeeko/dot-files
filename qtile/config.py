# Qtile config ;-; Geeko

from typing import List  # noqa: F401

from libqtile import  layout
from libqtile.config import Click, Drag, Group, Key, Match
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from keys import keys
from screens import screens

mod = "mod4"
terminal = guess_terminal()
keys = keys
screens = screens
group_names = [
	("TER", {"layout": "monadtall"}),
	("WWW", {"layout": "max"}),
	("DEV", {"layout": "max"}),
	("NOTE", {"layout": "max"}),
	("ANY", {"layout": "monadtall"}),
	("ANY", {"layout": "monadtall"}),
	("GFX", {"layout": "floating"}),
	("CHAT", {"layout": "monadtall", "spawn": "discord "}),
	("MUS", {"layout": "max", "spawn": "spotify"}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
  keys.append(
		Key([mod], str(i), lazy.group[name].toscreen())
  )  # Switch to another group
  keys.append(
		Key([mod, "shift"], str(i), lazy.window.togroup(name, switch_group=True))
  )  # Send current window to another group

layoutConf = {
	'border_normal' :"#FFC9E8",
	'border_focus' : "#ff79c6",
}

layouts = [
	layout.Max(),
	layout.MonadTall(**layoutConf),
	layout.MonadWide(**layoutConf),
	layout.Floating(**layoutConf),
	# layout.TreeTab(),
	# layout.VerticalTile(),
]

widget_defaults = dict(
	font="mononoki Nerd Font",
	fontsize=12,
	padding=3,
)
extension_defaults = widget_defaults.copy()

# Drag floating layouts.
mouse = [
	Drag(
		[mod],
		"Button1",
		lazy.window.set_position_floating(),
		start=lazy.window.get_position(),
	),
	Drag(
		[mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
	),
	Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
	float_rules=[
		# Run the utility of `xprop` to see the wm class and name of an X client.
		*layout.Floating.default_float_rules,
		Match(wm_class="confirmreset"),  # gitk
		Match(wm_class="Hello OpenGL"),  # gitk
		Match(wm_class="makebranch"),  # gitk
		Match(wm_class="maketag"),  # gitk
		Match(wm_class="ssh-askpass"),  # ssh-askpass
		Match(title="branchdialog"),  # gitk
		Match(title="pinentry"),  # GPG key password entry
		Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
	]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "LG3D"

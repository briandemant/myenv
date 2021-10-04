https://www.ptmr.io/blog/custom-keyboard-layout-for-coding-on-ubuntu-linux
setxkbmap brde
setxkbmap us
setxkbmap dk
xmodmap -e 'keycode 134 = Mode_switch'



setxkbmap -print -verbose 10

Setting verbose level to 10
locale is C
Trying to load rules file ./rules/evdev...
Trying to load rules file /usr/share/X11/xkb/rules/evdev...
Success.
Applied rules from evdev:
rules:      evdev
model:      macbook79
layout:     brde
options:    lv3:rwin_switch,terminate:ctrl_alt_bksp
Trying to build keymap using the following components:
keycodes:   evdev+aliases(qwerty)
types:      complete+numpad(mac)
compat:     complete
symbols:    pc+brde+inet(evdev)+level3(rwin_switch)+terminate(ctrl_alt_bksp)
geometry:   macintosh(macbook79)
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete+numpad(mac)"	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+brde+inet(evdev)+level3(rwin_switch)+terminate(ctrl_alt_bksp)"	};
	xkb_geometry  { include "macintosh(macbook79)"	};
};

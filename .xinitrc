# input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx5 &

# for background
nitrogen --restore &
#xloadimage -onroot -fullscreen "~/Pictures/Konachan.com - 128480 doll kasugano_sora ohara_tometa school_uniform sphere thighhighs yosuga_no_sora.jpg"

# for gnome-terminal
# ref https://ocg.aori.u-tokyo.ac.jp/member/daigo/comp/memo/?val=all&typ=all&nbr=2020021301
# dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY gnome-terminal

# cursor style
xsetroot -cursor_name left_ptr

# diable blackout
xset -dpms
xset s off

# disable beep
xset b 0

# set keyboard style
setxkbmap -layout jp

#window manager
xmonad --recompile
exec xmonad


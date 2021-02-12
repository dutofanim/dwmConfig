#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Statusbar
/home/du/slstatus/slstatus &

# Bluetooth
/home/du/dwm-6.2/bluetooth.sh &

# KEYMAP
setxkbmap br &

# NUMLOCK
numlockx &

# COMPOSITOR
picom -f &

# WALLPAPER
nitrogen --restore &

# LOOP
while true; do
	dwm >/dev/null 2>&1
done

# DWM START
exec dbus-launch
exec dwm

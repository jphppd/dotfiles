# Configuration file for startx
xset -b

if [ -f ~/.Xresources ]; then
  xrdb -merge -I~ ~/.Xresources
fi

if [ -x /usr/bin/feh ] && [ -f ~/.local/share/desktop_wallpaper ]; then
  /usr/bin/feh --bg-scale ~/.local/share/desktop_wallpaper
fi

if [ -x /usr/bin/urxvtd ]; then
  /usr/bin/urxvtd -q -f -o
fi

if [ -x /usr/bin/xautolock ] && [ -x /usr/bin/i3lock ]; then
  /usr/bin/xautolock -time 10 -locker "/usr/bin/i3lock --color=00356b --show-failed-attempts" &
fi

if [ -x /usr/bin/xautolock ]; then
  /usr/bin/xautolock -time 30 -locker "systemctl suspend" &
fi

if [ -x /usr/bin/i3 ]; then
  exec /usr/bin/i3
fi

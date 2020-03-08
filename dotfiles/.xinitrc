# Setup all keyboard mappings.
~/ws/mysetup/xkb/apply_xkb.sh ~/ws/mysetup/xkb >/dev/null 2>&1

xrdb ~/.Xresources

export QT_QPA_PLATFORMTHEME="qt5ct"

# TODO: systemctl --user enable redshift.service
# could be nicer but fails to start
# Test adding to redshift.service:
# Environment='XAUTHORITY=/home/MY_USER/.Xauthority' 'DISPLAY=:0'
# OR
# Creating a new dir/file for ~/.config/systemd/user/redshift.service.d/display.conf
redshift >/dev/null &

clipmenud &
devmon --ignore-label lacie_os --no-gui &
# xplugd

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# Run compositor with default settings from /etc/xdg/picom.conf
picom -b

exec i3

# Cleanup on exit
pkill picom
pkill redshift
pkill clipmenud
pkill devmon
# pkill xplugd
pkill autocutsel

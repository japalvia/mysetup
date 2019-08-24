# Setup all keyboard mappings.
~/ws/mysetup/xkb/apply_xkb.sh ~/ws/mysetup/xkb

xrdb ~/.Xresources

export QT_QPA_PLATFORMTHEME="qt5ct"

redshift >/dev/null &
clipmenud &
devmon --ignore-label lacie_os --no-gui &
xplugd

exec i3

# Cleanup on exit
pkill redshift
pkill clipmenud
pkill devmon
pkill xplugd

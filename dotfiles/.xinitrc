setxkbmap -layout fi -option ctrl:nocaps
~/ws/mysetup/xkb/apply_xkb.sh ~/ws/mysetup/xkb

xrdb ~/ws/mysetup/dotfiles/.Xresources

export QT_QPA_PLATFORMTHEME="qt5ct"

redshift >/dev/null &
clipmenud &
devmon --no-gui &

exec i3

# Cleanup on exit
pkill redshift
pkill clipmenud
pkill devmon

setxkbmap -layout fi -option ctrl:nocaps
~/ws/mysetup/xkb/apply_xkb.sh ~/ws/mysetup/xkb

xrdb ~/.Xresources

export QT_QPA_PLATFORMTHEME="qt5ct"

exec i3

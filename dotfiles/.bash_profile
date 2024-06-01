#
# ~/.bash_profile
#

# Initialize here all environment variables
# and source ~/.bashrc at the end.

export PATH=$HOME/bin:$PATH
# pip packages for user
export PATH=$HOME/.local/bin:$PATH
# rust cargo installed sw for user
export PATH=$HOME/.cargo/bin:$PATH

export RANGER_LOAD_DEFAULT_RC=FALSE

export BC_ENV_ARGS=$HOME/.config/bcrc

export EDITOR=nvim

export HISTCONTROL=ignorespace
# Silence dbus errors about accessibility bus
export NO_AT_BRIDGE=1

# GTK dark theme
export GTK_THEME=Adwaita:dark

# Qt5 theme configured by qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

# Applications using non-system Qt
export QT_QPA_PLATFORM="wayland;xcb"

export Qt6_DIR="/usr/lib/qt6"

# Screenshot destination
export GRIM_DEFAULT_DIR=$HOME/temp/grim
[[ -d $GRIM_DEFAULT_DIR ]] || mkdir -p "$GRIM_DEFAULT_DIR"

export RIPGREP_CONFIG_PATH=~/.config/ripgreprc

[[ -r ~/.bashrc ]] && . ~/.bashrc

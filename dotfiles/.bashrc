#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias lt='ls -lt'
alias la='ls -la'
alias grep='grep --color=auto'
alias v='vim'
alias nv='nvim'
alias c='cd'

alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gr='git rebase'
alias gra='git rebase --abort'
alias gri='git rebase -i'
alias gria='git rebase -i --autosquash'
alias gs='git status'
alias gss='git status --short'

alias lastbranch="git for-each-ref --sort=committerdate refs/heads/ \
--format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - \
%(color:red)%(objectname:short)%(color:reset) - \
%(contents:subject) - \
%(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# Disable XON/XOFF flow control
stty -ixon

PS1='[\u@\h:\W]\$ '

# Expect system installed git-prompt, fallback to local bin
git_prompt=$(find -L /usr/share/git $HOME/bin \
             -name git-prompt.sh -print -quit 2>/dev/null)

if source "$git_prompt" 2>/dev/null ; then
    export GIT_PS1_SHOWCOLORHINTS=1
    PROMPT_COMMAND='__git_ps1 "\u@\h:\W" "\\\$ "'
else
    echo "failed to source git-prompt.sh"
fi

if which keychain >/dev/null 2>&1 ; then
    eval $(keychain --eval --quiet id_rsa)
fi

command -v pyenv >/dev/null && eval "$(pyenv init -)"

# fzf for system installed package
test -r /usr/share/fzf/key-bindings.bash && source /usr/share/fzf/key-bindings.bash
test -r /usr/share/fzf/completion.bash && source /usr/share/fzf/completion.bash

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Search dotfiles excluding .git directories
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

export HISTTIMEFORMAT="%F %T  "
log_bash_persistent_history()
{
  local rc=$?
  # Swallow PID into the date string match
  [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "$$" "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

run_on_prompt_command()
{
    log_bash_persistent_history
}

if [ "$PROMPT_COMMAND" = "" ] ; then
    PROMPT_COMMAND="run_on_prompt_command"
else
    PROMPT_COMMAND="run_on_prompt_command; ""$PROMPT_COMMAND"
fi

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

# QT5 theme configured by qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

# Wayland env variables for apps and frameworks
if [[ $XDG_SESSION_TYPE == wayland ]] ; then
    export XDG_SESSION_TYPE=wayland
    export GDK_BACKEND=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

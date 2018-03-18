#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ggrep='git grep'

PS1='[\u@\h:\W]\$ '

if source $(find /usr/share/git -name git-prompt.sh) 2>/dev/null ; then
    export GIT_PS1_SHOWCOLORHINTS=1
    PROMPT_COMMAND='__git_ps1 "\u@\h:\W" "\\\$ "'
else
    echo "failed to source git-prompt.sh"
fi

eval $(keychain --eval --quiet id_rsa)

export HISTCONTROL=ignorespace

export PATH=$HOME/bin:$PATH

export RANGER_LOAD_DEFAULT_RC=FALSE

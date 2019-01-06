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
alias ggrep='git grep'

PS1='[\u@\h:\W]\$ '

# Expect system installed git-prompt, fallback to local bin
git_prompt=$(find /usr/share/git $HOME/bin \
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

export HISTCONTROL=ignorespace

export PATH=$HOME/bin:$PATH

export RANGER_LOAD_DEFAULT_RC=FALSE

export BC_ENV_ARGS=$HOME/.config/bcrc

export EDITOR=vim

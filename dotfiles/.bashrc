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

alias ga='git add'
alias gap='git add -p'
alias gc='git commit'
alias gcf='git commit --fixup'
alias gco='git checkout'
alias gd='git diff'
alias gg='git grep'
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

# fzf for system installed package
test -r /usr/share/fzf/key-bindings.bash && source /usr/share/fzf/key-bindings.bash
test -r /usr/share/fzf/completion.bash && source /usr/share/fzf/completion.bash

shopt -s histappend
shopt -s cmdhist

export PATH=$HOME/bin:$PATH

export RANGER_LOAD_DEFAULT_RC=FALSE

export BC_ENV_ARGS=$HOME/.config/bcrc

export EDITOR=vim

export HISTCONTROL=ignorespace


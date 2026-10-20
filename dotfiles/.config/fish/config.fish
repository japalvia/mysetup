set -gx EDITOR nvim
set -gx VISUAL nvim

set -g fish_greeting

if status is-interactive
    fish_config theme choose --color-theme=dark gruvbox-material-medium-dark

    abbr -a -- ls 'ls --color=auto'
    abbr -a -- ll 'ls -l'
    abbr -a -- lt 'ls -lt'
    abbr -a -- la 'ls -la'
    abbr -a -- lh 'ls -lh'
    abbr -a -- grep 'grep --color=auto'
    abbr -a -- nv nvim
    abbr -a -- nvf 'nvim (fzf)'
    abbr -a -- c cd
    abbr -a -- gg 'git grep'
    abbr -a -- ga 'git add'
    abbr -a -- gap 'git add -p'
    abbr -a -- gc 'git commit'
    abbr -a -- gca 'git commit --amend'
    abbr -a -- gcf 'git commit --fixup'
    abbr -a -- gco 'git checkout'
    abbr -a -- gd 'git diff'
    abbr -a -- gds 'git diff --staged'
    abbr -a -- gl 'git log'
    abbr -a -- glo 'git log --oneline'
    abbr -a -- gr 'git rebase'
    abbr -a -- gra 'git rebase --abort'
    abbr -a -- gri 'git rebase -i'
    abbr -a -- gria 'git rebase -i --autosquash'
    abbr -a -- gs 'git status'
    abbr -a -- gss 'git status --short'
    abbr -a -- gru 'git remote update origin'
    abbr -a -- si swayimg

    if command -q fdfind
        abbr -a -- fd fdfind
    end
end

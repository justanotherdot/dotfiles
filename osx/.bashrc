[[ $- != *i* ]] && return

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export GOPATH=$HOME/code/go/
export PATH=$PATH:$GOPATH/bin

export HISTFILESIZE=10000
export HISTSIZE=10000
export PROMPT_COMMAND='history -a'

shopt -s histappend
shopt -s extglob
set -o emacs

alias ls="ls -F"
alias df='df -h'
alias tty-clock='tty-clock -b -C 7 -c'

function cd() {
    if [[ -z $1 ]]; then
        builtin cd "$HOME" && ls
    else
        builtin cd "$1" && ls
    fi
}

. `brew --prefix`/etc/bash_completion
GIT_PS1_SHOWDIRTYSTATE=true
export PS1="[\d, \@ | \w$(__git_ps1) ]\nλ "

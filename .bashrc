#
# ~/.bashrc
#
# Ryan James Spencer

# Only import gruvbox colors if emacs not running.
EP=$(pgrep "emacs")
if [ -z "$EP" ]; then
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
fi

if [[ -e "/usr/bin/lxqt-openssh-askpass" && -z $SSH_ASKPASS ]]; then
    SSH_ASKPASS="/usr/bin/lxqt-openssh-askpass"
fi

#Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Let some applications know we're using XFCE
export DE="XFCE"

# Avoid infinite loop issues with interactive mode
[[ $- != *i* ]] && return

# If in screen or tmux, adjust for 256 palette
if [[ $TERM == 'screen' ]]
then
    export TERM='screen-256color'
else
    export TERM='xterm-256color'
fi

export EDITOR='vim'
export PAGER='less'
export PATH=$HOME/.rvm/bin:$HOME/go/bin:$HOME/.gem/ruby/2.2.0/bin:$HOME/.cabal/bin:$HOME/bin:$PATH
export GOPATH=$HOME/go
# Recommended not to go beyong 10k
export HISTFILESIZE=10000
export HISTSIZE=10000
# Allow more than a single instance of a shell to write to `history`
export PROMPT_COMMAND='history -a'

# Append to old history when we open new terminals
shopt -s histappend
# Turn on negative globs
shopt -s extglob
# Set vi keybidnings (in addition to .inputrc)
set -o vi

#Setup our prompt
if [[ -n `echo $LANG | egrep -i "utf-?8" ` ]]; then
    #PS1="[\d, \@ | \w ]\n↪ "
    PS1="[\d, \@ | \w ]\nλ "
else
    PS1="[\d, \@ | \w ]\n&  "
fi

# Common aliases
alias ls="ls --color=always -F"
alias grep="grep --color=always"
alias df='df -h'
alias tty-clock='tty-clock -b -C 7 -c'
alias emacs='emacs -nw'
alias clisp='clisp -q'

# More complex aliases
function cd() {
    if [[ -z $1 ]]; then
        builtin cd "$HOME" && ls
    else
        builtin cd "$1" && ls
    fi
}

# Arch Linux specific
update-system() {
    sudo pacman -Syyu
    yaourt -Syyu --aur
    yaourt -Syyua --devel # Update all version control packages
}

orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}

# Properly pull from the dotfiles repo and its nested submodules
update-env() {
    builtin cd "$HOME"
    # install pathogen
    if [[ ! -f ~/.vim/autoload/pathogen.vim ]]; then 
        mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
    # Check for cabal programs
    cabal-check
    # Setup `git pullall` as an alias for our update
    git config alias.pullall '!git pull && git submodule update --init --recursive'
    git pullall
    vim +PluginInstall +qall
}

cabal-check() {
    if command -v cabal >/dev/null 2>&1; then
        CABAL_PRGMS_WNT=(hlint hdevtools hasktags pointfree hoogle gtk2hs-buildtools ThreadScope)
        CABAL_PRGMS_GET=()

        for cabal_prg in "${CABAL_PRGMS_WNT[@]}"; do
            if ! command -v "$cabal_prg" >/dev/null 2>&1; then
                CABAL_PRGMS_GET+=("$cabal_prg")
            fi
        done

        if [ "${#CABAL_PRGMS_GET[@]}" -ne 0 ]; then
            cabal update
            for cabal_get in "${CABAL_PRGMS_GET[@]}"; do
                cabal install "$cabal_get"
            done
        fi
    fi
}

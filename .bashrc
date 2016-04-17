#
# ~/.bashrc
#
# Ryan James Spencer

# Only source color schemes when emacs isn't running
if [[ -z `pgrep emacs` ]]; then
    # Base16 Shell
    BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
    [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
fi

DE=generic

# Common aliases
alias ls="ls -F"
alias df='df -h'
alias tty-clock='tty-clock -b -C 7 -c'
alias clisp='clisp -q'
alias swipl='swipl --traditional' # Prevent lists being treated as dicts
alias open='xdg-open'

# Start keychain wrapper for ssh-agent
#eval $(keychain --eval id_rsa --quiet)
eval $(keychain --eval --quiet)

# Avoid infinite loop issues with interactive mode
[[ $- != *i* ]] && return

unset LS_COLORS

# If in screen or tmux, adjust for 256 palette
if [[ $TERM == 'screen' ]]; then
    export TERM='screen-256color'
fi

export EDITOR='emacs'
export PAGER='less'
export PATH=$HOME/.rvm/bin:$HOME/go/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/.cabal/bin:$HOME/bin:$PATH
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
# Set editing mode to emacs
set -o emacs

#Setup our prompt
if [[ -n `echo $LANG | egrep -i "utf-?8"` ]]; then
    PS1="[\d, \@ | \w ]\nλ "
else
    PS1="[\d, \@ | \w ]\n&  "
fi

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

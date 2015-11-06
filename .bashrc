# .bashrc, Ryan James Spencer; spacecadet!

# temporary:
export NEO4J_AUTH="neo4j:ubT~@9~@<F"
export DE="XFCE"

# Only load special characters if we're not already running emacs
# as this goofs up output.
ER=$(pgrep "emacs")
if [ -z "$ER" ]
then
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
fi

export TERM='xterm-256color'
export EDITOR='vim'
export PAGER='less'
#Stop git and ssh from using GTK dialogue boxes.
unset SSH_ASKPASS 
export PATH="$HOME/.rvm/bin:$HOME/.gem/ruby/2.2.0/bin:$HOME/.cabal/bin:$PATH"

#Vi mode
set -o vi

#extglob on, compatibility be damned!
shopt -s extglob

#Setup our prompt
PS1="[\d, \@ | \w]\n↪ "

#Aliases
alias ls='ls --color=always -F'
alias grep='grep --color=always'
alias gcc='colorgcc'
alias df='df -h'
alias tty-clock='tty-clock -b -C 7 -c'
alias emacs='emacs -nw'

# Functions
orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No oprhans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}

update-system() {
    sudo pacman -Syyu 
    yaourt -Syu --aur
}

function cd {
    builtin cd "$@" && ls
}


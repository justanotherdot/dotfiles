# file: .zshrc
# author: Ryan James Spencer

autoload -Uz promptinit && promptinit
export PROMPT="%~"$'\n'"%Bη %b"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.npm-global/node/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.mafia/versions"
export PATH="$PATH:$HOME/.cache/rebar3/bin"
export PATH="$PATH:$HOME/.mix/escripts"
export PATH="$PATH:$HOME/haskell/ghc-current/bin"

export GOPATH="$HOME/go"
export SSH_ASKPASS=''
export ERL_AFLAGS="-kernel shell_history enabled"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GPG_TTY=$(tty)

eval $(keychain --eval -Q --quiet id_ed25519)

setopt histignorealldups sharehistory extendedhistory BRACE_CCL
setopt extendedglob globdots interactivecomments

unsetopt nomatch

set -o vi
set bell-style none

export TERM=xterm-256color
export EDITOR='nvim'
export PAGER='less'

# Aliases
alias v='nvim'
alias vzv="nvim -c':Files'"
alias df='df -h'
alias ls='ls -F'
alias grep='grep --color=auto'
alias rgc='rg --hidden -l "<{7}"'
alias rgl='rg -l'
alias k='kubectl'

# Aliases for subshells
today() { date +%Y-%m-%d; }
vdiff() {
  results=$(rgc)
  if [ -z "$results" ]; then
    echo "No files found with marked conflicts"
  else
    v -p $(rgc);
  fi
}
vrg() { v -p $(rgl "$1"); }

export today
export vdiff
export vrg

# External aliases
[ -e "$HOME/.aliases" ] && source "$HOME/.aliases"

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Speed up git autocompletion
__git_files () {
    _wanted files expl 'local files' _files
}

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
[ $(uname) = "Linux" ] && eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .zshrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -w __init_nvm | awk '{print $2}')" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# Ditto for kubectl
if [ /usr/local/bin/kubectl ] && [ ! "$(type -w __init_kubectl | awk '{print $2}')" = function ]; then
  declare -a __kubectl_commands=('kubectl')
  function __init_kubectl() {
    for i in "${__kubectl_commands[@]}"; do unalias $i; done
    source <(kubectl completion zsh)
    unset __kubectl_commands
    unset -f __init_kubectl
  }
  for i in "${__kubectl_commands[@]}"; do alias $i='__init_kubectl && '$i; done
fi

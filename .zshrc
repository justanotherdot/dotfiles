# file: .zshrc
# author: Ryan James Spencer

autoload -Uz promptinit && promptinit
export PROMPT="%~"$'\n'"%Bη %b"

if [ -e "$HOME/.paths" ]; then
  source "$HOME/.paths"
fi

export SSH_ASKPASS=''

if [[ "`which keychain`" != "keychain not found" ]]; then
  # Prefer twisted curve key over RSA.
  # Unless we've set the environment to be work.
  if [ -e "$HOME/.ssh/id_ed25519" ]; then
    eval "$(keychain --eval -Q --quiet id_ed25519)"
  else
    eval "$(keychain --eval -Q --quiet id_rsa)"
  fi
fi

setopt histignorealldups sharehistory extendedhistory BRACE_CCL
setopt extendedglob globdots interactivecomments

unsetopt nomatch

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
set -o vi

export TERM=xterm-256color
export EDITOR='nvim'
export PAGER='less'

alias v='nvim'
alias vzv="nvim -c':Files'"
alias df='df -h'
alias ls='ls -F'
alias grep='grep --color=auto'
alias tmux='tmux -2'

if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

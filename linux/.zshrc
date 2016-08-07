# ~/.zshrc
# Ryan James Spencer

# Set up the prompt
autoload -Uz promptinit && promptinit
source "$HOME/tmp/zsh-git-prompt/zshrc.sh"
export PROMPT="[%D{%a %b %f}, %@ | %~ $(git_super_status)]"$'\n'"%Bλ%b "
# prompt adam1

# Colorscheme
BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

setopt histignorealldups sharehistory extendedhistory
setopt extendedglob autocd correctall globdots interactivecomments

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Source profile for environment exports.
source '.profile'
eval "$(rbenv init -)"

export TERM='xterm-256color'
# If in screen or tmux, adjust for 256 palette
if [[ $TERM == 'screen' ]]; then
    export TERM='screen-256color'
fi

export EDITOR='nvim'
export PAGER='less'


alias df='df -h'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
alias grep='egrep --color=auto'

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
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

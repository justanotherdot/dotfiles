# ~/.zshrc
# Ryan James Spencer

# Set up the prompt
autoload -Uz promptinit && promptinit
source "$HOME/bin/zsh-git-prompt/zshrc.sh"
#export GIT_PROMPT_EXECUTABLE="haskell"
export PROMPT="[%D{%a %b %f}, %@ | %~ $(git_super_status)]"$'\n'"♤ "

setopt histignorealldups sharehistory extendedhistory
setopt extendedglob autocd globdots interactivecomments

export PATH=$PATH:/Users/Allen/bin
export PATH=$PATH:/Users/Allen/.local/bin

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
export KEYTIMEOUT=1

# Source profile for environment exports.
eval "$(rbenv init -)"

export TERM='xterm-256color'
# If in screen or tmux, adjust for 256 palette
if [[ $TERM == 'screen' ]]; then
    export TERM='screen-256color'
fi

export EDITOR='nvim'
export PAGER='less'
alias df='df -h'

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Extra exports

# added by Anaconda3 4.1.1 installer
export PATH="/Users/Allen/anaconda/bin:$PATH"

# added by Anaconda3 4.2.0 installer
export PATH="/Users/Allen/anaconda3/bin:$PATH"

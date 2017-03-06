#
# ~/.bashrc
#
# Ryan James Spencer

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls    = 'ls -F --color = auto'
    alias grep  = 'grep --color  = auto'
    alias egrep = 'egrep --color = auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export TERM='xterm-256color'
if [[ $TERM == 'screen' ]]; then
    export TERM='screen-256color'
fi

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export HISTFILESIZE=10000 # Recommended not to go beyond 10k
export HISTSIZE=10000
export PROMPT_COMMAND='history -a' # Allow more than a single instance of a shell to write to `history`
shopt -s histappend
shopt -s extglob

set -o vi

# Prompt
if [[ -n `echo $LANG | egrep -i "utf-?8"` ]]; then
    PS1="[\d, \@ | \w ]\nλ "
else
    PS1="[\d, \@ | \w ]\n&  "
fi

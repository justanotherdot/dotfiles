#
# ~/.bash_profile
# Ryan James Spencer
#

[[ -f ~/.bashrc ]] && source ~/.bashrc

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

. /home/rjs/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Start X11 automatically after login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx 

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
if [ -f ~/.aliases ]; then
. ~/.aliases
fi
if [ -f ~/.functions ]; then
. ~/.functions
fi
set -o ignoreeof  # only "exit" or "logout" will log me off the system.
set -o vi
#shopt -s huponexit
umask 027       # Create files with group, other permissions turned off.
export EDITOR=vim
export FPATH=~/.functions
export HISTFILE=${HISTFILE}.${HOSTNAME}
export HOSTNAME=`hostname`
export PS1='${LOGNAME}@${HOSTNAME}:${PWD}$'
export EDITOR=vim
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
export PAGER=less
export ENV=$HOME/.bashrc
export HISTSIZE=1000
export HISTFILESIZE=1000
export LESS='-fXemPm?f%f .?lbLine %lb?L of %L..:$' # Set options for less command
export TERM=xterm  # PuTTY emulates this.
export TMPDIR=~/tmp
alias dsiz='du -sk * | sort -n --'
alias bash='clear;/bin/bash -l'
alias ls='ls -lart'
echo .profile done

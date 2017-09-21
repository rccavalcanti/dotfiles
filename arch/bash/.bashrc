#
# ~/.bashrc
#
# Autor: Rafael Cavalcanti


# If not running interactively, don't do anything (veio do Arch)
[[ $- != *i* ]] && return

#powerline="/usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh"
#if [ -f $powerline ]; then
#	# Powerline
#	powerline-daemon -q
#	POWERLINE_BASH_CONTINUATION=1
#	POWERLINE_BASH_SELECT=1
#	. $powerline
#else
	# Meu PS1 (estilo Cygwin + Git + RVM)
	RESET="\e[0m"; GREEN="\e[32m"; YELLOW="\e[33m"; GREY="\e[90m"
	title="\e]2;\w\a"
	. /usr/share/git/completion/git-prompt.sh
	GIT_PS1_SHOWDIRTYSTATE=1
	PS1="${title}\n${GREEN}\u: ${YELLOW}\w${GREY} (\j)\$(__git_ps1) \$(~/.rvm/bin/rvm-prompt p g)${RESET} \n\$ "
#fi

# History completion with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length
# [RC modified] HISTSIZE=1000->2000, HISTFILESIZE: 2000->3000
HISTSIZE=2000
HISTFILESIZE=3000

# Time stamps in history
HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Command not found - pkgfile (Arch Wiki)
. /usr/share/doc/pkgfile/command-not-found.bash

# [RVM installation script] Add RVM to PATH for scripting. Make sure
# this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# RVM (Arch Wiki)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

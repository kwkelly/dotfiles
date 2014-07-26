# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
##### Machine conditional

if [[ "$HOSTNAME" = *ices* ]] || [[ "$HOSTNAME" = *compute* ]]; then 
	# ~/.bashrc

	# used for bash non-login shells.
	# non-login shells include:
	# * X sessions (xdm, gdm, kdm)
	# * X Terminals (xterm, konsole, gnome-terminal)
	# * running remote commands via ssh

	# NOTE: some programs (ie, winscp) fail if this generates any output.

	# first, source the system bashrc
	if [ -r /etc/bashrc ]; then
	    . /etc/bashrc
	fi

	# MAIL is used by mutt
	export MAIL=/mail/${USER}/Maildir/

	# default printer: change this to suit your needs.
	# pr3swd is the duplex queue on our black and white laser printer in the
	# southwest quadrant of the 3rd floor of ICES.
	export PRINTER=cp3se

	# default editor: this is used by svn, etc.
	# the only safe default for EDITOR is one which instructs the user how to quit.
	# most users will change this to vim or emacs.
	export EDITOR=vim

	# uncomment this to use a prompt which indicates exit status
	#if [ -r /etc/bash/prompt ]; then
	#    . /etc/bash/prompt
	#fi

	# pine aliases
	alias alpine='alpine -passfile ~/.pinepass'
	alias pine='alpine -passfile ~/.pinepass'


	# Add local dir to install location. Probably not the best way to do this,
	# but it's not easy without priveleges.
	PATH=$PATH:~/.local/bin:/workspace/local/bin
	LIBRARY_PATH=$PATH:~/.local/lib:/workspace/local/lib
	LD_LIBRARY_PATH=~$LD_LIBRARY_PATH:~/.local/lib:/workspace/local/lib:/org/groups/padas/packages/petsc-3.4.3-icc-complex/lib
	PYTHONPATH=$PYTHONPATH:/workspace/local/lib/python2.6/site-packages

	export LD_LIBRARY_PATH
	export PATH
	export LIBRARY_PATH
	export PYTHONPATH

	module load intel/12.1
	module load git

	unset SSH_ASKPASS
fi

# just for ronaldo, may have to add more later
if [[ $HOSTNAME = *ronaldo* ]]; then
	module load mkl/12.1
	module load openmpi/1.4.4
	export PETSC_DIR=/org/groups/padas/packages/petsc-3.4.3-icc-complex
fi


if [[ $HOSTNAME = *curie* ]]; then
	module load sl6 
	module load mkl
	module load autotools
	module load openmpi
	module load paraview
fi

if [[ $HOSTNAME = *compute* ]]; then
	module load mkl
	module load openmpi
fi


##### End machine conditional stuff

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# prompt
# The escape sequence \e[0;31m for instance, gets sucked up by the terminal, 
# which in turn turns the following text red, but bash doesn't know that. So,
# you have to tell bash that that sequence of characters should not
# be counted in the prompt's length, and you do that by enclosing it in \[ \].
# I also recommend using tput instead of hardcoding terminal escape sequences.
PS1='\[\e[0;33m\]\u@\h\[\e[m\] \[\e[0;34m\]\w \$\[\e[m\] '

# create ranger-cd and bind it to C-o if ranger is installed
if hash ranger 2>/dev/null; then
	function ranger-cd {
		tempfile='/tmp/chosendir'
		ranger --choosedir="$tempfile" "${@:-$(pwd)}"
		test -f "$tempfile" &&
		if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
			cd -- "$(cat "$tempfile")"
		fi
		rm -f -- "$tempfile"
	}

	# This binds Ctrl-O to ranger-cd:
	bind '"\C-o":"ranger-cd\C-m"'
else
	echo "Can not find ranger"
fi


# Start tmux if it is not only running. Start only one instance. Reattach if possible
if hash tmux 2>/dev/null; then
	if [[ $- == *i* ]] # check if interactive shell, if not, don't open tmux
	then
		if ! [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" || -n "$SSH_CONNECTION" ]]  # Don't open TMUX if connecting via ssh... needs fixin
		then
			if which tmux 2>&1 >/dev/null
			then
				#if not inside a tmux session, and if no session is started, start a new session
				test -z "$TMUX" && (tmux new-session || tmux attach)
			fi
		fi
	fi
else
	echo "Can not find tmux"
fi
	
# Some aliases for some common things
if ! ls --group-directories-first 1>/dev/null 2>&1; then
	alias grep='grep --color=tty -d skip'
	alias cp="cp -i"                          # confirm before overwriting something
	alias df='df -h'                          # human-readable sizes
	alias free='free -m'                      # show sizes in MB
else
	alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
	alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
	alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
	alias grep='grep --color=tty -d skip'
	alias cp="cp -i"                          # confirm before overwriting something
	alias df='df -h'                          # human-readable sizes
	alias free='free -m'                      # show sizes in MB
fi


# Start on conditional stuff


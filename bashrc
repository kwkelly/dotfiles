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

function title {
	echo -ne "\033]0;"$*"\007"
}

# allow forward stepping through history
stty -ixon



##### Machine conditional


if [[ $HOSTNAME = *helmholtz* ]]; then
  # os x likes to make ctrl-o not do anything for some reason...
  stty discard undef
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"

	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi
	alias brewup='brew update && brew upgrade --all'

	# use vimpager
	export PAGER=less
	alias less=$PAGER
	alias zless=$PAGER

	# add colored output to gcc
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

	# add matlab bin to path
	export PATH=$PATH:/Applications/MATLAB_R2014a.app/bin:/Library/TeX/texbin
	# add sbin to path, homebrew suggested I do this
	export PATH=/usr/local/sbin:$PATH
	export PATH=$PATH:~/.bin

	# vlc to path
	alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
	alias cvlc='vlc -I rc'
	# brew caveat for gdk-pixbuf
	export GDK_PIXBUF_MODULEDIR="/usr/local/lib/gdk-pixbuf-2.0/2.10.0/loaders"

	envfile="$HOME/.gnupg/gpg-agent.env"
	if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
		eval "$(cat "$envfile")"
	else
		eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
	fi
	export GPG_AGENT_INFO  # the env file does not contain the export statement
	export SSH_AUTH_SOCK   # enable gpg-agent for ssh

	# virtualenvwrapper stuff
	export WORKON_HOME=$HOME/.virtualenvs
	source $(which virtualenvwrapper.sh)
fi


if [[ $HOSTNAME = *pasteur* ]]; then
  # os x likes to make ctrl-o not do anything for some reason...
  stty discard undef
	export HOMEBREW_CASK_OPTS="--appdir=/Applications"

	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi
	alias brewup='brew update && brew upgrade'

	# use vimpager
	export PAGER=less
	alias less=$PAGER
	alias zless=$PAGER

	# add colored output to gcc
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

	# add matlab bin to path
	export PATH=$PATH:/Library/TeX/texbin

	# brew caveat for gdk-pixbuf
	export GDK_PIXBUF_MODULEDIR="/usr/local/lib/gdk-pixbuf-2.0/2.10.0/loaders"

	envfile="$HOME/.gnupg/gpg-agent.env"
	if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
		eval "$(cat "$envfile")"
	else
		eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
	fi
	export GPG_AGENT_INFO  # the env file does not contain the export statement
	export SSH_AUTH_SOCK   # enable gpg-agent for ssh

	# virtualenvwrapper stuff
	export WORKON_HOME=$HOME/.virtualenvs
	source $(which virtualenvwrapper.sh)

	export HOMEBREW_GITHUB_API_TOKEN="77fc915d13d8d9a4199c248dc565a1b222c2e4bb"

	[[ $- = *i* ]] && bind TAB:menu-complete
fi


##### End machine conditional stuff

# ex - archive extractor
# usage: ex <file>
# not useful because of dtrx
ex ()
{
  if [[ -f $1 ]] ; then
		echo $1
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x "$1" ;;
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
#	echo "Can not find ranger"
  :
fi

# Some aliases for some common things
if ! ls --group-directories-first 1>/dev/null 2>&1; then
  alias grep='grep --color=tty -d skip'
  alias cp="cp -i"                          # confirm before overwriting something
  alias df='df -h'                          # human-readable sizes
  alias free='free -m'                      # show sizes in MB
  alias ls='ls -GFh'
else
  alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
  alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
  alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
  alias grep='grep --color=tty -d skip'
  alias cp="cp -i"                          # confirm before overwriting something
  alias df='df -h'                          # human-readable sizes
  alias free='free -m'                      # show sizes in MB
fi

# re-source the bashrc
alias resource="source ~/.bashrc"

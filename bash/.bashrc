
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
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

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

#aliaseses
alias ipa="ip a"
alias helios="ssh arbertra@helios.ugent.be"
alias firefox='firefox-developer-edition'
alias qute='qutebrowser'
alias bashrc='vim ~/.bashrc'
alias i3conf='vim ~/.config/i3/config'
alias rpi="ssh pi@84.197.114.11"
alias growmake="ssh root@growth.m4kers.com"
alias robpi="ssh pi@81.82.58.186"
alias xreload="xrdb ~/.Xresources"
alias vim="nvim"
alias inivim="vim ~/.config/nvim/init.vim"
alias srcrc="source ~/.bashrc"
alias spaceini="vim ~/.SpaceVim.d/init.toml"
alias spvim="vim -u ~/.config/svim/init.vim"
alias lsizes="sudo du -hsx .[!.]* * | sort -rh"
alias why="echo 'because'"
alias csp="cd ~/repos/sysprog/project"
alias mongserv='mongod --dbpath ~/data/db --bind_ip 127.0.0.1'
alias pbconf="vim ~/.config/polybar/config"
alias mman="sudo mount /dev/sdb2 ~/manjaro"
alias wifix="sudo systemctl restart wpa_supplicant@wlp4s0"
alias wifixx="sudo systemctl stop wpa_supplicant@wlp4s0; sleep 1; sudo systemctl restart dhcpcd@wlp4s0; sleep 1; sudo systemctl start wpa_supplicant@wlp4s0"

alias wpaconf="sudoedit /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf"
alias wttr="curl wttr.in"
alias cbld="cmake --build . -j 8"
alias maptui="telnet mapscii.me"
alias makaur="makepkg -scCi"
alias pgrep="pgrep -l"
# git aliases
alias gits="git status"
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset
    %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
# sysprog
alias go="make puzzle_bots_part1; ./puzzle_bots_part1"
alias svim="sudoedit"
alias zpass='PASSWORD_STORE_DIR=~/.zeus-wachtwoord-winkel pass'
alias emconf="vim ~/.emacs.d/init.el"
alias cavm="VBoxSDL --startvm Kubuntu\ CA"

ncmpcpp() {
    if ! pidof "$(type -P mpd)" >/dev/null; then
        mpd
        if type -P mpdscribble >/dev/null; then
            killall mpdscribble >&/dev/null
            mpdscribble
        fi
        $(type -P ncmpcpp) "$@"
    else
        $(type -P ncmpcpp) "$@"
    fi
}
lsvenv(){
    ls $VENV_HOME
}
mkvenv(){
    while getopts "a" opt; do
        case "$opt" in
            a)
                active=1
                ;;
        esac
    done
    shift $((OPTIND-1))
    python3 -m venv $VENV_HOME/$1

    if [ active ]
    then
        avenv $1
    fi
}
avenv(){
    source $VENV_HOME/$1/bin/activate
}
rmvenv(){
    rm -rf $VENV_HOME/$1
}
_venvcomplete(){
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "$(ls $VENV_HOME)" -- $curr_arg ) );
}
complete -F _venvcomplete avenv
complete -F _venvcomplete rmvenv

hoekstream(){
    pax11publish -e -S hoek
    killall cantata
    mpd --kill
    mpd
}
stophoek(){
    pax11publish -e -S ""
    killall cantata
    mpd --kill
    mpd
}
paclist(){
    pacman -Qs $1 | grep local\/ | cut -d " " -f 1 | cut -d "/" -f 2
}
function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}
function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
   done
}
function dectohex(){
    echo "obase=16;$1" | bc
}
function dectobin(){
    pad=0
    if [ $2 ]
    then
        pad=$2
    fi
    rslt=`echo "obase=2;$1" | bc`
    printf "%0${pad}d" $rslt
}
function bintodec(){
    echo "ibase=2;obase=A;$1" | bc
}
function bintohex(){
    echo "ibase=2;obase=F;$1" | bc
}
function hextodec(){
    echo "ibase=16;obase=A;$1" | bc
}
function hextobin(){
    pad=0
    if [ $2 ]
    then
        pad=$2
    fi
    rslt=`echo "ibase=16;obase=2;$1" | bc`
    printf "%0${pad}d" $rslt
}

#rbenv
eval "$(rbenv init -)"
#luarocks
eval $(luarocks path --bin)
#customizations - environment variables
export MAKEFLAGS="-j$(nproc)"
export EDITOR='nvim'
export VISUAL='nvim'
export JAVA_COMPILER='java'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi
# Path to the bash it configuration
export BASH_IT="/home/arne/repos/installations/bash-it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='powerline-multiline'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true


# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load autojump
source /etc/profile.d/autojump.bash

# Load completion
source /usr/share/bash-completion/bash_completion

# Load Bash It
source "$BASH_IT"/bash_it.sh
echo "locate is een ding"

PATH=$PATH:/home/arne/.cargo/bin/
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/arne/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source /usr/share/zsh/share/antigen.zsh
antigen use oh-my-zsh

antigen bundle autojump
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle httpie
antigen bundle python
antigen bundle vi-mode
antigen bundle cargo
antigen bundle yarn
antigen bundle rust
antigen bundle ael-code/zsh-colored-man-pages
antigen bundle laurenkt/zsh-vimto
antigen bundle wfxr/forgit
# antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure

antigen theme denysdovhan/spaceship-prompt

antigen apply
# aliases
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

alias zrc="emc ~/.zshrc"
alias ipa="ip a"
alias helios="ssh arbertra@helios.ugent.be"
alias firefox='firefox-developer-edition'
alias qute='qutebrowser'
alias bashrc='vim ~/.bashrc'
alias i3conf='emc ~/.config/i3/config'
alias rpi="ssh pi@84.197.114.11"
alias growmake="ssh root@growth.m4kers.com"
alias robpi="ssh pi@81.82.58.186"
alias xreload="xrdb ~/.Xresources"
alias vim="nvim"
alias inivim="vim ~/.config/nvim/init.vim"
alias srcrc="source ~/.zshrc"
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
alias gc="git checkout"
# sysprog
alias go="make puzzle_bots_part1; ./puzzle_bots_part1"
alias svim="sudoedit"
alias zpass='PASSWORD_STORE_DIR=~/.zeus-wachtwoord-winkel pass'
alias emconf="emc ~/.emacs.d/init.el"
alias cavm="VBoxSDL --startvm Kubuntu\ CA"
alias fehlias="feh --force-aliasing"

# functions
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
# environment vars

export MAKEFLAGS="-j$(nproc)"
export EDITOR='nvim'
export VISUAL='nvim'
export JAVA_COMPILER='java'

# nvm

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# rbenv
eval "$(rbenv init -)"
# luarocks
eval $(luarocks path --bin)
#reminders
echo "bat is een ding"
echo "http is een ding"
echo "fzf is een ding"

# vi-mode fixes
# setopt PROMPT_SUBST

# vim_ins_mode="[INS]"
# vim_cmd_mode="[CMD]"
# vim_mode=$vim_ins_mode
# echo -en "\x1b[6 q"

# function zle-keymap-select {
#   vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
#   case $vim_mode in
#       "[INS]")
#           echo -en "\x1b[6 q"
#           ;;
#       "[CMD]")
#           echo -en "\x1b[2 q"
#           ;;
#       *)
#   esac
#   zle reset-prompt
# }
# zle -N zle-keymap-select

# function zle-line-finish {
#     echo -en "\x1b[6 q"
#   vim_mode=$vim_ins_mode
# }
# zle -N zle-line-finish

PATH=$PATH:/home/arne/.cargo/bin/:/home/arne/.gem/ruby/2.6.0/bin:/home/arne/bin:/home/arne/repos/redpencil/docker-ember/bin:/home/arne/scripts
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export TOGGL_KEY=c0cdb681b26eaaa0ea656387ba30a901
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
kitty + complete setup zsh | source /dev/stdin
eval $(starship init zsh)
eval "$(zoxide init --cmd j zsh)"
# End of lines added by compinstall
source /usr/share/zsh/share/antigen.zsh
antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle httpie
antigen bundle python
antigen bundle vi-mode
antigen bundle cargo
antigen bundle yarn
antigen bundle rust
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle ael-code/zsh-colored-man-pages
antigen bundle laurenkt/zsh-vimto
antigen bundle wfxr/forgit


antigen apply

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# functions
hide_on_open(){
    tdrop -ma --wm bspwm auto_hide
    "$@" && tdrop -ma --wm bspwm auto_show
}
# aliases
# alias ls='ls --color=auto'
alias startsim='gcc -fsanitize=address sprites.c  main.c events.c math.c motion.c wall.c parsing.c -D BUFFER_SIZE=32 ./GNL/get_next_line_bonus.c ./GNL/get_next_line_utils_bonus.c -L /home/arne/repos/simon_game/19/cube3D/minilibx'
alias ls='lsd'
alias lt='lsd --tree'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias scim="sc-im"

alias zrc="emc ~/.zshrc"
alias ipa="ip -c=auto a"
alias ip4="ip -c=auto -br -4 a"
alias ip6="ip -c=auto -br -6 a"
alias helios="ssh arbertra@helios.ugent.be"
alias firefox='firefox-developer-edition'
alias qute='qutebrowser'
alias bashrc='emc ~/.bashrc'
alias i3conf='emc ~/.config/i3/config'
alias rpi="ssh pi@84.197.114.11"
alias xreload="xrdb ~/.Xresources"
alias vim="emc -t"
alias inivim="vim ~/.config/nvim/init.vim"
alias srcrc="source ~/.zshrc"
alias lsizes="sudo du -hsx .[!.]* * | sort -rh"
alias why="echo 'because'"
alias pbconf="emc ~/.config/polybar/config"
alias mman="sudo mount /dev/sdb2 ~/manjaro"
alias wifix="sudo systemctl restart wpa_supplicant@wlp4s0"
alias wifixx="sudo systemctl stop wpa_supplicant@wlp4s0; sleep 1; sudo systemctl restart dhcpcd@wlp4s0; sleep 1; sudo systemctl start wpa_supplicant@wlp4s0"

alias wpaconf="sudoedit /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf"
alias wttr="curl wttr.in"
alias cbld="cmake --build . -j 8"
alias makaur="makepkg -scCi"
alias pgrep="pgrep -l"
# git aliases
alias gits="git status"
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset
    %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias gc="git checkout"
# sysprog
alias svim="sudoedit"
alias zpass='PASSWORD_STORE_DIR=~/.zeus-wachtwoord-winkel pass'
alias fehlias="feh --force-aliasing"
alias extip="curl ifconfig.co"
alias kelspot="vncviewer 10.0.0.5:5901"
alias icat="kitty +kitten icat"
alias updateall="yay -Syu --devel && antigen update && cd /home/arne/.emacs.d && git pull && emacs && cd ~"
alias tpl="swipl -f none -t halt -g run_tests -q tests/*.pl"
alias rpl="swipl -f none -t halt -g main -q src/main.pl"
alias rgi="sk --ansi -i -c 'rg --color=always --line-number \"{}\"'"
alias hist='eval "$(history | sk --tac | cut -f4- -d" ")"'


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
# environment vars

export MAKEFLAGS="-j$(nproc)"
export EDITOR='nvim'
export VISUAL='nvim'
export JAVA_COMPILER='java'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50


# nvm

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# rbenv
# eval "$(rbenv init -)"
# luarocks
# eval $(luarocks path --bin)

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

function zle-line-init() {
    echoti rmkx
    echo -ne '\e[5 q'
}
zle -N zle-line-init

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
           [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'

    elif [[ ${KEYMAP} == main ]] ||
             [[ ${KEYMAP} == viins ]] ||
             [[ ${KEYMAP} = '' ]] ||
             [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# # Use beam shape cursor for each new prompt.
# preexec() {
# }



# _fix_cursor() {
#    echo -ne '\e[5 q'
# }

# precmd_functions+=(_fix_cursor)

globalias() {
    zle _expand_alias
    zle expand-word
}
zle -N globalias

# ctrl space expands all aliases, including global
bindkey -M viins "^ " globalias
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source /home/arne/.config/broot/launcher/bash/br
# dingen
echo "broot is een ding"
echo "ctrl space is een ding"
echo "peco is een ding"
echo "yank is een ding"
echo "glow is een ding"

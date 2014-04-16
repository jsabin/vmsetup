# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi

#if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w'
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

PS1=$PS1'$(parse_git_branch)'"\$ " 

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi 

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mountwindows='sudo mount /dev/mapper/isw_diedchhgdg_Volume0p2 /media/windows/ -t ntfs -o iocharset=utf8,umask=000'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable autocomplete for git on OSX
if [ -f ~/AeroFS/scripts/git-completion.bash ]; then
	source ~/AeroFS/scripts/git-completion.bash
fi

#CATALINA_HOME=~/programs/apache-tomcat-7.0.32
#export CATALINA_HOME

#CATALINA_BASE=$CATALINA_HOME
#export CATLINA_BASE

#CATALINA_PID="$CATALINA_BASE/tomcat.pid"
JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
export JAVA_HOME
export CATALINA_PID

# Maven
M2_HOME=~/programs/apache-maven-3.2.1

PATH=$M2_HOME/bin:/usr/pkg/sbin:/usr/pkg/bin:/usr/pkg/sbin:/usr/pkg/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:~/scripts:$JAVA_HOME/bin:~/programs/node-v0.10.13/bin:~/programs/gradle-1.2/bin:~/programs/apache-tomcat-7.0.32/bin:~/programs/pssh-1.4.3/bin:$PATH
export TOMCAT_HOME=~/programs/apache-tomcat-7.0.32

# jeff's Aliases
alias dash='cd ~/dev/dashboard'
alias dashg='cd ~/dev/dashboardGadgets'
alias dev='cd ~/dev'
alias cassandra='/home/jsabin/programs/apache-cassandra-1.2.0/bin/cassandra -f'
alias collect='cd ~/dev/collector'
alias desktop='ssh -X 10.92.0.10'
alias kairos='cd ~/dev/kairosdb'
alias ret='cd ~/dev/retention'
alias reload='source ~/.bashrc'
alias home='cd ~'
alias jenkins='ssh -X 10.92.4.9'
alias mountfs1='sudo mount -t cifs -o user=corp/jsabin,rw,nosetuids,noperm //np-vm-fs1.corp.proofpoint.com/Develop /home/jsabin/mount/fs1-develop'
alias tomcat='cd /home/jsabin/programs/apache-tomcat-7.0.32/bin'
alias sshhome='ssh -X jeff@jsabin.dnsdynamic.com -p 2022'
alias sshhome2='ssh -X jeff@71.199.36.183 -p 2022'
alias timestamp='date +%s'
alias tablesaw='export CLASSPATH=tools/`ls -1 tools | grep tablesaw`'

# AWS instances
alias aws1='ssh -i aws_rsa.pem ubuntu@ec2-54-215-109-24.us-west-1.compute.amazonaws.com'

alias teest='echo helellofso'
function mountiso() { sudo mount -o loop "$@" /mnt/iso ;}

cd() { if [[ "$1" =~ ^\.\.+$ ]];then local a dir;a=${#1};while [ $a -ne 1 ];do dir=${dir}"../";((a--));done;builtin cd $dir;else builtin cd "$@";fi ;}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

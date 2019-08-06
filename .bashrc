#-------------------------------------------------------------
# This bashrc file is based on the sample contributed by 
# Emmanuel Rouat
# Website: http://tldp.org/LDP/abs/html/sample-bashrc.html 
#-------------------------------------------------------------

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------
# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.


#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

echo -e "${BCyan}Welcome! This is BASH ${BRed}${BASH_VERSION%.*}${NC}\n"
date
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s     # Makes our day a bit more fun.... :-)
fi

function _exit()              # Function to run upon exit of shell.
{
    echo -e "${BRed}Hasta la vista, baby${NC}"
}
trap _exit EXIT


#============================================================
#  ALIASES, PATH AND FUNCTIONS
#============================================================

#-------------------
# Personnal Aliases
#-------------------
# history
alias h='history'

# prevents accidentally clobbering files
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# mkdir
alias mkdir='mkdir -p'

# ls
alias ll='ls -lv --group-directories-first'
alias la='ll -A'

# cd
alias ..="cd .." 
alias ...="cd ../.." 
alias ....="cd ../../.." 
alias .....="cd ../../../.." 
alias ......="cd ../../../../.." 

alias j='jobs -l'
alias which='type -a'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# Makes a more readable output
alias du='du -kh'
alias df='df -kTh'

#-------------------
# Tool Aliases
#-------------------
# tools
alias b='bazel'
alias c='ctags'
alias g='git'
alias j='jupyter-notebook &'
alias p='python'
alias r='ruby'
alias t='Typora'
alias v='gVimPortable'

# git
alias ugcl='git clone'
alias ugin='git init'
alias ugad='git add'
alias ugmv='git mv'
alias ugrs='git reset'
alias ugrm='git rm'
alias uglg='git log'
alias ugsh='git show'
alias ugst='git status'
alias ugbr='git branch'
alias ugco='git checkout'
alias ugcm='git commit'
alias ugdf='git diff'
alias ugdt='git difftool'
alias ugmg='git merge'
alias ugmt='git mergetool'
alias ugrb='git rebase'
alias ugtg='git tag'
alias ugpr='git pull --rebase'
alias ugps='git push'
alias ugsb='git submodule'
alias ugcf='git config'
alias ugrt='git remote'
alias ugss='git stash'
alias ugrp='git rev-parse'
alias uggr='git grep'
alias ugcn='git clean'
alias ughp='git help'
alias ugsbup='ugsb update --init --remote --recursive'

#-------------------
# Path
#-------------------
export PATH=$PATH:/c/Ruby23-x64/bin
export PATH=$PATH:/c/Program\ Files/Typora
export PATH=$PATH:/e/data/tools/ctags
export PATH=$PATH:/e/data/tools/portableApps/PortableApps/gVimPortable
export PATH=$PATH:~/bin
export BAZEL_VC=/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2017/BuildTools/VC

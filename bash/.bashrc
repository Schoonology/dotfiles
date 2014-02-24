export CLICOLOR=1

alias .=pwd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Misspellings
alias ndoe=node

# Shortcuts
alias now='node -p -e "Date.now()"'
alias httpdump="sudo tcpdump -A -s0"
alias ll="ls -Alp"

# Git Autocompletion and PS1
source ~/.dotfiles/git/git-prompt.sh
source ~/.dotfiles/git/git-completion.sh

GIT_PS1_SHOWDIRTYSTATE=1 #... untagged(*) and staged(+) changes
GIT_PS1_SHOWSTASHSTATE=1 #... if something is stashed($)
GIT_PS1_SHOWUNTRACKEDFILES=1 #... untracked files(%)

# export PS1='`if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` \[\e[01;34m\]\u\[\e[01;37m\]:`[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "\[\e[31m\]" || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;37m\]\w\[\e[00m\]\$ '
# export PS1='`if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` \[\e[00;37m\]\W`__git_ps1`\$ '
export PS1='`if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` `[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "\[\e[01;31m\]" || echo "\[\e[01;32m\]"`$(__git_ps1 "(%s)\[\e[00m\]") \[\e[01;37m\]\W\[\e[00m\]\$ '

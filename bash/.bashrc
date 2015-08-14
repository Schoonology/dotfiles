export CLICOLOR=1

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

# NPM Config
npm set depth=0
npm set save=true
npm set save-prefix=~
npm set prefix=~/.npm
export PATH=$PATH:~/.npm/bin

. <(npm completion)

# SSH Agent
# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

env=~/.ssh/agent.env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
  if [ "$SSH_AUTH_SOCK" ]; then
    # ssh-add returns:
    #   0 = agent running, has keys
    #   1 = agent running, no keys
    #   2 = agent not running
    ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
  else
    false
  fi
}

agent_has_keys() {
  ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
  . "$env" >/dev/null
}

agent_start() {
  (umask 077; ssh-agent >"$env")
  . "$env" >/dev/null
}

add_all_keys() {
  ls ~/.ssh | grep id_rsa[^.]*$ | sed "s:^:`echo ~`/.ssh/:" | xargs -n 1 ssh-add
}

if ! agent_is_running; then
  agent_load_env
fi

# if your keys are not stored in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub, you'll need
# to paste the proper path after ssh-add
if ! agent_is_running; then
  agent_start
  add_all_keys
elif ! agent_has_keys; then
  add_all_keys
fi

echo `ssh-add -l | wc -l` SSH keys registered.

unset env

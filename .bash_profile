# encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# git
source ~/git-completion.bash
source ~/git-prompt.sh
PS1='[\u@\h \[\e[1;31m\]\W\[\e[1;36m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '

# aliases
source ~/.bash_aliases

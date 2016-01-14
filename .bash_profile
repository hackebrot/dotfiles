# encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# git
source ~/git-completion.bash
source ~/git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# aliases
source ~/.bash_aliases

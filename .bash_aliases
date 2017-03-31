# Explicitly enable alias expansion in this file
shopt -s expand_aliases

# Open changed files in vim
alias vimdf="git diff --name-only | uniq | xargs -o vim -p"
alias vimdc="git diff --cached --name-only | uniq | xargs -o vim -p"

# Helpers to create virtual envs for different Python versions
alias mkv3='mkvirtualenv -p $(which python3) -a ${PWD} ${PWD##*/}'
alias mkv2='mkvirtualenv -p $(which python) -a ${PWD} ${PWD##*/}'

# misc
alias weather='curl wttr.in/Berlin'

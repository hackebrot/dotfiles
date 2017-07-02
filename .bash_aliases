# Explicitly enable alias expansion in this file
shopt -s expand_aliases

# Open changed files in vim
alias vimdf="git diff --name-only | uniq | xargs -o vim -p"
alias vimdc="git diff --cached --name-only | uniq | xargs -o vim -p"

# Open changed files in nvim
alias nvimdf="git diff --name-only | uniq | xargs -o nvim -p"
alias nvimdc="git diff --cached --name-only | uniq | xargs -o nvim -p"

# Helper to format source code to rtf
alias pygvimp="pygmentize -g -f rtf -O style=bw -l python | pbcopy"
alias pygvimj="pygmentize -g -f rtf -O style=bw -l json | pbcopy"
alias pygvimb="pygmentize -g -f rtf -O style=bw -l bash | pbcopy"

# Helpers to create virtual envs for different Python versions
alias mkv3='mkvirtualenv -p $(which python3) -a ${PWD} ${PWD##*/}'
alias mkv2='mkvirtualenv -p $(which python) -a ${PWD} ${PWD##*/}'

# misc
alias weather='curl wttr.in/Berlin'

replaceall () {
    ag -w "$1" -l -0 | xargs -0 -n 1 sed -i '' -e "s/$1/$2/g"
}

# Explicitly enable alias expansion in this file
shopt -s expand_aliases

# Open changed files in vim
alias conflict="git diff --name-only | uniq | xargs -o vim -p"

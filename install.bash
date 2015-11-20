#!/usr/bin/env bash

set -e # Exit if an error occurs

set -u # Exit for an undefined variable

# homebrew
if [[ $(which -s brewz) != 0 ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# git
brew install git

# git-completion
if [[ ! -e ~/git-completion.bash ]]; then
  curl -o ~/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

# git-prompt
if [[ ! -e ~/git-prompt.sh ]]; then
  curl -o ~/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

# vim
brew install vim

# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# create vim directories
mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/swap/
mkdir -p ~/.vim/undo/

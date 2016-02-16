#!/usr/bin/env bash

set -e # Exit if an error occurs

set -u # Exit for an undefined variable

# homebrew
if ! hash brew 2>/dev/null; then
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

# silver searcher
brew install ag

# vim
brew install vim --with-override-system-vim --with-python3

# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# create vim directories
mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/swap/
mkdir -p ~/.vim/undo/

# create project dir
HACKEBROT=~/hackebrot/
mkdir -p $HACKEBROT

# clone vimfiles repo
git clone https://github.com/hackebrot/vimfiles.git $HACKEBROT/vimfiles

# create a symlink to make vim find the rc
ln -s $HACKEBROT/vimfiles/vimrc ~/.vimrc

# install vim plugins
vim +PluginInstall +qall

# install python
brew install python3

# install global python deps
pip3 install virtualenvwrapper
pip3 install flake8

# install cli helpers
brew install tree

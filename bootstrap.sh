#!/bin/bash
############################
# bootstrap.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

#install vim-plug if it isn't there already
if [ ! -d ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

install powerline fonts if on os x
if [[ 'Darwin' == `uname` ]]; then
  git clone https://github.com/powerline/fonts.git
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts/
else
  echo "You must manually install the fonts if not on OS X"
fi

# Install those plugins
vim -c +PlugInstall +qa

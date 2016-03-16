#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables

dir=~/.dotfiles                    			 # dotfiles directory
olddir=~/.dotfiles_old             			 # old dotfiles backup directory
files="bashrc vimrc tmux.conf muttrc bash_profile inputrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/.$file $olddir
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

#install vim-plug if it isn't there already
if [ ! -d ~/.vim/autoload/plug.vim ]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install powerline fonts if on os x
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

if [ -d ~/.vim/plugged/YouCompleteMe ]; then
	echo "Compiling YCM"
	cd ~/.vim/plugged/YouCompleteMe
	./install.py
fi

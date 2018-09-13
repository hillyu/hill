#!/bin/sh


#install on-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# softlink dotfiles
ln -s ~/dotfile/.config ~/
ln -s ~/dotfile/.vimrc ~/
ln -s ~/dotfile/.zshrc ~/
#instal vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


#!/bin/bash


#install on-my-zsh
dotpath=$1
[ -z $@ ] && read -p "dotfile path: " dotpath
cd $HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# softlink dotfiles
item_to_link=('.config' '.vimrc' '.zshrc' 'zshrc.mac' 'zshrc.linux' 'kitty.conf.mac')
for i in ${item_to_link[@]}; do
    [ -L $i ] && rm -v $i
    [ -e $i ] && mv $i $i.old
    ln -vs $dotpath/$i ~/
done


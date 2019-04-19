#!/bin/sh


#install on-my-zsh
read -p "dotfile path: " $dotpath
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# softlink dotfiles
item_to_link=('.config' '.vimrc' '.zshrc' 'zshrc.mac' 'zshrc.linux' 'kitty.conf.mac')
for i in ${item_to_link[@]}; do
    ln -s "$dotpath"/"$i" ~/
done


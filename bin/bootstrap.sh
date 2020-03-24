#!/bin/bash


dotpath=$1
[ -z $@ ] && read -p "dotfile path: " dotpath
cd $HOME

#install on-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#install zsh-custom plugins:
#git clone --recursive https://github.com/joel-porquet/zsh-dircolors-solarized \
    #$HOME/.oh-my-zsh/custom/plugins/zsh-dircolors-solarized
git clone --recursive https://github.com/unixorn/warhol.plugin.zsh.git \
    $HOME/.oh-my-zsh/custom/plugins/warhol
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
    $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

# softlink dotfiles
item_to_link=('.config' '.vimrc' '.zshrc' 'zshrc.mac' 'zshrc.linux' '.zshenv' 'kitty.conf.mac' '.tmux.conf')
for i in ${item_to_link[@]}; do
    [ -L $i ] && rm -v $i
    [ -e $i ] && mv $i $i.old
    ln -vs $dotpath/$i ~/
done

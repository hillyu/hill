#!/usr/bin/env bash


dotpath=$1
[ -z $@ ] && read -p "dotfile path: " dotpath
cd $HOME
for i in "$dotpath"/terminfo/*; do tic -x "$i";done

#install on-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#install zsh-custom plugins:
#git clone --recursive https://github.com/joel-porquet/zsh-dircolors-solarized \
    #$HOME/.oh-my-zsh/custom/plugins/zsh-dircolors-solarized
# zsh related
# mkdir -p .zsh/{plugins,themes,lib}
# git clone --recursive https://github.com/unixorn/warhol.plugin.zsh.git \
    # $HOME/.zsh/plugins/warhol
# git clone https://github.com/zdharma/fast-syntax-highlighting.git \
    # $HOME/.zsh/plugins/fast-syntax-highlighting

# softlink dotfiles
item_to_link=('.config' '.vimrc' '.zshrc' 'zshrc.mac' 'zshrc.linux' '.zshenv' 'kitty.conf.mac' '.tmux.conf' '.zsh' 'firefox_userChrome')
for i in ${item_to_link[@]}; do
    [ -L $i ] && rm -v $i
    [ -e $i ] && mv $i $i.old
    ln -vs $dotpath/$i ~/
done
cd $dotpath && git submodule update --init --recursive --remote

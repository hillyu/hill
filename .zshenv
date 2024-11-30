# User configuration
export PATH=$HOME/.zsh/plugins/warhol/bin:$HOME/.local/bin:$HOME/bin:$PATH
#node user install
export PATH="$HOME/.node/bin:$PATH"  
export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH" 
export MANPATH="$HOME/.node/share/man:$MANPATH"  
export XDG_CONFIG_HOME=$HOME/.config
# # pager set to vim
export MANPAGER=/bin/sh\ -c\ \"unset\ MANPAGER\;col\ -b\ -x\ \|\ nvim\ -R\ -c\ \'set\ ft=man\ nonumber\ norelativenumber\ nomod\ nolist\'\ -\"
# export MANPAGER=/usr/share/nvim/runtime/macros/less.sh
export GROFF_NO_SGR=1

#export PAGER=/usr/share/vim/vim82/macros/less.sh
#export PAGER=less
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vi'
 else
   export ALTERNATE_EDITOR=""
   #export EDITOR="emacsclient -c -a emacs"
   export EDITOR="vi"
   #export VISUAL="emacsclient -c -a emacs"
   export VISUAL="vi"
   export SUDO_EDITOR="vi"
 fi
# hack to skip wayland check on qute browser, it actually supports wayland(not wayland-egl) backend
# export HF_HOME=$HOME/HF
# f="$HF_HOME/token"; [[ -f $f ]] && export HF_API_KEY=$(cat $f)

alias fromipad='scp -r ipad:Documents/PSP/SAVEDATA .config/ppsspp/PSP/'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

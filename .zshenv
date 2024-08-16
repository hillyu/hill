# User configuration
export PATH=$HOME/.zsh/plugins/warhol/bin:$HOME/.local/bin:$HOME/bin:$PATH
#node user install
export PATH="$HOME/.node/bin:$PATH"  
export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH" 
export MANPATH="$HOME/.node/share/man:$MANPATH"  
export XDG_CONFIG_HOME=$HOME/.config
PATH="/home/hill/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/hill/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/hill/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/hill/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hill/perl5"; export PERL_MM_OPT;
# wayland settings
#

#export WAYLAND_DEBUG=1 
#export BEMENU_BACKEND=wayland
#export KITTY_ENABLE_WAYLAND=1
# export GDK_BACKEND=wayland
# export CLUTTER_BACKEND=wayland
# export MOZ_ENABLE_WAYLAND=1
#allow video hardware decoding on wayland for firefox.
# export MOZ_DISABLE_RDD_SANDBOX=1
# export MOZ_X11_EGL=1 
# export MOZ_USE_OMTC=1
export MOZ_USE_XINPUT2=1
#export QT_QPA_PLATFORM=wayland-egl
#export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
# export QT_WAYLAND_FORCE_DPI=physical
# export SDL_VIDEODRIVER=wayland
# export ECORE_EVAS_ENGINE=wayland
# export ELM_ENGINE=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
#hack to enable libappindicator under swaywm
# XDG_CURRENT_DESKTOP=Unity
#set qt theme font to stay consistent with gtk
# export QT_QPA_PLATFORMTHEME=qt5ct
# export GTK_CSD=0
# export QT_AUTO_SCREEN_SCALE_FACTOR=1
#radeon card
#export VDPAU_DRIVER=radeonsi 
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
# export QUTE_SKIP_WAYLAND_CHECK=1
export LANG=en_HK.UTF-8
export LC_CTYPE=zh_CN.UTF-8
export GTK_IM_MODULE=fcitx #cause teams/typora crash on wayland
export GLFW_IM_MODULE=ibus
export QT_IM_MODULE=fcitx
export QT5_IM_MODULE=fcitx
export xim=fcitx
export XMODIFIERS=@im=fcitx
# export GLFW_IM_MODULE=ibus
source $HOME/.config/nnn/config
#set dircolor using LS_COLOR var, on mac it is LSCOLOR in a different format, one can easly convert them using online tools https://geoff.greer.fm/lscolors/
export MPD_HOST=~/.config/mpd/socket
export BROWSER=brave
export BROWSER_TXT=w3m
export RTV_BROWSER="w3m"
export RTV_URLVIEWER="$HOME/bin/st-urlhandler"
export CM_LAUNCHER=rofi
# export TERMINAL=st
export TERMINAL="alacritty -e"
#export CHROME_USER_DATA_DIR=/home/hill/.config/google-chrome
export LIBVA_DRIVER_NAME=radeonsi
export BRAVE_FLAGS='--user-data-dir=/home/hill/.config/google-chrome --no-default-browser-check'
export LIBSEAT_BACKEND=logind
export HF_HOME=$HOME/HF
f="$HF_HOME/token"; [[ -f $f ]] && export HF_API_KEY=$(cat $f)

alias fromipad='scp -r ipad:Documents/PSP/SAVEDATA .config/ppsspp/PSP/'

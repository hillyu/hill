# User configuration
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export WAYLAND_DEBUG=1 
export BEMENU_BACKEND=wayland
export KITTY_ENABLE_WAYLAND=1
#export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
#export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_FORCE_DPI=physical
#export QT_DISABLE_WINDOWDECORATION=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

export ECORE_EVAS_ENGINE=wayland_egl
export ELM_ENGINE=wayland_egl
export PATH=~/.local/bin:~/bin:$PATH
#set qt theme font to stay consistent with gtk
export QT_STYLE_OVERRIDE=GTK+
export GTK_CSD=0
#export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

# export MANPATH="/usr/local/man:$MANPATH"
# # pager set to vim
export MANPAGER=/bin/sh\ -c\ \"unset\ MANPAGER\;col\ -b\ -x\ \|\ vim\ -R\ -c\ \'set\ ft=man\ nonumber\ norelativenumber\ nomod\ nolist\'\ -\"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export ALTERNATE_EDITOR=""
   #export EDITOR="emacsclient -c -a emacs"
   export EDITOR="vim"
   #export VISUAL="emacsclient -c -a emacs"
   export VISUAL="vim"
 fi
# hack to skip wayland check on qute browser, it actually supports wayland(not wayland-egl) backend
# export QUTE_SKIP_WAYLAND_CHECK=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
#set dircolor using LS_COLOR var, on mac it is LSCOLOR in a different format, one can easly convert them using online tools https://geoff.greer.fm/lscolors/
. "$HOME/.cargo/env"

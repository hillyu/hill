# User configuration
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
#export QT_QPA_PLATFORM=wayland-egl
export QT_DISABLE_WINDOWDECORATION=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export ECORE_EVAS_ENGINE=wayland_egl
export ELM_ENGINE=wayland_egl
export SDL_VIDEODRIVER=wayland
export SDL_VIDEODRIVER=wayland
export PATH=~/bin:$PATH
export GTK_CSD=0
#export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

# export MANPATH="/usr/local/man:$MANPATH"

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
 fi
# hack to skip wayland check on qute browser, it actually supports wayland(not wayland-egl) backend
# export QUTE_SKIP_WAYLAND_CHECK=1

autoload -Uz compinit promptinit
compinit
promptinit
setopt prompt_subst
setopt auto_cd
setopt interactivecomments
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
alias ls=lsd
plugins=(tmux docker git warhol fast-syntax-highlighting)
source /home/hill/.zsh/lib/git.zsh
source /home/hill/.zsh/lib/directories.zsh
source /home/hill/.zsh/lib/completion.zsh
source /home/hill/.zsh/lib/correction.zsh
source /home/hill/.zsh/lib/key-bindings.zsh
source /home/hill/.zsh/lib/theme-and-appearance.zsh
source /home/hill/.zsh/plugins/docker/_docker
source /home/hill/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /home/hill/.zsh/plugins/git/git.plugin.zsh
source /home/hill/.zsh/plugins/warhol/warhol.plugin.zsh
source /home/hill/.zsh/themes/ys.zsh-theme
alias th='perl -pe '\''s/(\d+)%/($1*8\/100).h/e'\'''
if [[ `uname` == "Linux" ]]; then
    source $HOME/zshrc.linux
fi
if [[ `uname` == "Darwin" ]]; then
    source $HOME/zshrc.mac
fi
alias vi="vim"

autoload -Uz compinit promptinit
autoload -Uz run-help
autoload -U colors && colors
compinit
promptinit
setopt prompt_subst
setopt auto_cd
setopt interactivecomments
ENABLE_CORRECTION="true"
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7,bg=68"
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=58"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11"
# ZSH_HIGHLIGHT_STYLES[comment]="fg=black"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
source $HOME/.zsh/lib/git.zsh
source $HOME/.zsh/lib/directories.zsh
source $HOME/.zsh/lib/completion.zsh
source $HOME/.zsh/lib/correction.zsh
source $HOME/.zsh/lib/key-bindings.zsh
source $HOME/.zsh/plugins/git/git.plugin.zsh
source $HOME/.zsh/plugins/warhol/warhol.plugin.zsh
source $HOME/.zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/themes/ys.zsh-theme
source $HOME/.zsh/completions/_docker
source $HOME/.zsh/completions/_pip
[[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]] &&\
source /usr/share/doc/pkgfile/command-not-found.zsh
source $HOME/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# import dircolors suitable for solorized dark
# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#fast-syntax-highlighting set theme to q-jmnemonic
# fast-theme -t q-jmnemonic
# load run-help and alias it it help so alt-h can support shell bultins
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
command -v nvim >/dev/null 2>&1 && alias vi="MTTY="/dev/$(ps hotty $$|tail -n1|tr -d ' ')" nvim"
# alias th='perl -pe '\''s/(\d+)%/($1*8\/100).h/e'\'''
if [[ `uname` == "Linux" ]]; then
    source $HOME/zshrc.linux
fi
if [[ `uname` == "Darwin" ]]; then
    source $HOME/zshrc.mac
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

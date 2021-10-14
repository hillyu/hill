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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=58"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
source /home/hill/.zsh/lib/git.zsh
source /home/hill/.zsh/lib/directories.zsh
source /home/hill/.zsh/lib/completion.zsh
source /home/hill/.zsh/lib/correction.zsh
source /home/hill/.zsh/lib/key-bindings.zsh
source /home/hill/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /home/hill/.zsh/plugins/git/git.plugin.zsh
source /home/hill/.zsh/plugins/warhol/warhol.plugin.zsh
source /home/hill/.zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /home/hill/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/hill/.zsh/themes/ys.zsh-theme
source /home/hill/.zsh/completions/_docker
source /home/hill/.zsh/completions/_pip
[[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]] &&\
source /usr/share/doc/pkgfile/command-not-found.zsh
# import dircolors suitable for solorized dark
eval `dircolors /home/hill/.zsh/themes/dircolors-solarized/dircolors.256dark`
# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# load run-help and alias it it help so alt-h can support shell bultins
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
command -v vim >/dev/null 2>&1 && alias vi="vim"
command -v lsd >/dev/null 2>&1 && alias ls=lsd || alias ls="ls --color=auto"
# alias th='perl -pe '\''s/(\d+)%/($1*8\/100).h/e'\'''
if [[ `uname` == "Linux" ]]; then
    source $HOME/zshrc.linux
fi
if [[ `uname` == "Darwin" ]]; then
    source $HOME/zshrc.mac
fi

PATH="/home/hill/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/hill/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/hill/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/hill/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hill/perl5"; export PERL_MM_OPT;

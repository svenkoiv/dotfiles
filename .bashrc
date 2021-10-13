
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# alias vim='nvim'

PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

# Configure command history
HISTCONTROL=erasedups:ignoreboth
HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd'
HISTSIZE=10000
HISTFILESIZE=10000

export TERM=xterm

# To append commands to the history file, rather than overwrite it
shopt -s histappend

eval "$(direnv hook bash)"

alias luamake=/home/skoiv/lsp/lua-language-server/3rd/luamake/luamake
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


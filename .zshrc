export ZSH=/Users/shadowfacts/.oh-my-zsh

ZSH_THEME="honukai"

plugins=(osx git)

source $ZSH/oh-my-zsh.sh

# command line tools

alias fuck='$(thefuck $(fc -ln -1))'

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

alias git=hub

alias python=python3
alias pip=pip3

alias oldruby="/usr/local/bin/ruby"
alias ruby="/usr/local/Cellar/ruby/2.3.0/bin/ruby"

export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.shi

# default file openings
alias -s ipr=open

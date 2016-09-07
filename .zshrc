export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="shadowfacts"

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

# lazily load nvm
export NVM_DIR=~/.nvm
#. $(brew --prefix nvm)/nvm.sh

nvm() {
	unset -f nvm
	. $(brew --prefix nvm)/nvm.sh
	nvm "$@"
}

node() {
	unset -f node
	. $(brew --prefix nvm)/nvm.sh
	node "$@"
}

npm() {
	unset -f npm
	. $(brew --prefix nvm)/nvm.sh
	npm "$@"
}

# default file openings
alias -s ipr=open

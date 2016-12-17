export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="shadowfacts"

plugins=(osx git)

source $ZSH/oh-my-zsh.sh

# Use Homebrew bin before defaults
export PATH="/usr/local/bin:$PATH"

# command line tools
alias fuck='$(thefuck $(fc -ln -1))'

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

alias git=hub

alias python=python3
alias pip=pip3

alias oldruby="/usr/local/bin/ruby"
alias ruby="/usr/local/Cellar/ruby/2.3.1/bin/ruby"

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

# Go up N directories
up() {
	str=""
	count=0
	while [ "$count" -lt "$1" ];
	do
		str=$str"../"
		let count=count+1
	done
	cd $str"$2"
}

# Git helper functions
psh() {
	branch=`git branch 2> /dev/null | grep \* | awk '{print $2}'`
	git push origin $branch "$@"
}

pll() {
	branch=`git branch 2> /dev/null | grep \* | awk '{print $2}'`
	git pull origin $branch "$@"
}

a() {
	git add "$@"
}

s() {
	git status
}

c() {
	git commit "$@"
}

ca() {
	git commit --amend "$@"
}

# default file openings
alias -s ipr=open

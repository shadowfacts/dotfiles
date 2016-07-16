# Custom Prompt
# Color
source ~/.bash_color
# Before the Prompt
print_before_the_prompt () {
	GIT=''
	BRANCH=`git branch 2> /dev/null | grep \* | awk '{print $2}'`
	if [[ "$BRANCH" != "" ]]; then
		GIT="[git:$BRANCH]"
	fi
	homeDir="/Users/shadowfacts"
	dir="${PWD/$homeDir/~}"
	printf "\n$bldred[$(hostname)][$USER]  $bldgrn$dir $bldpur$GIT \n$txtrst"
}
PROMPT_COMMAND=print_before_the_prompt
# The Actual Prompt
# PS1='\[$(tput bold)$  \[$(tput sgr0]\'
PS1="\[$(tput bold 4)\]$ \[$(tput sgr0)\]"

# The Fuck
# https://github.com/nvbn/thefuck
alias fuck='$(thefuck $(fc -ln -1))'

# Sublime Text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
#export EDITOR='subl -w'

# Hub
# https://github.com/github/hub
alias git=hub

# Python 3
alias python=python3

# pip
alias pip=pip3

# Ruby
alias oldruby="/usr/local/bin/ruby"
alias ruby="/usr/local/Cellar/ruby/2.3.0/bin/ruby"

# Electron
# alias electron=/Applications/Electron.app/Contents/MacOS/Electron

# NVM
# https://github.com/creationx/nvm
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh

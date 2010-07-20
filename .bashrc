if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]; then
	export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
	export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
fi

export PATH="~/.brde/bin/:/bin:/usr/bin:${PATH}"

alias "l"="ls --color"
alias "ls"="ls --color"
alias "ll"="ls -lh --color"
alias "la"="ls -la --color"
alias "lh"="ls -lha --color"
alias ".."="cd .."

alias retouch="find -name '*.html' | xargs touch"

export LC_MESSAGES=C

f() { find $3 -name "*.$1" | xargs egrep --color "$2" ; }
findjs() { f php $1 ; } 
findphp() { find $2 -name "*.php" | xargs egrep --color "$1" ; }
findhtml() { find $2 -name "*.html" | xargs egrep --color "$1" ; }

alias vi='vim -u /home/web/.vimrc -u /home/web/.brde/.vimrc'
alias vim='vim -u /home/web/.vimrc -u /home/web/.brde/.vimrc'

ff() {
	if [[ "$1" == "" ]]; then
		cd /home/web/vhosts/
	else
		cd /home/web/vhosts/$1*brde
	fi
}

reload() { source ~/.bashrc_brde ; }

# replace svn command
source ~/.brde/.subversion

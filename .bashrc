if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]; then
	export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]'
	export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
fi

export PATH="~/.brde/bin/:~/.brde/ruby-enterprise/bin:/bin:/usr/bin:${PATH}"

alias "l"="ls --color"
alias "ls"="ls --color"
alias "ll"="ls -lh --color"
alias "la"="ls -la --color"
alias "lh"="ls -lha --color"

alias ".."="cd .."

alias "mx"="chmod +x"

alias retouch="find -name '*.html' | xargs touch"

export LC_MESSAGES=C

f() { find $3 -name "*.$1" | xargs egrep --color "$2" ; }
findjs() { f php $1 ; } 
findphp() { find $2 -name "*.php" | xargs egrep --color "$1" ; }
findhtml() { find $2 -name "*.html" | xargs egrep --color "$1" ; }

alias vi='vim -u /home/web/.vimrc -u /home/web/.brde/.vimrc'
alias vim='vim -u /home/web/.vimrc -u /home/web/.brde/.vimrc'

alias mysql='MYSQL_HISTFILE=~/.brde/.mysql_history mysql --defaults-file=~/.brde/.my.cnf'
alias mysqladmin='MYSQL_HISTFILE=~/.brde/.mysql_history mysqladmin --defaults-file=~/.brde/.myadmin.cnf'
alias mysqldump='MYSQL_HISTFILE=~/.brde/.mysql_history mysqldump --defaults-file=~/.brde/.mydump.cnf'


ff() {
	if [[ "$1" == "" ]]; then
		cd /home/web/vhosts/
	else
		cd /home/web/vhosts/$1*brde
	fi
	pwd
}

fm() {
	root=$(pwd|egrep -o '^/home/web/vhosts/[^/]+/')
	[[ -z $root ]] && root=$(pwd)/
	cd ${root}modules/$1*/
	pwd
}


ec() { 
	vim ~/.brde
	chmod +x ~/.brde/bin/*
	reload
}


reload() { 
	source ~/.bashrc_brde 
}

# replace svn command
source ~/.brde/.subversion

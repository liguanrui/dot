# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias mkcscopefile='find `pwd` -name > cscope.files'  
alias mktag='ctags -R;cscope -bR' 
# User specific aliases and functions

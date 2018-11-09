# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash ]; then
    . /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash
fi

# User specific environment and startup programs
. $HOME/.shell_prompt.sh
PATH=$PATH:$HOME/bin

export TERM=screen-256color

export PATH

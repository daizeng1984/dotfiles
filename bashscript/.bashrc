# Which machine? we use uname to see: http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
DOTFILES_HOME=$HOME/.dotfiles
if [ "$(uname -s)" == "Darwin" ]; then
	echo "Find Darwin System..."
    [ -r $DOTFILES_HOME/bashscript/platform/.macbashrc ] && source $DOTFILES_HOME/bashscript/platform/.macbashrc
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	echo "Find Linux System..."
    [ -r $DOTFILES_HOME/bashscript/platform/.linuxbashrc ] && source $DOTFILES_HOME/bashscript/platform/.linuxbashrc
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
	echo "Find Cygwin System..."
    [ -r $DOTFILES_HOME/bashscript/platform/.cygwinbashrc ] && source $DOTFILES_HOME/bashscript/platform/.cygwinbashrc
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	echo "Find MingW32 System..."
    [ -r $DOTFILES_HOME/bashscript/platform/.cygwinbashrc ] && source $DOTFILES_HOME/bashscript/platform/.cygwinbashrc
fi

[ -r $DOTFILES_HOME/samples/var.def ] && source $DOTFILES_HOME/samples/var.def

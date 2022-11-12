# non interactive
# my env vars
export DOTFILES_HOME=$HOME/.dotfiles
source $DOTFILES_HOME/bashscript/env.sh

# interactive guard
if [ -z "$PS1" ]; then
    return
fi

DOTFILES_SYSTEM_NAME="unknown"

# Which machine? we use uname to see: http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
if [ "$(uname -s)" = "Darwin" ]; then
	echo "Find Darwin System..."
    DOTFILES_SYSTEM_NAME="darwin"
    [ -r $DOTFILES_HOME/bashscript/platform/.macbashrc ] && source $DOTFILES_HOME/bashscript/platform/.macbashrc
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
	echo "Find Linux System..."
    DOTFILES_SYSTEM_NAME="linux"
    [ -r $DOTFILES_HOME/bashscript/platform/.linuxbashrc ] && source $DOTFILES_HOME/bashscript/platform/.linuxbashrc
elif [ "$(expr substr $(uname -s) 1 9)" = "CYGWIN_NT" ]; then
	echo "Find Cygwin System..."
    DOTFILES_SYSTEM_NAME="cygwin"
    [ -r $DOTFILES_HOME/bashscript/platform/.cygwinbashrc ] && source $DOTFILES_HOME/bashscript/platform/.cygwinbashrc
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
	echo "Find MingW32 System..."
    DOTFILES_SYSTEM_NAME="mingw32"
    [ -r $DOTFILES_HOME/bashscript/platform/.cygwinbashrc ] && source $DOTFILES_HOME/bashscript/platform/.cygwinbashrc
else
    DOTFILES_SYSTEM_NAME="unknown"
    [ -r $DOTFILES_HOME/bashscript/platform/.linuxbashrc ] && source $DOTFILES_HOME/bashscript/platform/.linuxbashrc
fi

[ -r $DOTFILES_HOME/samples/var.def ] && source $DOTFILES_HOME/samples/var.def

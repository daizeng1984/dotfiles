# non interactive
# my env vars
export DOTFILES_HOME=$HOME/.dotfiles
source $DOTFILES_HOME/bashscript/env.sh

# interactive guard
if [ -z "$PS1" ]; then
    return
fi

# TODO: clean bash and zsh's home folder pollution
SYSTEM_NAME=$(uname -s)
DOTFILES_SYSTEM_NAME="unknown"

if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ]; then
    DOTFILES_SYSTEM_NAME="darwin"
	echo "Find darwin System..."
    [ -r $DOTFILES_HOME/zshscript/platform/.nixzshrc ] && source $DOTFILES_HOME/zshscript/platform/.nixzshrc
elif [ "$(echo $SYSTEM_NAME | cut -c 1-5)" = "Linux" ]; then
	echo "Find Linux System..."
    [ -r $DOTFILES_HOME/zshscript/platform/.nixzshrc ] && source $DOTFILES_HOME/zshscript/platform/.nixzshrc
else
    echo "Unsupported System..."
fi

# This will load the variable part of script, depending on machine and OS.
[ -r $DOTFILES_HOME/samples/var.def ] && source $DOTFILES_HOME/samples/var.def

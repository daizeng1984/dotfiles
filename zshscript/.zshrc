DOTFILES_HOME=$HOME/.dotfiles
# TODO: clean bash and zsh's home folder pollution
SYSTEM_NAME=$(uname -s)
__shell_type__="zsh"
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ] || [ "$(echo $SYSTEM_NAME | cut -c 1-5)" = "Linux" ]; then
	echo "Find *nix System..."
    [ -r $DOTFILES_HOME/zshscript/platform/.nixzshrc ] && source $DOTFILES_HOME/zshscript/platform/.nixzshrc
else
    echo "Unsupported System..."
fi

# This will load the variable part of script, depending on machine and OS.
[ -r $DOTFILES_HOME/samples/var.def ] && source $DOTFILES_HOME/samples/var.def

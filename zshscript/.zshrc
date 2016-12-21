# TODO: clean bash and zsh's home folder pollution
[ -r $HOME/.nixzshrc ] && source $HOME/.nixzshrc
# This will load the variable part of script, depending on machine and OS.
[ -r $HOME/.dotfiles/samples/var.def ] && source $HOME/.dotfiles/samples/var.def

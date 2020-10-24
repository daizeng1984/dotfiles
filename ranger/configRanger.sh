# TODO: dup code Create symlink
[ -d $XDG_CONFIG_HOME/ranger ] && mv $XDG_CONFIG_HOME/ranger $XDG_CONFIG_HOME/.old.ranger
[ -L $XDG_CONFIG_HOME/ranger ] && rm $XDG_CONFIG_HOME/ranger
ln -s $HOME/.dotfiles/ranger $XDG_CONFIG_HOME/ranger

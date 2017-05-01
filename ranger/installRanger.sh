# Find .config
[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME="$HOME/.config"
[ ! -d $XDG_CONFIG_HOME ] && mkdir -p -- $XDG_CONFIG_HOME

# Install ranger and atool on centos
# brew install ranger
# brew install atool
# brew install udisks
# TODO:

# TODO: dup code Create symlink
[ -d $XDG_CONFIG_HOME/ranger ] && mv $XDG_CONFIG_HOME/ranger $XDG_CONFIG_HOME/.old.ranger
[ -L $XDG_CONFIG_HOME/ranger ] && rm $XDG_CONFIG_HOME/ranger
ln -s $HOME/.dotfiles/ranger $XDG_CONFIG_HOME/ranger

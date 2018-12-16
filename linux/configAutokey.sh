# Find .config
[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME="$HOME/.config"
[ ! -d $XDG_CONFIG_HOME ] && mkdir -p -- $XDG_CONFIG_HOME
[ ! -d $XDG_CONFIG_HOME/autokey/data ] && mkdir -p -- $XDG_CONFIG_HOME/autokey/data

# Create symlink
[ -d $XDG_CONFIG_HOME/autokey/data/autokey ] && rm $XDG_CONFIG_HOME/autokey/data/autokey
ln -s $HOME/.dotfiles/linux/autokey $XDG_CONFIG_HOME/autokey/data/autokey

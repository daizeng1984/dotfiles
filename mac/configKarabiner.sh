# Find .config
[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME="$HOME/.config"
[ ! -d $XDG_CONFIG_HOME ] && mkdir -p -- $XDG_CONFIG_HOME

# Create symlink
[ -d $XDG_CONFIG_HOME/karabiner ] && rm -rf -- $XDG_CONFIG_HOME/karabiner
[ -L $XDG_CONFIG_HOME/karabiner ] && rm $XDG_CONFIG_HOME/karabiner
ln -s $HOME/.dotfiles/mac/karabiner $XDG_CONFIG_HOME/karabiner

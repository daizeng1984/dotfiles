# Find .config
[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME="~/.config"
[ ! -d $XDG_CONFIG_HOME ] && mkdir -p $XDG_CONFIG_HOME
# Create symlink
ln -s $HOME/.dotfiles/neovim/nvim $XDG_CONFIG_HOME/nvim

# Install Vim-Plug to default vim rum
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

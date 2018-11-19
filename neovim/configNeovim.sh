# Find .config
[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME="$HOME/.config"
[ ! -d $XDG_CONFIG_HOME ] && mkdir -p -- $XDG_CONFIG_HOME
# Create symlink
[ -d $XDG_CONFIG_HOME/nvim ] && rm -rf -- $XDG_CONFIG_HOME/nvim
[ -L $XDG_CONFIG_HOME/nvim ] && rm $XDG_CONFIG_HOME/nvim
ln -s $HOME/.dotfiles/neovim/nvim $XDG_CONFIG_HOME/nvim

# Install Vim-Plug to default vim rum
echo "Install Vim-Plug manager"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# It seems vim-plug support...
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

# Now conda forge already have nvim recipe
# install vim
# mkdir -p /tmp/installnvim
# if [ "$DOTFILES_SYSTEM_NAME" = "darwin" ]; then
# curl -fLo /tmp/installnvim/nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-macos.tar.gz
# folder_name="macos"
# tar -zxvkf /tmp/installnvim/nvim.tar.gz  --directory /tmp/installnvim
# rsync -razvIP /tmp/installnvim/nvim-$folder_name/*  ~/.dotfiles/.local/
# elif [ "$DOTFILES_SYSTEM_NAME" = "mingw" ]; then
# echo "please use scoop install and make sure it's installed"
# else
# curl -fLo /tmp/installnvim/nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
# folder_name="linux64"
# tar -zxvkf /tmp/installnvim/nvim.tar.gz  --directory /tmp/installnvim
# rsync -razvIP /tmp/installnvim/nvim-$folder_name/*  ~/.dotfiles/.local/
# fi

# Install Vim-Plug to default vim rum
echo "Install Vim-Plug manager"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# It seems vim-plug support...
nvim -u $HOME/.dotfiles/neovim/nvim/init.vim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

# Install Vim-Plug to default vim rum
echo "Install Vim-Plug manager"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# It seems vim-plug support...
alias vim="vim -u $HOME/.config/nvim/init.vim"
vim -u $HOME/.dotfiles/neovim/nvim/config/plugins.vimrc +PlugInstall +qall
vim +UpdateRemotePlugins +qall

# home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
# nix-env -i home-manager
# source
# by default bash
source ~/.bashrc
nix-shell '<home-manager>' -A install
# firefox profile hack
rm $HOME/.mozilla/firefox/profiles.ini
home-manager -b bak switch

# install good stuff
source ~/.bashrc
# neovim
# depends on nodejs, python, maybe installMiniconda first?
source $HOME/.dotfiles/neovim/configNeovim.sh

# tmux
source $HOME/.dotfiles/tmux/configTmux.sh

# zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh


# source
export NIX_HOME_PATH=$HOME/.nix-profile
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi

# home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
#nix-env -i home-manager


# by default bash
source ~/.bashrc

home-manager switch

# install good stuff

# neovim
# depends on nodejs, python, maybe installMiniconda first?
source $HOME/.dotfiles/neovim/configNeovim.sh

# tmux
source $HOME/.dotfiles/tmux/configTmux.sh

# zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh


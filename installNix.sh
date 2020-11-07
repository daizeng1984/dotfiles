#!/bin/bash
# Install nix with root (TODO: for linux with no permission)
PLATFORM="Linux"
SYSTEM_NAME=$(uname -s)
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ]; then
	echo "install nix to darwin..."
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
else
    echo "install nix to linux..."
    sh <(curl -L https://nixos.org/nix/install)
fi


# source
export NIX_HOME_PATH=$HOME/.nix-profile
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi

# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install


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


#!/usr/bin/env bash
# Install nix with root (TODO: for linux with no permission)
PLATFORM="Linux"
SYSTEM_NAME=$(uname -s)
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ]; then
	echo "install nix to darwin..."
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
    source $HOME/.dotfiles/nix/configNix.sh
elif [[ `uname -n` == *"nixos"* ]]; then
    echo "nix installed, add channels only"
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --update
    source $HOME/.dotfiles/nix/configNix.sh
else
    echo "install nix to linux..."
    if [[ " $@ " =~ " --no-root " ]]; then
        source $HOME/.dotfiles/conda/installMiniconda.sh
        # tmux namespace unfriendly
        conda install -y -c conda-forge tmux
        conda install -y -c conda-forge ncurses
        echo "install nix without root..."
        [ ! -d $HOME/.nix ] && mkdir -m 0755 $HOME/.nix
        [ ! -d $HOME/.config/nix/ ] && mkdir -p $HOME/.config/nix
        echo "sandbox = false" > $HOME/.config/nix/nix.conf
        #export PROOT_NO_SECCOMP=1
        $HOME/.dotfiles/.local/bin/nix-user-chroot $HOME/.nix /bin/bash -c 'curl -L https://nixos.org/nix/install | sh'
        $HOME/.dotfiles/.local/bin/nix-user-chroot  $HOME/.nix /bin/bash -c 'source $HOME/.dotfiles/nix/configNix.sh'
    else
        sh <(curl -L https://nixos.org/nix/install)
        source $HOME/.dotfiles/nix/configNix.sh
    fi
fi


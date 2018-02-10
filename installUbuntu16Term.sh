#!/usr/bin/bash
add-apt-repository ppa:neovim-ppa/stable
add-apt-repository ppa:aacebedo/fasd
apt-get update

# Install only terminal app
apt-get -y install build-essential

apt-get -y install curl gcc g++ git ruby wget

# Install npm and nodejs
apt-get -y install nodejs npm

# Install python34 and pip3
apt-get -y install python3 python3-pip # --user for pip install

source ./installVimWithLua.sh
apt-get -y install neovim
pip3 install neovim --user
pip install neovim --user
apt-get -y install tree
apt-get -y install zsh
apt-get -y install silversearcher-ag
apt-get -y install fasd
apt-get -y install xsel
apt-get -y install ripgrep
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x diff-so-fancy
mv diff-so-fancy /usr/bin/

# autocomplete ignore case for bash
echo "set completion-ignore-case On" >> $HOME/.inputrc

# Install zsh to be default
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# ZSH should do this by default
# chsh -s /usr/bin/zsh but this doesn't always work!!!: you might need to manually change /etc/passwd

# Download dotfiles necessary?
DOTFILES=.dotfiles
[ -d "$DOTFILES" ] && git clone https://github.com/daizeng1984/configuration.git $DOTFILES
# Create symlink
cd ~/DOTFILES && ./createSymlink.sh

# Install runtime script for neovim and download the basic plugin manager
. ./neovim/installNeoVim.sh

#reboot

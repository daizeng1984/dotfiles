#!/usr/bin/bash
# Install only terminal app
yum -y groupinstall 'Development Tools'

# 3rd Party Repo 
# Install Elrepo based on official website, this might be changed
# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
# rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

# Install EPEL
yum -y install epel-release

# Install some tools essential for myself
yum -y install curl gcc irb gcc-c++ git ruby
yum -y install wget
yum -y install ntfs-3g
yum -y install python35 python35-setuptools python-virtualenv # --user for pip install
source ./installVimWithLua.sh
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
yum -y install neovim
pip3 install neovim
yum -y install tree
yum -y zsh

# autocomplete ignore case for bash
echo "set completion-ignore-case On" >> $HOME/.inputrc

# Install zsh to be default
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# ZSH should do this by default
# chsh -s /usr/bin/zsh
# However for ssh you might need to change /etc/passwd

# Download dotfiles necessary?
DOTFILES=.dotfiles
[ -d "$DOTFILES" ] && git clone https://github.com/daizeng1984/configuration.git $DOTFILES
# Create symlink
cd ~/DOTFILES && ./createSymlink.sh

# Install runtime script for neovim and download the basic plugin manager
. ./neovim/installNeoVim.sh

#reboot

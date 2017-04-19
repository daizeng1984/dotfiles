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

# Install gdrive
wget https://docs.google.com/uc\?id\=0B3X9GlR6Embnb010SnpUV0s2ZkU\&export\=download -O /usr/local/bin/gdrive
chmod +x /usr/local/bin/gdrive

# Install npm and nodejs
yum -y install npm

# Install python34 and pip3
yum -y install python34 python34-setuptools python-virtualenv # --user for pip install
wget https://bootstrap.pypa.io/get-pip.py 
python3.4 get-pip.py --user
# yum -y install python python-setuptools
rm get-pip.py

source ./installVimWithLua.sh
curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
yum -y install neovim
pip3 install neovim --user
pip install neovim --user
yum -y install tree
yum -y install zsh
yum -y install the_silver_searcher

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

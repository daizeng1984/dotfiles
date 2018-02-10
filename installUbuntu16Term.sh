#!/usr/bin/bash
apt-get update

# Install only terminal app
apt-get -y install build-essential

# 3rd Party Repo 
# Install Elrepo based on official website, this might be changed
# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
# rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

apt-get -y install curl gcc g++ git ruby wget

# Install npm and nodejs
apt-get -y install nodejs npm

# Install python34 and pip3
apt-get -y install python3 python3-pip # --user for pip install
wget https://bootstrap.pypa.io/get-pip.py 
#python get-pip.py --user # Install pip, not well link in Centos, has to install via:
yum -y install python2-pip python34-pip
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
yum -y install fasd
yum -y install xsel
yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
yum -y install ripgrep
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x diff-so-fancy
mv diff-so-fancy /usr/bin/

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

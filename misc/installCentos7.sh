#!/usr/bin/bash
# Boostrap installing
# Install only terminal app
yum -y groupinstall 'Development Tools'

# Install EPEL
yum -y install epel-release

# Install some tools essential for myself
yum -y install curl gcc irb gcc-c++ git ruby
yum -y install wget tree zsh
yum -y install ntfs-3g

# autocomplete ignore case for bash
echo "set completion-ignore-case On" >> $HOME/.inputrc

# Install zsh to be default
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Download dotfiles necessary?
DOTFILES=.dotfiles
[ -d "$DOTFILES" ] && git clone https://github.com/daizeng1984/configuration.git $DOTFILES
# Create symlink
cd ~/DOTFILES && ./createSymlink.sh

# install Conda
source ./installConda.sh

# Misc
# fzf
# cd $HOME && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  && ~/.fzf/install || true
# ranger
pip install ranger-fm
source $HOME/.dotfiles/ranger/configRanger.sh
# # Install gdrive
# wget https://docs.google.com/uc\?id\=0B3X9GlR6Embnb010SnpUV0s2ZkU\&export\=download -O /usr/local/bin/gdrive
# chmod +x /usr/local/bin/gdrive

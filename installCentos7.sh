#!/usr/bin/bash
# Install on minimal setup
yum -y groupinstall "X Window System"
yum -y groupinstall "GNOME Desktop"

# 3rd Party Repo 
# Install Elrepo based on official website, this might be changed
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
# So we could install kmod-nvidia after that
# yum install kmod-nvidia
# Install EPEL
yum -y install epel-release
# Install NUX desktop if you need app like audacious
yum -y install epel-release && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

# Install some tools essential for myself
yum -y install gvim
yum -y install ntfs-3g
yum -y install gcc gcc-c++ git
yum -y install tree
yum -y install wget

# install chrome
cd && mkdir Downloads && cd Downloads
chown -R $USER:$USER
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum -y --nogpgcheck localinstall google-chrome-stable_current_x86_64.rpm
cd

#install dropbox better from official website's RPM
#yum install nautilus-dropbox

#Forget about MS Office
#sh -c "printf '[playonlinux]\nname=PlayOnLinux Official repository\nbaseurl=http://rpm.playonlinux.com/fedora/yum/base\nenable=1\ngpgcheck=0\ngpgkey=http://rpm.playonlinux.com/public.gpg\n' > /etc/yum.repos.d/playonlinux.repo"
#yum install playonlinux

# autocomplete ignore case
echo "set completion-ignore-case On" >> $HOME/.inputrc

# Install zsh to be default
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# ZSH should do this by default
# chsh -s /usr/bin/zsh

# Download dotfiles necessary?
DOTFILES=.dotfiles
[ -d "$DOTFILES" ] && git clone https://github.com/daizeng1984/configuration.git $DOTFILES
# Create symlink
cd ~/DOTFILES && ./createSymlink.sh

# Reminde of removing alternateTab in gnome's /usr/share/gnome-shell/extensions
echo "don't forget to remove alternateTab in /usr/share/gnome-shell/extensions\n"

#reboot

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

# Install NUX desktop if you need app like audacious, autokey-gtk
yum -y install epel-release && rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install -y autokey audacious
source $HOME/.dotfiles/linux/configAutokey.sh

# install chrome to ~/Downloads
cd && mkdir Downloads && cd Downloads
chown -R $USER:$USER
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum -y --nogpgcheck localinstall google-chrome-stable_current_x86_64.rpm
cd

# Shutter taking screenshot
yum -y install shutter

#install dropbox better from official website's RPM
yum install -y nautilus-dropbox

# NTFS
yum -y install ntfs-3g

# # Install gdrive
# wget https://docs.google.com/uc\?id\=0B3X9GlR6Embnb010SnpUV0s2ZkU\&export\=download -O /usr/local/bin/gdrive
# chmod +x /usr/local/bin/gdrive

# Remind of removing alternateTab in gnome's /usr/share/gnome-shell/extensions
echo "don't forget to remove alternateTab in /usr/share/gnome-shell/extensions\ninstall extension https://github.com/HROMANO/nohotcorner/releases in gnome-tweak-tools!\n"

#reboot


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

# Install some tools essential for myself
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

# Reminde of removing alternateTab in gnome's /usr/share/gnome-shell/extensions
echo "don't forget to remove alternateTab in /usr/share/gnome-shell/extensions\n"

#reboot


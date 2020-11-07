#!/usr/bin/bash
# Install nvidia card
yum -y install epel-release
yum -y install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
yum update
yum -y install kmod-nvidia

# wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
# yum -y --nogpgcheck localinstall google-chrome-stable_current_x86_64.rpm

localectl set-x11-keymap us pc105 '' caps:escape

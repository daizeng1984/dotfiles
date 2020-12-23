#!/usr/bin/env bash
# Install nvidia card
# dnf -y install epel-release
# dnf -y install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
# dnf update
# dnf -y install kmod-nvidia

# nuke capslock once for all!
localectl set-x11-keymap us pc105 '' caps:escape

source $HOME/.dotfiles/linux/installLinuxDesktop.sh

# login dpi
#cp $HOME/.dotfiles/misc/93_hidpi.gschema.override /usr/share/glib-2.0/schemas/
#sudo glib-compile-schemas /usr/share/glib-2.0/schemas

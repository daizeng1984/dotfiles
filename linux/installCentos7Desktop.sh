#!/usr/bin/bash
# Install nvidia card
yum -y install epel-release
yum -y install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
yum update
yum -y install kmod-nvidia

# nuke capslock once for all!
localectl set-x11-keymap us pc105 '' caps:escape

# disable hot corner!
gsettings set org.gnome.desktop.interface enable-hot-corners false

# urxvt
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'urxvt'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'urxvt'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

# set the ctrl+alt+d
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Primary><Alt>d']"

# input method
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Primary>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Primary><Shift>space']"


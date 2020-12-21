#!/usr/bin/bash
# Install nvidia card
# dnf -y install epel-release
# dnf -y install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
# dnf update
# dnf -y install kmod-nvidia

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

# generate autokey scripts
python3 $HOME/.dotfiles/linux/configAutokey.py

# login dpi
#cp $HOME/.dotfiles/misc/93_hidpi.gschema.override /usr/share/glib-2.0/schemas/
#sudo glib-compile-schemas /usr/share/glib-2.0/schemas

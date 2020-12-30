# gnome (TODO: nix it)
# night light https://askubuntu.com/questions/1088650/gnome-night-light-setting-from-the-command-line
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

# disable hot corner!
gsettings set org.gnome.desktop.interface enable-hot-corners false

# urxvt
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'urxvt'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'urxvt -e zsh'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

# set the ctrl+alt+d
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Primary><Alt>d']"

# input method
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Primary>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Primary><Shift>space']"

# generate autokey scripts
python3 $HOME/.dotfiles/linux/configAutokey.py

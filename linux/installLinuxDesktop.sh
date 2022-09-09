# gnome
# get keys: gsettings list-keys org.gnome.desktop.wm.keybindings

# night light https://askubuntu.com/questions/1088650/gnome-night-light-setting-from-the-command-line
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

# disable hot corner! (no need in popos)
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Total customization keys
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# # urxvt
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'urxvt'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'urxvt -e zsh'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

# Sound
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Sound'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-control-center sound'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>s'

# # set the ctrl+alt+d
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>o']"

# screenshot
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Primary><Shift><Alt>4']"

# # input method
# gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Super>space']"
# gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Super><Shift>space']"

# Install keyd related
_PWD=$(pwd)
cd /tmp/
rm -rf /tmp/keyd
git clone https://github.com/rvaiya/keyd
cd keyd
git checkout v2.4.0
sudo make uninstall && make && sudo make install
mkdir -p /etc/keyd/
sudo cp $DOTFILES_HOME/misc/keyd.conf /etc/keyd/default.conf
sudo systemctl enable keyd && sudo systemctl start keyd

cd $_PWD

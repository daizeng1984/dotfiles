# brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# gnome
# get keys: gsettings list-keys org.gnome.desktop.wm.keybindings
# or more details https://askubuntu.com/questions/196896/how-to-read-default-key-value-with-dconf-or-gsettings
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
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking-global "[]"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>s']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Sound'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-control-center sound'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>c'

# # set the windows max/left/right
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "[]"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>o']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>comma']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>period']"

# screenshot
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Primary><Shift><Alt>4']"

# # input method
# gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Super>space']"
# gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Super><Shift>space']"
# install tlp tlpui
# gsettings set com.system76.hidpi enable false
installedApt=$(checkIfInstalled "apt" "" --quiet)
if [ "$installedApt" = "1" ] ; then
    # ubuntu
    sudo apt install -y meson libinput-devel ninja libudev-devel
else
    # fedora
    # build essential
    sudo dnf install -y make automake gcc gcc-c++ kernel-devel
    sudo dnf install -y meson libinput-devel ninja-build libudev-devel

    # ffmpeg
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing
    sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
    sudo dnf -y groupupdate sound-and-video

    # surface amd
    sudo dnf -y swap mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf -y swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    sudo dnf -y swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
    sudo dnf -y swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
fi


# Install keyd related
_PWD=$(pwd)
cd /tmp/
rm -rf /tmp/keyd
git clone https://github.com/rvaiya/keyd
cd keyd
git checkout v2.4.3
sudo make uninstall && make && sudo make install
mkdir -p /etc/keyd/
sudo cp $DOTFILES_HOME/misc/keyd.conf /etc/keyd/default.conf
sudo systemctl enable keyd && sudo systemctl restart keyd

# install libinput-config to reduce the shitty scrolling speed
cd /tmp/
rm -rf /tmp/libinput-config
git clone https://gitlab.com/warningnonpotablewater/libinput-config.git
cd libinput-config
meson build
cd build
ninja
sudo ninja install
echo "scroll-factor=0.175" | sudo tee /etc/libinput.conf
# Fix firefox's smooth scrolling
echo export MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh

cd $_PWD

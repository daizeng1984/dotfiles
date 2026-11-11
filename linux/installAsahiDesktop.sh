# brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Let's use KDE
# fedora
# build essential
sudo dnf install -y make 
sudo dnf install -y automake
sudo dnf install -y gcc
sudo dnf install -y gcc-c++ 
sudo dnf install -y kernel-devel
sudo dnf install -y libinput-devel
sudo dnf install -y libudev-devel
sudo dnf install -y git
# my blog deps
sudo dnf install -y libpng-devel
# app
sudo dnf install -y alacritty
sudo dnf install -y clang
sudo dnf install -y wl-clipboard
# sudo dnf install -y expat-devel


# Install keyd related
_PWD=$(pwd)
cd /tmp/
rm -rf /tmp/keyd
git clone https://github.com/rvaiya/keyd
cd keyd
git checkout v2.5.0
sudo make uninstall && make && sudo make install
mkdir -p /etc/keyd/
sudo cp $DOTFILES_HOME/misc/keyd.conf /etc/keyd/default.conf
sudo systemctl enable keyd && sudo systemctl restart keyd

# install libinput-config to reduce the shitty scrolling speed
# cd /tmp/
# rm -rf /tmp/libinput-config
# git clone https://gitlab.com/warningnonpotablewater/libinput-config.git
# cd libinput-config
# meson build
# cd build
# ninja
# sudo ninja install
# echo "scroll-factor=0.175" | sudo tee /etc/libinput.conf
# # Fix firefox's smooth scrolling
# echo export MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh

# install dotool
# cd /tmp/
# rm -rf /tmp/dotool
# git clone https://git.sr.ht/\~geb/dotool
# cd dotool
# sudo ./install.sh

# cd $_PWD

# gpg
# mkdir -p ~/.gnupg/
# # to restart gpg-agent gpgconf --kill gpg-agent and then --launch it
# echo "pinentry-program $(which pinentry-qt6)" | tee ~/.gnupg/gpg-agent.conf
# mkdir -p ~/.gnupg/
# gpgconf --kill gpg-agent
# gpgconf --launch gpg-agent

# install font
cd /tmp
curl -L  https://github.com/canonical/Ubuntu-Sans-Mono-fonts/releases/download/v1.006/UbuntuSansMono-fonts-1.006.zip -o UbuntuMono-fonts-fonts.zip
unzip UbuntuMono-fonts-fonts.zip
sudo cp -rvf UbuntuSansMono-fonts-1.006 /usr/share/fonts/
fc-cache -fv

# solve the palm rejection issue on big touchpad
cd /tmp
sudo dnf install -y gcc14
sudo dnf install -y gcc14-c++
git clone https://github.com/tascvh/trackpad-is-too-damn-big.git
cd trackpad-is-too-damn-big
git submodule init
git submodule update
mkdir build
cd build
CC=/usr/bin/gcc-14 CXX=/usr/bin/g++-14 cmake ..
make
sudo cp ./titdb /usr/bin
sudo cp $DOTFILES_HOME/misc/titdb.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now titdb

# disable-while-typing: keyd grabs the real keyboard and re-emits via "keyd virtual keyboard",
# which libinput doesn't treat as internal, so the touchpad never pauses while typing.
# Mark it internal so libinput pairs it with the trackpad. Takes effect after re-login.
sudo mkdir -p /etc/libinput
sudo tee /etc/libinput/local-overrides.quirks > /dev/null <<'EOF'
[keyd virtual keyboard]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF

# instlal app
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 
# wechat: official arm64 AppImage sandboxed by firejail (not flatpak)
# --private makes ~/Downloads/wechat the sandbox $HOME, so wechat only sees that folder
# (chat data lands in ~/Downloads/wechat/xwechat_files; drop files there to send them)
sudo dnf install -y firejail
WECHAT_APPIMAGE=$HOME/Downloads/WeChatLinux_arm64.AppImage
WECHAT_HOME=$HOME/Downloads/wechat
mkdir -p $WECHAT_HOME
if [ ! -f $WECHAT_APPIMAGE ]; then
    # official download page: https://linux.weixin.qq.com
    curl -fL -o $WECHAT_APPIMAGE https://dldir1v2.qq.com/weixin/Universal/Linux/WeChatLinux_arm64.AppImage
fi
chmod +x $WECHAT_APPIMAGE
if [ ! -f $WECHAT_HOME/wechat.png ]; then
    (cd $(mktemp -d) && $WECHAT_APPIMAGE --appimage-extract wechat.png >/dev/null && cp squashfs-root/wechat.png $WECHAT_HOME/)
fi
mkdir -p ~/.local/share/applications
cp $DOTFILES_HOME/linux/wechat.desktop ~/.local/share/applications/wechat.desktop
update-desktop-database ~/.local/share/applications
kbuildsycoca6  # KDE caches Exec lines; without this the menu keeps launching the old command
# NO SCREENSHOTS for wechat. firejail's default profile leaves session D-Bus wide open, so the
# desktop entry uses --dbus-user=filter: only notifications, tray (SNI; 4 is wechat's pid inside
# the firejail pid namespace) and fcitx5 are allowed; org.freedesktop.portal.Desktop
# (screenshot/screencast portal) and org.freedesktop.systemd1 (sandbox escape) are unreachable.
# Belt and braces: also deny the screenshot portal for the "wechat" app id (from wechat.desktop).
# To debug what it tries to reach: add --dbus-user.log --dbus-log=/tmp/wechat-dbus.log
flatpak permission-set screenshot screenshot wechat no
# X11 has no isolation: wechat shares the single XWayland server, so it can still see other X11
# windows (Steam, wine, games). Clipboard: KWin only hands the clipboard to XWayland while an X11
# window is focused, so wechat can't read it while you're in Wayland apps, but can whenever wechat
# or any other X11 window (Steam...) is active. Kept on purpose: wechat is unusable without
# clipboard (--x11=xephyr would isolate it). At least don't forward Wayland keystrokes to X11 apps.
# Same as App Permissions > Legacy X11 App Support > "Never".
kwriteconfig6 --file kwinrc --group Xwayland --key XwaylandEavesdrops None
# HiDPI: wechat is X11-only (statically linked Qt xcb, no wayland), so let XWayland apps scale
# themselves, otherwise KWin upscales a 1x bitmap and it's blurry. Don't set QT_SCALE_FACTOR on
# top of this or it double-scales. Same as Display > Legacy X11 apps > "Apply scaling themselves".
kwriteconfig6 --file kdeglobals --group KScreen --key XwaylandClientsScale true
sudo dnf install -y fcitx5 
sudo dnf install -y fcitx5-autostart 
sudo dnf install -y fcitx5-configtool 
sudo dnf install -y fcitx5-chinese-addons 
sudo dnf install -y fcitx5-gtk 
sudo dnf install -y fcitx5-qt 
sudo dnf install -y fcitx5-qt-module 
# add pinyin input and make sure to set virtual keyboard in KDE system/keyboard settings to allow pinyin input in alacritty terminal
# word db download sougou.dict from https://github.com/blackteahamburger/fcitx6-pinyin-sougou-dict/releases
# then: mkdir -p ~/.local/share/fcitx5/pinyin/dictionaries/ && mv ~/Downloads/sougou.dict ~/.local/share/fcitx5/pinyin/dictionaries/
sudo dnf install -y fcitx5-rime
sudo dnf install -y librime-lua
sudo dnf install -y kcm-fcitx5
sudo dnf install -y pdftk
sudo dnf install -y fuse-sshfs
sudo dnf install -y wkhtmltopdf
# OCR
# if not in KDE, to install: flatpak install flathub com.github.tenderowl.frog
sudo dnf install -y tesseract
sudo dnf install -y tesseract-langpack-eng
sudo dnf install -y tesseract-langpack-chi_tra
sudo dnf install -y tesseract-langpack-chi_sim
sudo dnf install -y tesseract-langpack-jpn

# rime + rime-ice (雾凇拼音), safe to re-run: keeps *.custom.yaml, user.yaml and *.userdb
RIME_DIR=~/.local/share/fcitx5/rime
mkdir -p $RIME_DIR
rm -rf /tmp/rime-ice
git clone --depth=1 https://github.com/iDvel/rime-ice /tmp/rime-ice
# upstream ships a prebuilt build/ that would shadow our *.custom.yaml patches, so skip it
# and drop the old build/ so rime recompiles everything on next deploy
(cd /tmp/rime-ice && tar --exclude=.git --exclude=./build -cf - .) | tar -xf - -C $RIME_DIR
rm -rf $RIME_DIR/build
ln -sf $DOTFILES_HOME/linux/rime/rime_ice.custom.yaml $RIME_DIR/rime_ice.custom.yaml
ln -sf $DOTFILES_HOME/linux/rime/default.custom.yaml $RIME_DIR/default.custom.yaml

# fcitx5 input method list: keyboard-us + rime (fcitx5 rewrites profile on exit, so stop it first)
pkill -x fcitx5; sleep 2
mkdir -p ~/.config/fcitx5
cat > ~/.config/fcitx5/profile <<'EOF'
[Groups/0]
Name=Default
Default Layout=us
DefaultIM=rime

[Groups/0/Items/0]
Name=keyboard-us
Layout=

[Groups/0/Items/1]
Name=rime
Layout=

[GroupOrder]
0=Default
EOF

# KDE Wayland: use fcitx5 as the virtual keyboard (System Settings -> Keyboard -> Virtual Keyboard)
kwriteconfig6 --file kwinrc --group Wayland --key InputMethod /usr/share/applications/fcitx5-wayland-launcher.desktop
kwriteconfig6 --file kwinrc --group Wayland --key VirtualKeyboardEnabled true
# XWayland apps: imsettings defaults to none (XMODIFIERS=@im=none), point it at fcitx5
mkdir -p ~/.config/imsettings ~/.config/environment.d
ln -sf /etc/X11/xinit/xinput.d/fcitx5.conf ~/.config/imsettings/xinputrc
echo "XMODIFIERS=@im=fcitx" > ~/.config/environment.d/fcitx5.conf
(setsid fcitx5 -d --replace >/dev/null 2>&1 &)
# relogin afterwards for env changes to take effect

# kitty
sudo dnf install -y kitty

# Install firefox nonfree video codec
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# uncheck [] meta key in system setings -> Shortcuts to disable launcher from meta key
# keyboard -> key bindings -> capslock to be disabled
# Legacy X11 App Support -> prohibit 
# bluetooth
sudo dnf install -y expect
cd /tmp
git clone https://github.com/christian-korneck/asahi-bt-a2dp-fix.git
cd asahi-bt-a2dp-fix
sudo ./install.sh

# Accessbility disable
for e in zoom magnifier invert mousemark trackmouse shakecursor; do
  qdbus-qt6 org.kde.KWin /Effects org.kde.kwin.Effects.unloadEffect $e
done

for e in zoom magnifier invert mousemark trackmouse shakecursor; do
  kwriteconfig6 --file kwinrc --group Plugins --key ${e}Enabled false
done
qdbus-qt6 org.kde.KWin /KWin reconfigure

kwriteconfig6 --file kaccessrc --group ScreenReader --key Enabled false
kwriteconfig6 --file kaccessrc --group Keyboard --key Gestures false
kwriteconfig6 --file kaccessrc --group Keyboard --key StickyKeys false
kwriteconfig6 --file kaccessrc --group Keyboard --key SlowKeys false
kwriteconfig6 --file kaccessrc --group Keyboard --key BounceKeys false
pkill kaccess; kaccess &

cd $_PWD

mamba install -y -c conda-forge rust
cargo install claude-history
cargo install tickrs
# tickrs tray popup (KDE): autostart the tray icon
# needs kitty (quick-access-terminal kitten), PyQt6 for system python, and tickrs
# itself (nix programs.nix or `cargo install tickrs`)
sudo dnf install -y kitty python3-pyqt6-base
mkdir -p ~/.config/autostart
ln -sf $DOTFILES_HOME/linux/tickrs-tray/tickrs-tray.desktop ~/.config/autostart/tickrs-tray.desktop

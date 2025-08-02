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
cd $_PWD

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

# instlal app
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 
# install wechat install flatseal



# my desktop stuff
brew install --cask wkhtmltopdf
brew install --cask karabiner-elements
brew install --cask vlc
brew install --cask firefox
brew install --cask flameshot
brew install --cask phoenix
brew install --cask iterm2
brew install --cask shifty
brew install --cask flux
brew install --cask cog #museeks
brew install --cask dropbox
brew install --cask kap
brew install --cask alacritty
brew install --cask orion # plugin: ublock origin, bitwarden
brew install --cask turbo-boost-switcher # intel mac power
brew install gnupg
brew install pinentry-mac
# gnupg
mkdir -p ~/.gnupg/
echo "pinentry-program $(which pinentry-mac)" | tee ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

#brew cask install gimp
#brew cask install xee
# brew cask install balenaetcher
# Has to manually config, it requires device_id
#source $HOME/.dotfiles/mac/configKarabiner.sh
source $HOME/.dotfiles/mac/configPhoenix.sh
cd $HOME
mkdir -p $HOME/Applications

# iterm2
mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles/"
ln -s $HOME/.dotfiles/mac/iterm2.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/iterm2.json"
# TODO: now import your terminal profile, and make sure it select the right font (e.g. Droid Sans Mono for Powerline)

# Enable showing hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES 
# Repeat keys
defaults write -g ApplePressAndHoldEnabled -bool false
cd $HOME

# cannot kill but at least you can make it quiet as below. Or manually disable spotlight: Settings -> Spotlight -> Privacy
sudo mdutil -d /Volumes/*
/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c \
  "Set AppleSymbolicHotKeys:64:enabled false"

# turbo-boost-switcher, save password typing each sleep. credit: https://github.com/rugarciap/Turbo-Boost-Switcher/issues/4#issuecomment-465734895
sudo cp ~/.dotfiles/mac/com.turbo-boost-switcher.plist /Library/LaunchDaemons
sudo chmod 600 /Library/LaunchDaemons/com.turbo-boost-switcher.plist
sudo launchctl unload /Library/LaunchDaemons/com.turbo-boost-switcher.plist
sudo launchctl load /Library/LaunchDaemons/com.turbo-boost-switcher.plist

# font
brew tap homebrew/cask-fonts && brew install --cask font-ubuntu-mono

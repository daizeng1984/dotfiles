# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# my desktop stuff
brew cask install phoenix
brew cask install karabiner-elements
brew cask install flux
brew cask install google-chrome
brew cask install vox
brew cask install vlc
brew cask install gimp
source $HOME/.dotfiles/mac/configKarabiner.sh
# Has to manually config, it requires device_id
# source $HOME/.dotfiles/mac/configPhoenix.sh

# powerline font
source $HOME/.dotfiles/misc/installPowerlineFont.sh

# TODO: now import your terminal profile, and make sure it select the right font (e.g. Droid Sans Mono for Powerline)

# my desktop stuff
#brew cask install wkhtmltopdf
#brew cask install karabiner-elements
#brew cask install vimr
#brew cask install vlc
#brew cask install gimp
#brew cask install xee
# brew cask install balenaetcher
# Has to manually config, it requires device_id
#source $HOME/.dotfiles/mac/configKarabiner.sh
source $HOME/.dotfiles/mac/configPhoenix.sh
cd $HOME

# iterm2
mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles/"
ln -s $HOME/.dotfiles/mac/iterm2.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/iterm2.json"
# TODO: now import your terminal profile, and make sure it select the right font (e.g. Droid Sans Mono for Powerline)

# Enable showing hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES 
# Repeat keys
defaults write -g ApplePressAndHoldEnabled -bool false
cd $HOME

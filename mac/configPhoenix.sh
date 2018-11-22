DOTFILES=$HOME/.dotfiles
#brew cask install phoenix
cd $HOME/.dotfiles/mac
git clone https://github.com/daizeng1984/phoenix-config.git phoenix-config
cd phoenix-config
git checkout experimental
d=$HOME/.phoenix.js
# TODO: These code appear again and again...
if [ -L $d ] ; then
    rm $d
else 
    if [ -e $d ]; then
        cp -rf $d $HOME/.dotfiles_old
        rm -rf $d
    fi
fi
ln -s $HOME/.dotfiles/mac/phoenix-config/phoenix.js $HOME/.phoenix.js

set +e
gem install android-sdk-installer --user -n .

INSTALL_DIR="$HOME/android"
install -d $INSTALL_DIR && cd $INSTALL_DIR
export ANDROID_HOME=$INSTALL_DIR/android-sdk

# Get system name
SYSTEM_NAME=$(uname -s)
PLATFORM="linux"
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ] ; then
    PLATFORM="darwin"
    echo "find mac..."
else
    echo "use linux..."
fi


cp "$HOME/.dotfiles/android/android-sdk-installer.yml" .
"$HOME/.dotfiles/android/android-sdk-installer" -p $PLATFORM .

echo "Please add this to your path!: \n \
export ANDROID_HOME=\$HOME/android/android-sdk\n \
export PATH=\$ANDROID_HOME/platform-tools:\$PATH\n \
export PATH=\$ANDROID_HOME/tools:\$PATH"

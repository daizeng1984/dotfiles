gem install android-sdk-installer --user -n .

INSTALL_DIR="$HOME/.dotfiles/.local/lib/android"
mkdir -p $INSTALL_DIR
install -d $INSTALL_DIR && cd $INSTALL_DIR
ANDROID_HOME=$INSTALL_DIR/android-sdk

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

echo "Please add this to your path! e.g.: \n \
export ANDROID_HOME=${ANDROID_HOME}\n \
export ANDROID_NDK=${ANDROID_HOME}/ndk-bundle/your-ndk-version\n \
export ANDROID_SDK=${ANDROID_HOME}\n \
export PATH=\$ANDROID_HOME/platform-tools:\$PATH\n \
export PATH=\$ANDROID_HOME/tools:\$ANDROID_HOME/tools/bin:\$PATH\n \
"

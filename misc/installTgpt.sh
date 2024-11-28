if [ -n $DOTFILE_LOCAL_PREFIX ] ; then
    curl -sSL https://raw.githubusercontent.com/aandrew-me/tgpt/main/install | bash -s $DOTFILE_LOCAL_PREFIX/bin
fi

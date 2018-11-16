PLATFORM="Linux"
SYSTEM_NAME=$(uname -s)
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" == "Darwin" ]; then
	echo "Find MacOSX..."
    PLATFORM="MacOSX"
else
    echo "Must be Linux System..."
fi
SCRIPT_NAME="Miniconda3-latest-${PLATFORM}-x86_64.sh"
RETURN_DIR=$(pwd)
cd /tmp
wget "https://repo.anaconda.com/miniconda/${SCRIPT_NAME}"
bash ./${SCRIPT_NAME} -b -p $HOME/.dotfiles/.local/lib/miniconda
rm ./${SCRIPT_NAME}
cd $RETURN_DIR

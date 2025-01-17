PLATFORM="Linux"
SYSTEM_NAME=$(uname -s)
ARCH=$(uname -m)
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ]; then
	echo "Find MacOSX..."
    PLATFORM="MacOSX"
elif [ "$(echo $SYSTEM_NAME | cut -c 1-5)" = "MINGW" ]; then
    echo "Find Windows..."
    PLATFORM="Windows"
else
    echo "Must be Linux System..."
fi

if [ "$PLATFORM" = "Windows" ]; then
    echo "Trying scoop to install..."
    scoop install mambaforge
else
SCRIPT_NAME="Miniforge3-${PLATFORM}-${ARCH}.sh"
RETURN_DIR=$(pwd)
cd /tmp
curl -L "https://github.com/conda-forge/miniforge/releases/latest/download/${SCRIPT_NAME}" -o ${SCRIPT_NAME}
bash ./${SCRIPT_NAME} -b -u -p $HOME/.dotfiles/.local/lib/miniconda
rm -rf ./${SCRIPT_NAME}
cd $RETURN_DIR

source $HOME/.bashrc
# Add the best channel over defaults TODO: .condarc
conda config --add channels conda-forge
fi

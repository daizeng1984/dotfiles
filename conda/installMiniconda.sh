PLATFORM="Linux"
SYSTEM_NAME=$(uname -s)
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
    scoop install miniconda3
    # try, if not manually install
    powershell 'conda install -y mamba'
else
SCRIPT_NAME="Miniconda3-latest-${PLATFORM}-x86_64.sh"
RETURN_DIR=$(pwd)
cd /tmp
curl "https://repo.anaconda.com/miniconda/${SCRIPT_NAME}" -o ${SCRIPT_NAME}
bash ./${SCRIPT_NAME} -b -u -p $HOME/.dotfiles/.local/lib/miniconda
rm -rf ./${SCRIPT_NAME}
cd $RETURN_DIR

source $HOME/.bashrc
# Create default python environment
# ping to 3.7 so that we could conda install -c daizeng1984 nvim
conda install -y python=3.7
# Add the best channel over defaults TODO: .condarc
conda config --add channels conda-forge
fi

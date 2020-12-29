PLATFORM="Linux"
SYSTEM_NAME=$(uname -s)
if [ "$(echo $SYSTEM_NAME | cut -c 1-6)" = "Darwin" ]; then
	echo "Find MacOSX..."
    PLATFORM="MacOSX"
else
    echo "Must be Linux System..."
fi
SCRIPT_NAME="Miniconda3-latest-${PLATFORM}-x86_64.sh"
RETURN_DIR=$(pwd)
cd /tmp
curl "https://repo.anaconda.com/miniconda/${SCRIPT_NAME}" -o ${SCRIPT_NAME}
bash ./${SCRIPT_NAME} -b -u -p $HOME/.dotfiles/.local/lib/miniconda
rm -rf ./${SCRIPT_NAME}
cd $RETURN_DIR

source $HOME/.bashrc
# Create default python environment
#conda install -y python=3.6
# Add the best channel over defaults TODO: .condarc
conda config --add channels conda-forge

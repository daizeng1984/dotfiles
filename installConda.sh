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
wget -O "https://repo.anaconda.com/miniconda/${SCRIPT_NAME}"
bash ./${SCRIPT_NAME} -b -p $HOME/.dotfiles/.local/lib/miniconda
rm -rf ./${SCRIPT_NAME}
cd $RETURN_DIR

# Create default python environment
#conda install -y python=3.6

# Basic build setup
conda install -y -c conda-forge cmake
conda install -y -c conda-forge clangdev

# Vim
conda install -y -c conda-forge neovim
conda install -y -c daizeng1984 nvim
source $HOME/.dotfiles/neovim/configNeovim.sh

# Nodejs
conda install -y -c conda-forge nodejs

# Jdk
conda install -y -c conda-forge openjdk

# Tmux
conda install -y -c conda-forge tmux
# Fix https://github.com/conda-forge/tmux-feedstock/issues/12
conda install -y -c conda-forge ncurses

# Misc
conda install -y -c conda-forge rsync
conda install -y -c anaconda ripgrep
conda install -y -c anaconda the_silver_searcher
conda install -y -c antoined xsel
conda install -y -c daizeng1984 fasd

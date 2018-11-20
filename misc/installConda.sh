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

# Create default python environment
conda install python=3.6

# Basic build setup
conda install -c conda-forge cmake
conda install -c conda-forge clangdev

# Vim
conda install -c conda-forge neovim
conda install -c daizeng1984 nvim
source $HOME/.dotfiles/neovim/configNeovim.sh

# Nodejs
conda install -c conda-forge nodejs

# Tmux
conda install -c conda-forge tmux

# Misc
conda install -c anaconda ripgrep
conda install -c anaconda the_silver_searcher
conda install -c daizeng1984 fasd
conda install -c antoined xsel

# fzf
cd $HOME && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  && ~/.fzf/install || true

# ranger
pip install ranger-fm
source $HOME/.dotfiles/ranger/configRanger.sh

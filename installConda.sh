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
wget -N "https://repo.anaconda.com/miniconda/${SCRIPT_NAME}"
bash ./${SCRIPT_NAME} -b -p $HOME/.dotfiles/.local/lib/miniconda
rm -rf ./${SCRIPT_NAME}
cd $RETURN_DIR

# Create default python environment
#conda install -y python=3.6
# Add the best channel over defaults TODO: .condarc
conda config --add channels conda-forge

# Now conda charge!
# Basic build setup
conda install -y -c conda-forge cmake
conda install -y -c conda-forge clangdev

# Vim
conda install -y -c conda-forge neovim
conda install -y -c daizeng1984 nvim

# Nodejs
conda install -y -c conda-forge nodejs

# Jdk
conda install -y -c conda-forge openjdk

# ruby
conda install -y -c conda-forge ruby

# Tmux
conda install -y -c conda-forge tmux
# Fix https://github.com/conda-forge/tmux-feedstock/issues/12
conda install -y -c conda-forge ncurses

# Misc
conda install -y -c conda-forge rsync
conda install -y -c conda-forge trash-cli
conda install -y -c anaconda ripgrep
conda install -y -c anaconda the_silver_searcher
conda install -y -c antoined xsel
conda install -y -c daizeng1984 fasd
conda install -y -c daizeng1984 fd-find
conda install -y -c bioconda grep # make sure we have organic grep on mac
conda install -y -c conda-forge patool

# TODO: separate Non-conda
# Vim/tmux
source $HOME/.dotfiles/neovim/configNeovim.sh
source $HOME/.dotfiles/tmux/configTmux.sh
# fzf TODO: move this into .dotfiles/.local/bin
cd $HOME && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  && ~/.fzf/install --no-update-rc
# ranger
pip install ranger-fm
source $HOME/.dotfiles/ranger/configRanger.sh
# autocomplete ignore case for bash
echo "set completion-ignore-case On" >> $HOME/.inputrc

# Install zsh to be default
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

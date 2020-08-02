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

# pandoc
conda install -y -c conda-forge pandoc
# Suggest install system dependent (brew install gpg or yum install gnupg)
# conda install -y -c conda-forge gnupg

# Vim
conda install -y -c conda-forge neovim
conda install -y -c daizeng1984 nvim

# Nodejs
conda install -y -c conda-forge nodejs

# Boostrap java
conda install -y -c daizeng1984 sdkman

# C++
conda install -y -c conda-forge conan
conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
conda install -y -c daizeng1984 ccls

# ruby
# native lib via bundler always requires lib path from conda, not friendly at all
# has to use system ruby
# conda install -y -c conda-forge ruby

# Web tools
conda install -y -c conda-forge httpie

# Tmux
conda install -y -c conda-forge tmux
# Fix https://github.com/conda-forge/tmux-feedstock/issues/12
conda install -y -c conda-forge ncurses

# Misc
conda install -y -c conda-forge fzf
# TODO: fzf recipe is not complete
mkdir -p $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin
wget https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim -P $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin

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
# TODO: anaconda ranger
pip install ranger-fm
source $HOME/.dotfiles/ranger/configRanger.sh
# TODO: backup 
# autocomplete ignore case for bash
# echo "set completion-ignore-case On" >> $HOME/.inputrc

# Install zsh (requires git TODO)
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
# TODO: duplicate and check oh-my-zsh install options
# add all symlink file
source $HOME/.dotfiles/createSymlink.sh

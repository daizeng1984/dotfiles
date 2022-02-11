#!/bin/bash
# Install miniconda
source ./conda/installMiniconda.sh
# Now we do minimal setup
# Nodejs
# conda install -y -c conda-forge nodejs
# conda install -y -c conda-forge yarn

# Boostrap java, consider using nix
# conda install -y -c daizeng1984 sdkman

# C++, use nix please
# conda install -y -c conda-forge cmake
# conda install -y -c conda-forge clangdev
# conda install -y -c conda-forge conan
# conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
# conda install -y -c daizeng1984 ccls

# ruby, use nix please
# native lib via bundler always requires lib path from conda, not friendly at all
# has to use system ruby
# conda install -y -c conda-forge ruby
# Mamba
conda install -y -c conda-forge mamba

# Tools
conda install -y -c conda-forge wget
conda install -y -c conda-forge coreutils
conda install -y -c conda-forge findutils
conda install -y -c conda-forge git
conda install -y -c conda-forge zsh
conda install -y -c conda-forge direnv
# conda install -y -c conda-forge neovim
# conda install -y -c daizeng1984 nvim
conda install -y -c conda-forge tmux
conda install -y -c conda-forge vim
# Fix https://github.com/conda-forge/tmux-feedstock/issues/12
conda install -y -c conda-forge ncurses
# Misc
conda install -y -c conda-forge fzf
# TODO: fzf recipe is not complete
mkdir -p $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin
wget https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim -P $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin
conda install -y -c conda-forge rsync
conda install -y -c conda-forge trash-cli
conda install -y -c conda-forge ripgrep
conda install -y -c conda-forge the_silver_searcher
conda install -y -c conda-forge jq
conda install -y -c antoined xsel
conda install -y -c conda-forge zoxide
conda install -y -c conda-forge fd-find
conda install -y -c bioconda grep # make sure we have organic grep on mac
conda install -y -c conda-forge patool
conda install -y -c conda-forge ranger-fm
conda install -y -c conda-forge exa
conda install -y -c conda-forge bat
conda install -y -c conda-forge broot
conda install -y -c conda-forge httpie
conda install -y -c conda-forge htop
conda install -y -c conda-forge pandoc

# Configs
source $HOME/.dotfiles/neovim/configNeovim.sh

source $HOME/.dotfiles/tmux/configTmux.sh

git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

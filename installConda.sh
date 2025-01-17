#!/bin/bash
# Install miniconda
source ./conda/installMiniconda.sh
# Boostrap java, consider using nix
# conda install -y -c --no-update-deps daizeng1984 sdkman

# C++, use nix please
# conda install -y -c conda-forge cmake
# conda install -y -c conda-forge clangdev
# conda install -y -c conda-forge conan
# conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
# conda install -y -c --no-update-deps daizeng1984 ccls

# ruby, use nix please
# native lib via bundler always requires lib path from conda, not friendly at all
# has to use system ruby
# conda install -y -c conda-forge ruby
# Mamba
source "$DOTFILE_LOCAL_PREFIX/lib/miniconda/etc/profile.d/mamba.sh"
mamba install -y -n base -c conda-forge conda-libmamba-solver
conda config --set solver libmamba

# Now we do minimal setup
# Nodejs
mamba install -y -c conda-forge nvim
mamba install -y -c conda-forge nodejs
mamba install -y -c conda-forge yarn

# Tools
mamba install -y -c conda-forge wget
mamba install -y -c conda-forge coreutils
mamba install -y -c conda-forge tar
mamba install -y -c conda-forge tree
mamba install -y -c conda-forge sed # organic sed
mamba install -y -c conda-forge findutils
mamba install -y -c conda-forge git
mamba install -y -c conda-forge git-lfs
git lfs install
mamba install -y -c conda-forge zsh
mamba install -y -c conda-forge direnv
mamba install -y -c conda-forge neovim
mamba install -y -c conda-forge tmux
mamba install -y -c conda-forge vim
# Fix https://github.com/conda-forge/tmux-feedstock/issues/12
mamba install -y -c conda-forge ncurses
# Misc
mamba install -y -c conda-forge fzf
mamba install -y -c conda-forge rsync
mamba install -y -c conda-forge trash-cli
mamba install -y -c conda-forge ripgrep
mamba install -y -c conda-forge the_silver_searcher
mamba install -y -c conda-forge jq
mamba install -y -c conda-forge zoxide
mamba install -y -c conda-forge fd-find
mamba install -y -c conda-forge patool
mamba install -y -c conda-forge ranger-fm
mamba install -y -c conda-forge exa
mamba install -y -c conda-forge bat
mamba install -y -c conda-forge broot
mamba install -y -c conda-forge httpie
mamba install -y -c conda-forge htop
mamba install -y -c conda-forge pandoc

# install dtrx
pip install -y dtrx
mamba install -y -c conda-forge unzip
mamba install -y -c conda-forge unrar
mamba install -y -c conda-forge p7zip

# Configs
source $HOME/.dotfiles/minimal.sh

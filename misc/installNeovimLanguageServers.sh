#!/bin/bash

# Install to dotfiles' local install folder

# Install jdtls
cd $HOME/.dotfiles
mkdir -p ./.local/lib/jdt-language-server
cd ./.local/lib/jdt-language-server

# TODO: choose version you like in page http://download.eclipse.org/jdtls
wget http://download.eclipse.org/jdtls/milestones/0.27.0/jdt-language-server-0.27.0-201810230512.tar.gz
tar -zxvf jdt-language-server-0.27.0-201810230512.tar.gz


# Install pyls, TODO: locally?
# cd $HOME/.dotfiles
mkdir -p ./.local/lib/python-language-server
cd ./.local/lib/python-language-server
PYTHONUSERBASE=$(pwd) pip3 install 'python-language-server[all]' --user
# TODO: conda install -y -c conda-forge python-language-server


# Install js/ts
cd $HOME/.dotfiles
mkdir -p ./.local/lib/js-language-server
cd ./.local/lib/js-language-server

npm install javascript-typescript-langserver
# ln -s $HOME/.dotfiles/.local/lib/js-language-server/node_modules/.bin/javascript-typescript-langserver $HOME/.dotfiles/.local/bin/javascript-typescript-langserver

# Install bash
cd $HOME/.dotfiles
mkdir -p ./.local/lib/bash-language-server
cd ./.local/lib/bash-language-server
npm install bash-language-server

# Install grammar check
# cd $HOME/.dotfiles
# mkdir -p ./.local/lib/
# cd ./.local/lib/
# git clone https://github.com/languagetool-language-server/languagetool-languageserver.git
# cd languagetool-languageserver
# gradle installDist

# # Install cquery
# cd $HOME/.dotfiles
# mkdir -p ./.local/lib
# cd $HOME/.dotfiles/.local/lib
# git clone --recursive https://github.com/cquery-project/cquery.git
# cd cquery
# mkdir build && cd build
# cmake .. -GNinja  -DCMAKE_MAKE_PROGRAM=$HOME/.dotfiles/.local/lib/ninja/ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME/.dotfiles/.local/ -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
# ninja

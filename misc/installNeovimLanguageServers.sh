#!/bin/bash

# Install to dotfiles' local install folder

# Install jdtls
cd $HOME/.dotfiles
mkdir -p ./.local/lib/jdt-language-server
cd ./.local/lib/jdt-language-server

# TODO: choose version you like
wget http://download.eclipse.org/jdtls/milestones/0.27.0/jdt-language-server-0.27.0-201810230512.tar.gz
tar -zxvf jdt-language-server-0.27.0-201810230512.tar.gz


# Install pyls, TODO: locally?
cd $HOME/.dotfiles
mkdir -p ./.local/lib/python-language-server
cd ./.local/lib/python-language-server
PYTHONUSERBASE=$(pwd) pip3 install python-language-server --user


# Install js/ts
cd $HOME/.dotfiles
mkdir -p ./.local/lib/js-language-server
cd ./.local/lib/js-language-server

npm install javascript-typescript-langserver
# ln -s $HOME/.dotfiles/.local/lib/js-language-server/node_modules/.bin/javascript-typescript-langserver $HOME/.dotfiles/.local/bin/javascript-typescript-langserver

#!/bin/bash
cd
yum -y install vim-nox
yum -y install gcc
yum -y install make
yum -y install ncurses-devel
yum -y install readline-devel

#install lua
#yum -y install lua lua-devel
curl -R -O http://www.lua.org/ftp/lua-5.3.3.tar.gz
tar zxf lua-5.3.3.tar.gz
cd lua-5.3.3
make linux install
cd

#install vim with lua
git clone https://github.com/vim/vim.git vim
cd vim
./configure --enable-luainterp --with-features=huge --enable-fail-if-missing --with-lua-prefix=/usr/local
make && make install
cd
#rm -rf vim

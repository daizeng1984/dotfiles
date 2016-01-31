#centos
git clone https://github.com/vim/vim.git
sudo yum install -y ruby ruby-devel lua lua-devel luajit luajit-devel ctags mercurial python python-devel python3 python3-devel tcl-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed ncurses-devel
cd ./vim
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --with-tlib=ncurses --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim74
sudo make install
cd
#don't forget to run GoInstallBinaries in Vim
# on mac
# you just need to brew re/install vim --with-lua

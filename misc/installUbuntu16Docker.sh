# Install all dependencies
apt-get update && apt-get install -y \
      libtool-bin \
      autoconf \
      automake \
      cmake \
      libncurses5-dev\
      g++ \
      pkg-config \
      unzip \
      software-properties-common \
      zsh \
      ranger \ 
      less \
      tree \
      xsel \
      tmux \
      screen \
      silversearcher-ag \
      curl \
      wget \
      git 

# python:2.7
apt-get install -y python-pip \
        python-dev \
        && \
    pip2 --no-cache-dir install --upgrade \
        setuptools \
        pip \
        && \
    pip2 --no-cache-dir install --upgrade \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython


# python:3.6
add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update && \
    apt-get install -y \
        python3.6 \
        python3.6-dev \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    pip3 --no-cache-dir install --upgrade \
        setuptools \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython \
        && \
    rm ~/get-pip.py

# node
apt-get install -y npm && ln -s /usr/bin/nodejs /usr/bin/node

# rg
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb && \
    dpkg -i ripgrep_0.8.1_amd64.deb && \
    rm ripgrep_0.8.1_amd64.deb

# diff so fancy
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy && chmod +x diff-so-fancy && mv diff-so-fancy /usr/bin/

# fasd
git clone https://github.com/clvv/fasd.git /usr/local/fasd && ln -s /usr/local/fasd/fasd /usr/bin/fasd
# fzf
cd ~ && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  && ~/.fzf/install || true

# neovim
#RUN git clone https://github.com/neovim/neovim.git nvim && \
#        cd nvim && \
#        make && make install && \
#        cd ../ && rm -rf nvim
add-apt-repository ppa:neovim-ppa/stable && apt-get update && apt-get install -y neovim && pip3 install neovim && pip2 install neovim

# Oh-my-zsh
cd ~ && wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh && chmod +x install.sh && ./install.sh || true && rm ./install.sh

# Jupyter
pip3 install jupyter

# setup dotfiles
cd ~ && git clone https://github.com/daizeng1984/dotfiles .dotfiles && cd ~/.dotfiles && bash -c ./createSymlink.sh
# install neovim plugins
bash -c echo -ne '\n' | ~/.dotfiles/neovim/installNeoVim.sh || true 
bash -c echo -ne '\n' | nvim +UpdateRemotePlugins +qall || true
# TODO: here we need to chown

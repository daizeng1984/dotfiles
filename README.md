# Configuration
This configuration is my personal laptop/desktop configuration repo inspired by: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ and it's for myself to quickly setup commandline environment (mainly on Centos and Mac, there are some other OS' stuff too!).

# Before
Recommend to install:
1. zsh and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
2. ones who seek dark power should install [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) with python3 support (see also [here](https://github.com/daizeng1984/dotfiles/blob/master/installCentos7Term.sh#L32-L36)) for [deoplete](https://github.com/Shougo/deoplete.nvim#installation)

# Create symlink for all dotfiles
Simply do: cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh

# SSH
For bash, if you need to ssh pickup .bashrc when login, you need to enable the .bash_profile code

# Install Centos
sudo installCentos7(Term/Desktop).sh

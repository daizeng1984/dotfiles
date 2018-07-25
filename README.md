# Configuration
This configuration is my personal laptop/desktop configuration repo inspired by: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ and it's for myself to quickly setup commandline environment (mainly on Centos and Mac, there are some other OS' stuff too!).

# Before
If you cannot run `installCentos7Term.sh`
Recommend to install:
1. zsh and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
2. ones who seek dark power should install [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) with python3 support (see also [here](https://github.com/daizeng1984/dotfiles/blob/master/installCentos7Term.sh#L32-L36)) for [deoplete](https://github.com/Shougo/deoplete.nvim#installation)

But it's fine if you only want .dotfiles and make it work partially ("ssh style" e.g. if you only need bash and vi).

# Create symlink for all dotfiles
Simply do: `cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh`

In Windows  or some other cross-terminal environment that you cannot do symlink, you could do:
`cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh nosymlink`

# SSH
For bash, if you need ssh to pickup `.bashrc` when login, you need to enable the `.bash_profile` code

# Install On Centos (or RHEL)
To install everything including zsh, neovim etc. on Centos:
```{bash}
sudo installCentos7Term.sh
```

To install some of desktop apps I like:
```{bash}
sudo installCentos7Desktop.sh
```

# Install on Mac
Some notes:
1. Install JDK
2. Install python2 and python3 and make sure pip works and run both e.g. `pip3 install neovim`
3. run ./createSymlink.sh to link everything else
4. Install neovim and then run script ./neovim/installNeoVim.sh to do post installation
5. fzf doesn't have default command set so must do `brew install` the_silver_search as show in zsh startup script etc.
6. Install other missing parts and don't forget to do `:UpdateRemotePlugins` in neovim

# Install tmux
To make sure you have the right tmux flavor, check if the tmux is > 2.0 `tmux -V`, then in run `tmux/installTPM.sh` and `Prefix+I` to install plugin in tmux. On Centos, you need to disable gnome terminal's [F10 key bindings](https://ubuntu-tutorials.com/2007/07/16/disabling-the-f10-key-menu-accelerators-in-gnome-terminal/), disable Capslock in `TweakTool` and remap Capslock `xmodmap -e "keycode 66 = F10"`.

# Configuration
This configuration is my personal laptop/desktop setup repo inspired from: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ and now it grows into bootstrap setup for all my working environments (mainly linux/mac).

# Before
Recommend to install:
1. Basic development tools like git, wget, curl, bzip2. However, unless given a minimum installation, that shouldn't worry us too much cause most normal OS setup should already have it.
2. (optional) zsh and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

# Get Started
Simply do: `cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && bash ./createSymlink.sh && source ~/.bashrc && source ./installConda.sh`

In Windows (Cygwin/Babun) or some other non-*nix environments that have no symlink, you could do:
`cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh nosymlink`
But currently I'm not planning to support these troubling OS.

# After

## TODO: Desktop
### Centos
```{bash}
sudo source $HOME/.dotfiles/misc/installCentos7Desktop.sh
```
### Mac OS X
```{bash}
brew cask install phoenix
brew cask install karabiner
```

# Key Mapping

On Centos, you need to disable gnome terminal's [F10 key bindings](https://ubuntu-tutorials.com/2007/07/16/disabling-the-f10-key-menu-accelerators-in-gnome-terminal/), disable Capslock in `TweakTool` and remap Capslock `xmodmap -e "keycode 66 = F10"`.

# Install Language Support in Neovim
Just run `./misc/installNeovimLanguageServers.sh`

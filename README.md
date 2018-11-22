# Configuration
This configuration is my personal laptop/desktop setup repo originally inspired from: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ and now it grows into a bootstrap setup for my working environments (mainly linux/mac).

# Before
Basic development tools like git, wget, curl, bzip2 as [here](). However, unless given a minimum OS installation, that shouldn't worry us too much since most normal OS setup should already have them all.

# Get Started
Simply do: `cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && bash ./createSymlink.sh && source ~/.bashrc && source ./installConda.sh`

In Windows (Cygwin/Babun) or some other non-*nix environments that have no symlink, you could do:
`cd && git clone https://github.com/zedai1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh nosymlink`
But currently these troubling OS only has minimum support.

# After

## TODO: Desktop
### Centos
```{bash}
sudo source $HOME/.dotfiles/misc/installCentos7Desktop.sh
```

### Mac OS X
Install `brew` and do:
```{bash}
source $HOME/.dotfiles/mac/installMacDesktop.sh
```
## Key Mapping

On Linux, you need to disable gnome terminal's [F10 key bindings](https://ubuntu-tutorials.com/2007/07/16/disabling-the-f10-key-menu-accelerators-in-gnome-terminal/), disable Capslock in `TweakTool`.

## Better Vim
To install Language Support in Neovim run 

```{bash}
$HOME/.dotfiles/misc/installNeovimLanguageServers.sh`
```

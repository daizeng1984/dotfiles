# Configuration
This configuration is my personal laptop/desktop dotfile [setup](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) repo and now it grows into a bootstrap setup for my working environments (mainly linux/mac) and this bootstrap unlike [Laptop](https://github.com/thoughtbot/laptop), it heavily relies on nix/conda. Why? please see [here](https://daizeng1984.github.io/jekyll/update/2018/11/18/conda-everything.html).

There are 3 level of setup: Minimal, Conda & Nix.

# Minimal
This setup only provides dotfiles for `bash`/`zsh` and `vim`. 
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh
```
Then restart the shell

# Nix
This setup relies on Nix which is very powerful. The cost is for now: root permission. On Mac you need to run: `xcode-select --install` first to make sure basic cli e.g. git are available.
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ./installNix.sh
```
Because it's powerful, you don't need to do anything (TODO: kidding not yet 😄 unless you are in NixOS)

After that, you need to setup *.def files. For example, for mac, go to `var.def` file and put mapping for your `whoami` and `hostname` output:
```sh
__mapToDef '<your whoami output>' '<your hostname output>' 'macnix.def' 'homemac'
```
restart your terminal and run home-manager switch

## Linux
TODO:

## Mac
TODO:

# Conda (deprecated)
This setup heavily relies conda to deploy all packages needed. No root access is needed so unlike Nix X/Desktop app is done separately. Conda is managed in `~/.dotfiles/.local` folders. 
You need to have basic development tools like git, wget, curl, bzip2 (TODO: remove these dependencies). 

```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ~/.bashrc && source ./installConda.sh`
```
Before install on Mac, you need to do extra rampup manually like:
```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install wget
```

## Desktop
### Centos
```{bash}
sudo source $HOME/.dotfiles/misc/installCentos7Desktop.sh
```
### Mac OS X
```{bash}
source $HOME/.dotfiles/mac/installMacDesktop.sh
```
## Key Mapping
On Mac, use Karabiner-Element!
On Linux, first you need to disable gnome terminal's [F10 key bindings](https://ubuntu-tutorials.com/2007/07/16/disabling-the-f10-key-menu-accelerators-in-gnome-terminal/), and disable Capslock in `TweakTool` or `xmodmap -e 'clear Lock'`. Then remap capslock to F10 by installing xcape in your conda environment as `conda install -c daizeng1984 xcape`. In your startup script you should run `killall xcape` and then `xcape -e '#66=#76'`. 

# Different Profile
make sure you register a name to `samples/var.def` with username `$(whoami)` and hostname `$(hostname)`


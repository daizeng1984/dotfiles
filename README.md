# Configuration
This configuration is my personal laptop/desktop dotfile [setup](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) repo and now it grows into a bootstrap setup for my working environments (mainly linux/mac) and this bootstrap, unlike [Laptop](https://github.com/thoughtbot/laptop), heavily relies on nix/conda. Why? because of `linux more favor` and for more details please see [here](https://daizeng1984.github.io/2018-11-18-conda-everything) and [there](https://daizeng1984.github.io/2020-10-24-nix-power)

There are 3 level of setup: Minimal, Conda & Nix.

# Minimal
This setup only provides dotfiles for `bash`/`zsh` and `vim`. It aims for less intrusive and relies on remote ssh machine default setup. Right in this mode, bash, screen & vim is the only thing you get.
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh
```
Then restart the shell

## Windows
First install scoop to bootstrap in powershell:
```sh
Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr -useb get.scoop.sh | iex
scoop install sudo
scoop bucket add extras
scoop update
sudo scoop install git
scoop install wget
```

then go to git bash to run:
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ./minimal.sh
```


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
restart your terminal and run `home-manager switch`

## Linux
Basically, everything is taken care in home-manager switch if you pick CentOS/gnome or NixOS.

## Mac
You need to install some outliers that cannot install with Nix (note `brew cask` instead is able to do that though) but it's very necessary and I couldn't find Nix alternative.

For example, karabiner-element.

# Conda (no root)
This setup heavily relies conda to deploy all packages needed. No root access is needed so unlike Nix X/Desktop app is done separately. Conda is managed in `~/.dotfiles/.local` folders. 
You need to have basic development tools like git, wget, curl, bzip2 (TODO: remove these dependencies). The pros is: you can do whatever you want in your local kingdom just similar to after Nix installed. The cons is: you don't get much sandboxing protection (dependency version mismatching) and you cannot install desktop app. Therefore, a `brew cask` is recommended for this task.

```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ~/.bashrc && source ./installConda.sh
```

TODO: remove wget dependencies etc.
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

## Different Profile
Similar to Nix, make sure you register a name to `samples/var.def` with username `$(whoami)` and hostname `$(hostname)`. For example:
```sh
__mapToDef '<your whoami output>' '<your hostname output>' 'macconda.def' 'homemac'
```

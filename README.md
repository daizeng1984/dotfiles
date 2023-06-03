# Configuration
This configuration is my personal laptop/desktop dotfile [setup](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) repo and now it grows into a bootstrap setup for my working environments (mainly linux/mac) and this bootstrap, unlike [Laptop](https://github.com/thoughtbot/laptop), heavily relies on conda/nix. Why? because of `linux more flavor` and for more details please see [here](https://daizeng1984.github.io/2018-11-18-conda-everything) and [there](https://daizeng1984.github.io/2020-10-24-nix-power)

There are 3 level of setup: Minimal, Conda & Nix.

Minimal is just to setup basics of bashrc etc. and hopefully for vimrc as well; Conda is used to setup a nice (python, nodejs, etc.) CLI dev on linux/mac without desktop experience (mostly keybindings and desktop app); Nix is aiming for fully automation of CLI and desktop app install on \*nix (but outdated due to tremendous maintainence effort and Nix's flaky support on mac).

# Minimal
This setup only provides **dotfiles** for `bash`/`zsh` and good old `vim`. It aims for less intrusive and relies on remote ssh machine default setup. Right in this mode, bash, screen & vim is the only thing you get.
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh
```
Then restart the shell.

# Conda and Desktop App
This setup provides nicest CLI experience for myself and desktop as well. It heavily relies conda to deploy all packages needed. No root access is needed so unlike Nix X/Desktop app is done separately. Conda is managed in `~/.dotfiles/.local` folders. 

## Linux
Should be good out of box for most distros. Just need something providing: `git`, `curl` etc. If missing, try install package like `build-essential`.

```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ~/.bashrc && source ./installConda.sh
```

For desktop:
```sh
cd $HOME/.dotfiles/linux && source ./installLinuxDesktop.sh
```

TODO: manually install tweak tool to disable capslock key
TODO: install more desktop apps

## Mac
Run in Terminal:
```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install wget
```

Then just run:
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ~/.bashrc && source ./installConda.sh
```
For desktop:
```sh
cd $HOME/.dotfiles/mac && source ./installMacDesktop.sh
```
TODO: manually config the `Karabiner-Element` for keybindings...

## Windows (Limited)
First install scoop to bootstrap in powershell by running:
```sh
Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr -useb get.scoop.sh | iex
scoop install sudo
sudo scoop install git
scoop bucket add extras
scoop update
scoop install wget
```

Conda on Windows is quite limited and many app cannot run (due to path slash etc.). But it's better than nothing...
Just go to `git-bash` app to run:
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ./conda/installMiniconda.sh
```
For desktop:
```sh
cd ~/.dotfiles/windows
powershell -File ./installScoop.ps1
```

## Different Profile (Non-Windows)
This is to customize shell script for different machine etc.. Register a name to `samples/var.def` with username `$(whoami)` and hostname `$(hostname)` and then customize the scripts. For example:
```sh
__mapToDef '<your whoami output>' '<your hostname output>' 'macconda.def' 'homemac' 'reddust'
```
this would map current host and user to `macconda.def` scripts and `homemac` is for nix setup and should just leave it there. The `reddust` is to assign the tmux color theme.



<!---
# Nix (Deprecated, no time to maintain 😢)

This setup relies on Nix which is very powerful. The cost is for now: root permission. On Mac you need to run: `xcode-select --install` first to make sure basic cli e.g. git are available.
```sh
cd && git clone https://github.com/daizeng1984/dotfiles.git .dotfiles && cd .dotfiles && ./createSymlink.sh && source ./installNix.sh
```
Because it's powerful, you don't need to do anything (TODO: kidding not yet :D unless you are in NixOS)

After that, you need to setup *.def files. For example, for mac, go to `var.def` file and put mapping for your `whoami` and `hostname` output:
```sh
__mapToDef '<your whoami output>' '<your hostname output>' 'macnix.def' 'homemac'
```
restart your terminal and run `home-manager switch`

## Linux Desktop
Basically, everything is taken care in home-manager switch if you pick CentOS/gnome or NixOS.

## Mac Desktop
You need to install some outliers that cannot install with Nix (note `brew cask` instead is able to do that though) but it's very necessary and I couldn't find Nix alternative.

For example, karabiner-element.

```.sh
source $HOME/.dotfiles/mac/installMacDesktop.sh
```
--->



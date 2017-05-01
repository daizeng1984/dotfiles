# Configuration
This configuration is my personal laptop/desktop configuration repo inspired by: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ and it's for myself to quickly setup commandline environment (mainly on Centos and Mac, there are some other OS' stuff too!).

# Before
If you cannot run `installCentos7Term.sh`
Recommend to install:
1. zsh and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
2. ones who seek dark power should install [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim) with python3 support (see also [here](https://github.com/daizeng1984/dotfiles/blob/master/installCentos7Term.sh#L32-L36)) for [deoplete](https://github.com/Shougo/deoplete.nvim#installation)

But it's fine if you only want .dotfiles and make it work partially ("ssh style" like bash and vi).

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
# Install tmux
To make sure you have the right tmux flavor, check if the tmux is > 2.0 `tmux -V`, then in run `tmux/installTPM.sh` and `Prefix+I` to install plugin in tmux.

# TODOs
- [ ] Change old vim's FuzzyFinder to Fzf

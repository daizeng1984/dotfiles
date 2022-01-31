# minimal
{ config, lib, pkgs, ... }:
let
  stable = import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {};
  nobreakingNeovim = stable.neovim;
in
{
  home.packages = with pkgs; [
    gitSVN
    git-lfs # large file storage support
    gitAndTools.delta
    coreutils
    findutils
    zsh
    fzf
    direnv # how to setup nix-shell? https://nixos.org/guides/declarative-and-reproducible-developer-environments.html#declarative-reproducible-envs
    httpie
    nobreakingNeovim
    ag
    #fasd
    zoxide
    ripgrep
    gnugrep
    tree
    duf
    broot
    ranger
    du-dust
    tealdeer
    hyperfine
    grex
    trash-cli
    rsync
    fd
    exa
    bat
    htop
    miniserve
  ];
}

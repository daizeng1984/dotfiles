# CLI next gen
{ config, lib, pkgs, ... }:
let
  comma = import ( pkgs.fetchFromGitHub {
      owner = "Shopify";
      repo = "comma";
      rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
      sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
  }) {};
in
{
  home.packages = with pkgs; [
    git
    niv # manage nix deps
    zsh
    fzf
    neovim #TODO: separate program for some serious setup
    vim
    direnv # how to setup nix-shell? https://nixos.org/guides/declarative-and-reproducible-developer-environments.html#declarative-reproducible-envs
    httpie
    tmux
    tmuxp
    ag
    fasd
    #dtrx not supported on mac
    # gnupg TODO
    # pinentry
    ripgrep
    tree
    # ncdu
    broot
    ranger
    trash-cli
    rclone
    rsync
    fd
    exa
    comma
    bat
    htop
    navi
    tldr
    neofetch
    tokei
  ];
}

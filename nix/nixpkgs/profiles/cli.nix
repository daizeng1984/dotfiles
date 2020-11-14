# CLI next gen
{ config, lib, pkgs, ... }:
let
  comma = import ( pkgs.fetchFromGitHub {
      owner = "Shopify";
      repo = "comma";
      rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
      sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
  }) {};

  #scdl = pkgs.callPackage ../modules/scdl { };

  # Gnupg: ref to https://github.com/nix-community/home-manager/blob/master/modules/services/gpg-agent.nix
  # gpgInitStr = ''
  #   GPG_TTY="$(tty)"
  #   export GPG_TTY
  # '';
  pinentryFlavor = "curses";
      # [ "curses" "tty" "gtk2" "qt" "gnome3" "emacs" ]
  
in
{
  home.packages = with pkgs; [
    #scdl
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
    dtrx
    unrar
    ripgrep
    tree
    # duf not supported on mac
    broot
    ranger
    trash-cli
    rclone
    rsync
    fd
    exa
    comma
    wqy_microhei
    symbola
    # twitter-color-emoji
    bat
    htop
    navi
    tldr
    neofetch
    tokei
    sc-im
    calcurse
  ];

  home.file.".gnupg/gpg-agent.conf".text = lib.concatStringsSep "\n" (
    ["no-grab"]
    ++
    ["pinentry-program ${pkgs.pinentry.${pinentryFlavor}}/bin/pinentry"]
  );

  # Generating .gnupg/gpg.conf 
  programs.gpg = {
    enable = true;
  };
}

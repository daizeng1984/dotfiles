# CLI next gen
{ config, lib, pkgs, ... }:
let
  comma = import ( pkgs.fetchFromGitHub {
      owner = "Shopify";
      repo = "comma";
      rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
      sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
  }) {};
  stable = import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
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
    vim
    neovim
    nmap
    tmux
    tmuxp
    dtrx
    unrar
    rclone
    comma
    wqy_microhei
    symbola
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

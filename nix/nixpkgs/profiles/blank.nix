# not really blank, but really minimal
{ config, lib, pkgs, ... }:
let
  stable = import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {};
  nobreakingNeovim = stable.neovim;
  pinentryFlavor = "curses";
    # [ "curses" "tty" "gtk2" "qt" "gnome3" "emacs" ]
in
{
  home.packages = with pkgs; [
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


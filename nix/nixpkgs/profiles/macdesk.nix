# CLI next gen
{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [(import ../overlays/mac)];
  home.packages = with pkgs; [
    alacritty
    youtube-dl
    Firefox
    VLC
    # audacious
    # vlc
  ];
  # # solve the locale problems
  # home.sessionVariables = {
  #   LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };

}


# CLI next gen
{ config, lib, pkgs, ... }:
let
  nixGL = import ( pkgs.fetchFromGitHub {
      owner = "guibou";
      repo = "nixGL";
      rev = "fad15ba09de65fc58052df84b9f68fbc088e5e7c";
      sha256 = "1wc5gfj5ymgm4gxx5pz4lkqp5vxqdk2njlbnrc1kmailgzj6f75h";
    }) {}; 
in
{
  home.packages = with pkgs; [
    # unrar duf
    ntfs3g
    python3 # tools like autokey depends
    nodejs # neovim coc depends
    yarn
    jdk8 # old apps, thinkorswim
    xsel # copy paste in urxvt, perl
    nixGL.nixGLDefault #ogl
    libGLU
    alacritty
    rxvt-unicode
    google-chrome
    youtube-dl
    audacious
    vlc
    ffmpeg
    shutter
    gimp
    imagemagick
    virtualbox
    wine
    winetricks
    appimage-run
    tdesktop
    # ibus
    # ibus-engines.libpinyin
    # ibus-engines.table-chinese
  ];

  # firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles =
    let defaultSettings = {
          "app.update.auto" = false;
          "javascript.options.wasm" = true;
          "ui.key.menuAccessKeyFocuses" = false;
          "accessibility.force_disabled" = 1;
        };
    in {
      home = {
        id = 0;
        settings = defaultSettings // {
        };
      };

      work = {
        id = 1;
        settings = defaultSettings // {
        };
      };
    };
  };
}


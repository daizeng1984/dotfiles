# CLI next gen
{ config, lib, pkgs, ... }:
let
  nixGL = import ( pkgs.fetchFromGitHub {
      owner = "guibou";
      repo = "nixGL";
      rev = "fad15ba09de65fc58052df84b9f68fbc088e5e7c";
      sha256 = "1wc5gfj5ymgm4gxx5pz4lkqp5vxqdk2njlbnrc1kmailgzj6f75h";
    }) {}; 

  # clipboard
  cbs = with pkgs; pkgs.rustPlatform.buildRustPackage rec {
    pname = "cbs";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "robatipoor";
      repo = pname;
      rev = "e3f75bcd1045d65727537b700ee3dabcdc12266a";
      sha256 = "11n103z3148bszs22f5vm2lp4gk6qxbbnyi9hbxv4d26qz4mrkij";
    };

    nativeBuildInputs = [ python3 ];
    buildInputs = [ xorg.libxcb ];

    cargoPatches = [
      # a patch file to add/update Cargo.lock in the source code
      ./patches/cbs-cargo.lock.patch
    ];
    cargoSha256 = "0yvl67wx8dwnr0ndk4i9c86r33zaf42vpa48cx0m2maf6lphwvqn";

    meta = with stdenv.lib; {
      description = "cbs is a command line utility that is designed to run on linux system , macOs and maybe windows.";
      homepage = "https://github.com/robatipoor/cbs";
      license = licenses.asl20;
      maintainers = [ maintainers.tailhook ];
    };

  };
  
in
{
  home.packages = with pkgs; [
    # unrar duf
    apfs-fuse
    ntfs3g
    gparted
    python3 # tools like autokey depends
    nodejs # neovim coc depends
    yarn
    jdk8 # old apps, thinkorswim
    xsel # copy paste in urxvt, perl
    libGLU
    alacritty
    rxvt-unicode
    google-chrome
    youtube-dl
    tickrs
    audacious
    vlc
    ffmpeg
    shutter
    gimp
    slack
    imagemagick
    virtualbox
    wine
    winetricks
    appimage-run
    tdesktop
    ghostscript
    # ibus
    # ibus-engines.libpinyin
    # ibus-engines.table-chinese
    # customize
    nixGL.nixGLDefault #ogl
    cbs
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
          "gfx.webrender.all" = true;
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


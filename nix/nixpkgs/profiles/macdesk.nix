# CLI next gen
{ config, lib, pkgs, ... }:
let
  # clipboard
  # TODO: merge with linux one
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
    buildInputs = [ xorg.libxcb darwin.apple_sdk.frameworks.AppKit ];

    cargoPatches = [
      # a patch file to add/update Cargo.lock in the source code
      ./linux/patches/cbs-cargo.lock.patch
    ];
    cargoSha256 = "0yvl67wx8dwnr0ndk4i9c86r33zaf42vpa48cx0m2maf6lphwvqn";

    meta = with lib; {
      description = "cbs is a command line utility that is designed to run on linux system , macOs and maybe windows.";
      homepage = "https://github.com/robatipoor/cbs";
      license = licenses.asl20;
      maintainers = [ maintainers.tailhook ];
    };

  };
  macosAlias = with pkgs; let
    createMacOSAlias = (
      (builtins.toString (
        callPackage
          ({ stdenv }:

            stdenv.mkDerivation rec {
              name = "create-macos-alias";

              unpackPhase = "true"; # nothing to unpack

              src = ../overlays/mac/create-macos-alias.swift;

              dontConfigure = true;

              buildInputs = [ ];

              dontBuild = true;

              installPhase = ''
                install -D -m755 $src $out/bin/create-macos-alias
              '';

              meta = with lib; {
                license = licenses.mit;
                platforms = platforms.darwin;
                maintainers = with maintainers; [ eqyiel ];
              };
            }
          ) { }
      )) + "/bin/create-macos-alias"
    );
  in 
  config.lib.dag.entryAfter [ "installPackages" ] (
    ''
      echo "Creating alias..."

      # TODO: clean ups?
      # "${findutils}/bin/find" "${config.home.profileDirectory}/Applications/" -maxdepth 1 -iname '*.app' | while read app ; do
      #   type_str=`${file}/bin/file $app`
      #   if [ "$type_str" == *"Alias"* ]; then
      #     echo "Removing alias $app"
      #     rm $app
      #   fi
      # done
      
      "${findutils}/bin/find" "${config.home.profileDirectory}/Applications/" -maxdepth 1 -iname '*.app' | while read app ; do
          app_bn="$(${coreutils}/bin/basename "$app")"
          echo "Aliasing ${config.home.profileDirectory}/Applications/$app_bn to ${config.home.homeDirectory}/Applications/$app_bn"
          ${createMacOSAlias} "${config.home.profileDirectory}/Applications/$app_bn" "${config.home.homeDirectory}/Applications/$app_bn"
      done
    '');
in  
{
  nixpkgs.overlays = [(import ../overlays/mac)];
  home.packages = with pkgs; [
    tickrs
    findutils
    slack
    gimp
    cbs
    coreutils
    imagemagick
    python3 # tools like autokey depends
    nodejs # neovim coc depends
    yarn
    wuzz
    alacritty
    ghostscript
    youtube-dl
    VLC
    Phoenix
    #MonitorControl
    Shifty# Flux has no version control
    #KarabinerElements
    Iterm2 # instead of using xcode to build iterm2 in nixpkgs
    Cog
    GoogleChrome
  ];
  # # solve the locale problems
  # home.sessionVariables = {
  #   LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };

  programs.firefox = {
    enable = true;
    package = pkgs.Firefox;
    profiles =
    let defaultSettings = {
          "app.update.auto" = false;
          "javascript.options.wasm" = true;
          "ui.key.menuAccessKeyFocuses" = false;
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

  # Have to use alias to make it appear on 
  home.activation.link_apps = macosAlias;

}


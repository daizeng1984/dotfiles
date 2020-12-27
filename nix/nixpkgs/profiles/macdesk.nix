# CLI next gen
{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [(import ../overlays/mac)];
  home.packages = with pkgs; [
    findutils
    coreutils
    alacritty
    youtube-dl
    VLC
    Phoenix
    Flux
    #KarabinerElements
    Iterm2 # instead of using xcode to build iterm2 in nixpkgs
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
  home.activation.link_apps = with pkgs; let
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

              meta = with stdenv.lib; {
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
      # for app in $("${findutils}/bin/find" "${config.home.homeDirectory}/Applications/" -maxdepth 1 -iname '*.app'); do
      #   type_str=`${file}/bin/file $app`
      #   if [ "$type_str" == *"Alias"* ]; then
      #     echo "Removing alias $app"
      #     rm $app
      #   fi
      # done
      
      for app in $("${findutils}/bin/find" "${config.home.profileDirectory}/Applications/" -maxdepth 1 -iname '*.app'); do
          app_bn="$(${coreutils}/bin/basename $app)"
          echo "Aliasing ${config.home.profileDirectory}/Applications/$app_bn to ${config.home.homeDirectory}/Applications/$app_bn"
          ${createMacOSAlias} "${config.home.profileDirectory}/Applications/$app_bn" "${config.home.homeDirectory}/Applications/$app_bn"
      done
    '');

}


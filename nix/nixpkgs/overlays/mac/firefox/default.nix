# Ref https://github.com/cmacrae/config/blob/b33ccb041861b56c97e1744b0fd8c606e343164c/overlays/firefox/default.nix
{ stdenv, fetchurl, undmg, unzip }:
let
  version = "82.0.2";
in
stdenv.mkDerivation rec {
  inherit version;
  name = "Firefox-${version}";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Firefox.app "$out/Applications/Firefox.app"
    '';

}

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

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
    sha256 = "1204bsplb6iyk2gcics9bf2jrjffjh3v9disnp72ssmdqi5r8fap";
  };

  meta = with stdenv.lib; {
    description = "The Firefox web browser";
    homepage = https://www.mozilla.org/en-GB/firefox;
    maintainers = with maintainers; [ daizeng1984 ];
    platforms = platforms.darwin;
  };
}

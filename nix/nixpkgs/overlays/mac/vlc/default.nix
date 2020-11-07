{ stdenv, fetchurl, undmg, unzip }:
let
  version = "3.0.11.1";
in
stdenv.mkDerivation rec {
  inherit version;
  name = "VLC-${version}";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r VLC.app "$out/Applications/VLC.app"
    '';

  src = fetchurl {
    name = "vlc-${version}.dmg";
    url = "https://mirrors.syringanetworks.net/videolan/vlc/${version}/macosx/vlc-${version}.dmg";
    sha256 = "1dcgvrc88jllqr85fg410af8r12zbkx6vmalnb1iww76yv9144h2";
  };

  meta = with stdenv.lib; {
    description = "VLC media player";
    homepage = https://www.videolan.org/vlc/;
    maintainers = with maintainers; [ daizeng1984 ];
    platforms = platforms.darwin;
  };
}


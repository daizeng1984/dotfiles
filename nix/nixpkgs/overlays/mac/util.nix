{ super, Name, version, src, 
meta ? with super.stdenv.lib; {
      description = "N/A";
      homepage = http://127.0.0.1;
      maintainers = with maintainers; [ daizeng1984 ];
      platforms = platforms.darwin;
    }
}:
  super.stdenv.mkDerivation rec {
  inherit version;
  name = "${Name}-${version}";
  buildInputs = [ super.undmg super.unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      for app in $("${super.findutils}/bin/find" "." -maxdepth 1 -iname '*.app'); do
          app_bn="$(${super.coreutils}/bin/basename $app)"
          cp -r $app_bn "$out/Applications/$app_bn"
      done
    '';
  inherit src;
  inherit meta;
}

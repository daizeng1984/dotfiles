#with import <nixpkgs> {};
{ pkgs ? 
import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {}
}
:
# let
#   emscriptenPackages.zlib
#in 
pkgs.mkShell {
  buildInputs = with pkgs; [
    emscripten
    emscriptenPackages.zlib
    webfs # webfs -F -p 3000 to serve current folder
    # if you have your own c++ packages see to compile emscripten one: https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/emscripten.section.md#user-content-usage-2-pkgsbuildemscriptenpackage
  ];
}


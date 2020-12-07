# { pkgs ? import <nixpkgs> {} }:
{ pkgs ? 
import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {}
}:

let
  version = "0.1";
in pkgs.mkShell {
  name = "my-cpp-app";
  src = "./.";
  # phases: unpackPhase -> configurePhase -> buildPhase -> installPhase
  buildInputs = with pkgs; [ boost poco ];
  buildPhase = "c++ -o main main.cpp -lPocoFoundation -lboost_system";
  installPhase = ''
    mkdir -p $out/bin
    cp main $out/bin
  '';

  enableParallelBuilding = true;
}


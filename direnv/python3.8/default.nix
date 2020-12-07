#with import <nixpkgs> {};
{ pkgs ? 
import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {}
}
:
let
  pythonEnv = pkgs.python38.withPackages (ps: [
    ps.numpy
    ps.pytorch
    ps.dateutil
  ]);
in pkgs.mkShell {
  buildInputs = with pkgs; [
    pythonEnv
    libffi
    openssl
  ];
}

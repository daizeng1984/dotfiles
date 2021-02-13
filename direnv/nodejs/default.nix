# Nixpkgs 20.09
# no -g/global install needed! node_modules/.bin is in PATH when in this folder
# { pkgs ? import <nixpkgs> {} }:
{ pkgs ? 
import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  }) {}
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    yarn
  ];

  shellHook = ''
    export PATH="$PWD/node_modules/.bin/:$PATH"
    echo "🚀 nodejs ready!"
  '';

  MY_ENVIRONMENT_VARIABLE = "dummy";
}

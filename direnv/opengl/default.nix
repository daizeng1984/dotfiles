# { pkgs ? import <nixpkgs> {} }:
{ pkgs ? 
import (builtins.fetchTarball {
      name = "nixos-21.05";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/21.05";
      sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
    }) {
      config.allowUnfree = true; # for vscode
      # config.allowBroken = true;
      # config.allowUnsupportedSystem = true;
    }
}:

let
  version = "0.1";
  mach-nix = import (builtins.fetchGit {
          url = "https://github.com/DavHau/mach-nix/";
          rev = "773580c35bcdb8cbd0820018d304686282f88d16";  # update this version
          }) {
      python = "python38";
  };
  pyEnv = mach-nix.mkPython rec {
      requirements =  ''
          glad
          compiledb
          '';
  };
in pkgs.mkShell {
  name = "OpenGL";

  nativeBuildInputs = with pkgs; [ 
    gnumake
    ninja
    ccls
    pyEnv
  ];
  buildInputs = with pkgs; [ 
    glfw
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.OpenGL
    lldb
    gdb
  ];

  enableParallelBuilding = true;

  shellHook = ''
    mkdir -p ./deps/glad
    glad --spec gl --profile core --out-path ./deps/glad --generator c --local-files --api gl=3.3
    echo "🚀 opengl ready!"
  '';

}


with import <nixpkgs> {};
let
  pythonEnv = python38.withPackages (ps: [
    ps.numpy
    ps.pytorch
    ps.dateutil
  ]);
in mkShell {
  buildInputs = [
    pythonEnv

    libffi
    openssl
  ];
}

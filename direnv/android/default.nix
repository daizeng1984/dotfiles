# { pkgs ? import <nixpkgs> {} }:
{ pkgs ? 
import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://codeload.github.com/NixOS/nixpkgs/tar.gz/20.09";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
    }) {
      config.android_sdk.accept_license = true;
    }
}:
 
# You need to run sdkmanager --licenses to accept all licenses cached
let
  androidSdk = pkgs.androidenv.androidPkgs_9_0.androidsdk;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    androidSdk
    gradle
    glibc
  ];
  # override the aapt2 that gradle uses with the nix-shipped version
  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/28.0.3/aapt2";
  # license issue https://github.com/NixOS/nixpkgs/issues/23910
  ANDROID_HOME = "${androidSdk}/libexec";
}

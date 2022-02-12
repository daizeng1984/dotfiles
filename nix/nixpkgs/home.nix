{ config, pkgs, ... }:

let profiles = {
# Base includes shell and utility related install
  blank = [
    ./profiles/blank.nix
  ];
  base = [
    ./profiles/minimal.nix
  ];
  # For my main development machine only
  dev = [
    ./profiles/minimal.nix
    ./profiles/cli.nix
  ];
  homelinux = [
    ./profiles/minimal.nix
    ./profiles/cli.nix
    ./profiles/linux/programs.nix
    ./profiles/linux/services.nix
    ./profiles/linux/gnome.nix
  ];
  homenixos = [
    ./profiles/minimal.nix
    ./profiles/cli.nix
    ./profiles/linux/programs.nix
    ./profiles/linux/services.nix
    ./profiles/linux/nixos.nix
  ];
  homemac = [
    ./profiles/minimal.nix
    ./profiles/cli.nix
    ./profiles/macdesk.nix
  ];
  homemacconda = [
    ./profiles/blank.nix
    ./profiles/macdesk.nix
  ];
};
envProfile = builtins.getEnv "MY_NIX_PROFILE";
# I'm sure here can do better, now tolerate nix baby language 😂
profile = if ("${envProfile}" == "") then "blank" else "${envProfile}" ;
in
{
  nixpkgs.config.allowUnfree = true;
  # build for mac if not supported
  nixpkgs.config.allowUnsupportedSystem = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true; # don't forget fc-cache -f

  imports = if (builtins.hasAttr "${profile}" profiles) then profiles."${profile}" else [ "${profile}" ];

  #
  home.username = "Zeng Dai";
  home.homeDirectory = builtins.getEnv "HOME";
  
  # Starting ver
  home.stateVersion = "21.11";
}

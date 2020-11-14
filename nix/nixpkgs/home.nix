{ config, pkgs, ... }:

let profiles = {
# Base includes shell and utility related install
  base = [
    ./profiles/cli.nix
  ];
  # For my main development machine only
  dev = [
    ./profiles/cli.nix
    # ./profiles/node.nix
    # ./profiles/python.nix
    # ./profiles/go.nix
  ];
  homelinux = [
    ./profiles/cli.nix
    ./profiles/linuxdesk.nix
    #./profiles/firefox
  ];
  homemac = [
    ./profiles/cli.nix
    ./profiles/macdesk.nix
  ];
};
envProfile = builtins.getEnv "MY_NIX_PROFILE";
# I'm sure here can do better, now tolerate nix baby language 😂
profile = if ("${envProfile}" == "") then "base" else "${envProfile}" ;
in
{
  nixpkgs.config.allowUnfree = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true; # don't forget fc-cache -f

  imports = if (builtins.hasAttr "${profile}" profiles) then profiles."${profile}" else [ "${profile}" ];

  #
  home.username = "Zeng Dai";
  home.homeDirectory = builtins.getEnv "HOME";
  
  # Starting ver
  home.stateVersion = "20.09";
}

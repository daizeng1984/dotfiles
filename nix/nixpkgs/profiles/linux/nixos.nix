# NixOS session
{ config, lib, pkgs, ... }:
{
  xsession.enable = false;

  # create our own (mainly avoid hm-session-vars.sh
  home.file.".xprofile".text = ''
      xhost +SI:localuser:$USER
    '';
}


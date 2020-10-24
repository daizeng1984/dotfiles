# CLI next gen
{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];
}


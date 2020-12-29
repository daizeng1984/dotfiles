# Services
{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # unrar duf
    autokey
    wmctrl
    xorg.xwininfo
    xorg.xhost
    rclone
  ];

  # Don't install nix FUSE, just use system one. permission issues!
  systemd.user = {
    systemctlPath = "systemctl";

    services.dropbox_rclone = let
        mountdir="${config.home.homeDirectory}/cloud/dropbox";
      in
      {
      Unit = {
        Description = "dropbox rclone mount";
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mountdir}";
          ExecStart = ''
              ${pkgs.rclone}/bin/rclone mount dropbox: ${mountdir}
          '';
          ExecStop = "${pkgs.fuse}/bin/fusermount -uz ${mountdir}";
          Type = "notify";
          Restart = "on-failure";
          RestartSec = "10s";
      };
    };
    services.google_rclone = let
        mountdir="${config.home.homeDirectory}/cloud/google";
      in
      {
      Unit = {
        Description = "google drive rclone mount";
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mountdir}";
          ExecStart = ''
              ${pkgs.rclone}/bin/rclone mount google: ${mountdir}
          '';
          ExecStop = "${pkgs.fuse}/bin/fusermount -uz ${mountdir}";
          Type = "notify";
          Restart = "on-failure";
          RestartSec = "3s";
      };
    };
    services.autokey = {
      Unit = {
        After="graphical-session-pre.target";
        PartOf="graphical-session.target";
        Description = "Autokey";
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
          ExecStart = ''
              ${pkgs.autokey}/bin/autokey-gtk
          '';
          ExecStop = "";
          Restart = "on-failure";
          RestartSec = "0s";
      };
    };
  };
  targets.genericLinux.enable = true;
}


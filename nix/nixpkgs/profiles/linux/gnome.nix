# gnome xsession in non-nixos
{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    gtk3
  ];

  # home manager control xsession
  # gnome should be installed in host
  # config gdm to use `user script` to load
  xsession.enable = true;
  xsession.windowManager.command = "exec -l $SHELL -c gnome-session";
  xsession.importedVariables = [
    "PATH"
    "MANPATH"
    "DBUS_SESSION_BUS_ADDRESS"
    "DISPLAY"
    "SSH_AUTH_SOCK"
    "XAUTHORITY"
    "XDG_DATA_DIRS"
    "XDG_RUNTIME_DIR"
    "XDG_SESSION_ID"
    "XCURSOR_PATH"
    "LOCALE_ARCHIVE"
    "GSETTINGS_SCHEMA_DIR"
    "QT_MODULES"
    "XMODIFIERS"
    "GTK_MODULES"
  ];
}


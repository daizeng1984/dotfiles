# xsession
{ config, lib, pkgs, ... }:
{
  # home manager control xsession
  # config gdm to use `user script` to load
  xsession.enable = true;
  xsession.windowManager.command = "exec -l $SHELL -c ${pkgs.gnome3.gnome-session}/bin/gnome-session";
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

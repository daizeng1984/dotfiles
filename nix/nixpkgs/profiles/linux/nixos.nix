# NixOS session
{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    gtk3
  ];
  # solve the locale problems
  home.sessionVariables = {
    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  };

  xsession.enable = true;
  xsession.windowManager.command = "exec -l $SHELL -c ${pkgs.gnome3.gnome-session}/bin/gnome-session";
  xsession.profileExtra = ''
    xhost +SI:localuser:$USER
  '';

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


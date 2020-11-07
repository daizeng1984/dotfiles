# Makesure gnome know these path
export NIX_HOME_PATH=$HOME/.nix-profile
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi # added by Nix installer
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Let us manage by ourselves now
export GSETTINGS_SCHEMA_DIR=$NIX_HOME_PATH/share/gsettings-schemas/gtk+3-3.24.21/glib-2.0/schemas
export XCURSOR_PATH=/usr/share/icons/
#systemctl --user import-environment XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID LOCALE_ARCHIVE
systemctl --user import-environment DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_AUTH_SOCK XAUTHORITY XDG_DATA_DIRS XDG_RUNTIME_DIR XCURSOR_PATH XDG_SESSION_ID LOCALE_ARCHIVE GSETTINGS_SCHEMA_DIR

# redshift systemctl ...
systemctl --user start redshift.service

# google drive and dropbox
systemctl --user start google_rclone.service
systemctl --user start dropbox_rclone.service

# TODO: make it service autokey
autokey-gtk -c &

# caps
# xmodmap $HOME/.Xmodmap
# services
# setxkbmap -option caps:none

# 4K plasma
# export PLASMA_USE_QT_SCALING=1
# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5

# Makesure gnome know these path
export NIX_HOME_PATH=$HOME/.nix-profile
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi # added by Nix installer
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Let us manage by ourselves now
export GSETTINGS_SCHEMA_DIR=`/usr/bin/env readlink -f $NIX_HOME_PATH/share/gsettings-schemas/**/`"/glib-2.0/schemas"
export XCURSOR_PATH=/usr/share/icons/

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
export QT_MODULES=ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULES=ibus

#systemctl --user import-environment XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID LOCALE_ARCHIVE
systemctl --user import-environment PATH MANPATH DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_AUTH_SOCK XAUTHORITY XDG_DATA_DIRS XDG_RUNTIME_DIR XCURSOR_PATH XDG_SESSION_ID LOCALE_ARCHIVE GSETTINGS_SCHEMA_DIR QT_MODULES XMODIFIERS GTK_MODULES

# redshift systemctl ...
systemctl --user start redshift.service

# google drive and dropbox
systemctl --user start google_rclone.service
systemctl --user start dropbox_rclone.service

# autokey
systemctl --user start autokey.service

# 4K plasma
# export PLASMA_USE_QT_SCALING=1
# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5

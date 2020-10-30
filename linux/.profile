# Makesure gnome know these path
export NIX_HOME_PATH=$HOME/.nix-profile
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi # added by Nix installer
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

# Let us manage by ourselves now
#systemctl --user import-environment XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID LOCALE_ARCHIVE
systemctl --user import-environment DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_AUTH_SOCK XAUTHORITY XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID LOCALE_ARCHIVE

# redshift systemctl ...
systemctl --user start redshift.service

# caps
# xmodmap $HOME/.Xmodmap
# services
# setxkbmap -option caps:none

# autokey
autokey-gtk -c &

# 4K plasma
# export PLASMA_USE_QT_SCALING=1
# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5

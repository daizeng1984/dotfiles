# Makesure gnome know these path
export NIX_HOME_PATH=$HOME/.nix-profile
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi # added by Nix installer
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

# Let us manage by ourselves now
# redshift
redshift &;

# 4K plasma
# export PLASMA_USE_QT_SCALING=1
# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5

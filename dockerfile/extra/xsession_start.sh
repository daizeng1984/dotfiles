#!/bin/bash
#
# Create x11vnc server and enter bash
#

: ${X11_WINDOW_MANAGER:=ratpoison}

# Add window manager to X session.
$X11_WINDOW_MANAGER &

# Attach as client to session with VNC server.
x11vnc --usepw --forever &

# End
bash

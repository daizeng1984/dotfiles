#!/usr/bin/python3
# System tray icon that toggles tickrs in a kitty quick-access terminal
# docked to the right edge of the screen (1/3 screen width).
# Needs PyQt6 (system python) and kitty >= 0.42.
import os
import shutil
import subprocess
import sys

from PyQt6.QtGui import QAction, QGuiApplication, QIcon
from PyQt6.QtWidgets import QApplication, QMenu, QSystemTrayIcon

WIDTH_RATIO = 1 / 3
INSTANCE = "tickrs"


def find(cmd, *fallbacks):
    return shutil.which(cmd) or next(
        (p for p in map(os.path.expanduser, fallbacks) if os.access(p, os.X_OK)), cmd
    )


KITTEN = find("kitten", "/usr/bin/kitten")
TICKRS = find("tickrs", "~/.cargo/bin/tickrs", "~/.nix-profile/bin/tickrs")


def toggle():
    width = int(QGuiApplication.primaryScreen().geometry().width() * WIDTH_RATIO)
    subprocess.Popen(
        [
            KITTEN, "quick-access-terminal",
            "--instance-group", INSTANCE,
            "-o", "edge=right",
            "-o", f"columns={width}px",
            "-o", "focus_policy=on-demand",
            "-o", "background_opacity=0.95",
            TICKRS, "--summary",
        ],
        start_new_session=True,
    )


def main():
    app = QApplication(sys.argv)
    app.setQuitOnLastWindowClosed(False)

    icon = QIcon.fromTheme("office-chart-line", QIcon.fromTheme("view-statistics"))
    tray = QSystemTrayIcon(icon)
    tray.setToolTip("tickrs")

    menu = QMenu()
    show = QAction("Toggle tickrs")
    show.triggered.connect(toggle)
    quit_ = QAction("Quit")
    quit_.triggered.connect(app.quit)
    menu.addAction(show)
    menu.addAction(quit_)
    tray.setContextMenu(menu)

    tray.activated.connect(
        lambda reason: toggle() if reason == QSystemTrayIcon.ActivationReason.Trigger else None
    )
    tray.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()

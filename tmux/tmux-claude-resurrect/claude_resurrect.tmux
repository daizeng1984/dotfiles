#!/usr/bin/env bash
# tmux-claude-resurrect: extends tmux-resurrect so panes running Claude Code
# come back with `claude --resume <session-id>` in the same directory.
#
# Options:
#   @claude-resurrect-command   command used to relaunch (default: "claude")
#   @claude-resurrect-file      sidecar file (default: ~/.local/share/tmux/claude-resurrect/last.tsv)
#   @claude-resurrect-auto-save-interval
#                               minutes between automatic saves (default: 0 = off).
#                               Auto-save only starts once you've restored (prefix+C-r)
#                               or saved by hand (prefix+C-s) in this tmux server.
#   @claude-resurrect-backups   how many previous claude lists to keep (default: 20)

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tmux set-option -g @resurrect-hook-post-save-layout "$CURRENT_DIR/scripts/save.sh"
tmux set-option -g @resurrect-hook-post-restore-all "$CURRENT_DIR/scripts/restore.sh"

tmux run-shell -b "$CURRENT_DIR/scripts/auto_save.sh"

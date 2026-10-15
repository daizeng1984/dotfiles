#!/usr/bin/env bash
# Background loop: every @claude-resurrect-auto-save-interval minutes, run a
# quiet tmux-resurrect save (which triggers save.sh via the post-save hook).
# Exits when the tmux server goes away or a newer loop replaces it.

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

tmux set-option -g @claude-resurrect-auto-save-pid "$$"

while :; do
	interval="$(get_tmux_option "@claude-resurrect-auto-save-interval" "0")"
	case "$interval" in '' | *[!0-9]* | 0) exit 0 ;; esac
	sleep $((interval * 60))

	# Server gone, or a re-sourced config started a newer loop.
	owner="$(tmux show-option -gqv @claude-resurrect-auto-save-pid 2>/dev/null)" || exit 0
	[ "$owner" = "$$" ] || exit 0

	# Not until you've restored or saved by hand in this server; otherwise
	# a fresh server would overwrite the snapshot you want to restore.
	[ "$(get_tmux_option "@claude-resurrect-armed" "")" = 1 ] || continue

	save_script="$(get_tmux_option "@resurrect-save-script-path" "")"
	[ -x "$save_script" ] && CLAUDE_RESURRECT_AUTO_SAVE=1 "$save_script" quiet >/dev/null 2>&1
done

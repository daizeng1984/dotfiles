#!/usr/bin/env bash

get_tmux_option() {
	local value
	value="$(tmux show-option -gqv "$1")"
	echo "${value:-$2}"
}

sidecar_file() {
	local default="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/claude-resurrect/last.tsv"
	get_tmux_option "@claude-resurrect-file" "$default" | sed "s,^~,$HOME,"
}

backup_dir() {
	echo "$(dirname "$(sidecar_file)")/backups"
}

# Auto-save is armed per tmux server, so a fresh server can't overwrite
# the snapshot before it has been restored.
arm_auto_save() {
	tmux set-option -g @claude-resurrect-armed 1
}

claude_sessions_dir() {
	echo "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/sessions"
}

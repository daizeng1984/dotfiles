#!/usr/bin/env bash
# Called by tmux-resurrect after everything is restored.
# Relaunches `claude --resume <id>` in each pane recorded by save.sh.

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

arm_auto_save

file="$(sidecar_file)"
[ -f "$file" ] || exit 0

cmd="$(get_tmux_option "@claude-resurrect-command" "claude")"
shells=" bash zsh fish sh dash ksh tcsh "

while IFS=$'\t' read -r s w i cwd sid; do
	[ -n "$sid" ] || continue
	target="$s:$w.$i"
	current="$(tmux display-message -p -t "$target" '#{pane_current_command}' 2>/dev/null)" || continue
	# Only touch panes sitting at a shell prompt (don't clobber a live claude).
	case "$shells" in *" $current "*) ;; *) continue ;; esac
	tmux send-keys -t "$target" "cd $(printf '%q' "$cwd") && $cmd --resume $sid" C-m
done < "$file"

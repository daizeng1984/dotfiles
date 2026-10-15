#!/usr/bin/env bash
# Called by tmux-resurrect after the layout is saved.
# Writes: session_name \t window_index \t pane_index \t cwd \t claude_session_id
# for every pane that has a live Claude Code process somewhere beneath it.

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

out="$(sidecar_file)"
mkdir -p "$(dirname "$out")"
tmp="$out.tmp.$$"
: > "$tmp"

# pane root pid -> "session\twindow\tpane"
declare -A pane_by_pid
while IFS=$'\t' read -r pid s w i; do
	pane_by_pid[$pid]="$s"$'\t'"$w"$'\t'"$i"
done < <(tmux list-panes -a -F "#{pane_pid}	#{session_name}	#{window_index}	#{pane_index}")

declare -A seen
for f in "$(claude_sessions_dir)"/*.json; do
	[ -f "$f" ] || continue
	json="$(cat "$f")"
	pid="$(grep -o '"pid": *[0-9]*' <<<"$json" | head -1 | grep -o '[0-9]*$')"
	sid="$(grep -o '"sessionId": *"[^"]*"' <<<"$json" | head -1 | cut -d'"' -f4)"
	cwd="$(grep -o '"cwd": *"[^"]*"' <<<"$json" | head -1 | cut -d'"' -f4)"
	[ -n "$pid" ] && [ -n "$sid" ] || continue
	kill -0 "$pid" 2>/dev/null || continue # stale file from a dead process

	# Walk up the process tree until we reach a tmux pane's root process.
	p="$pid"
	while [ -n "$p" ] && [ "$p" -gt 1 ]; do
		if [ -n "${pane_by_pid[$p]}" ]; then
			if [ -z "${seen[${pane_by_pid[$p]}]}" ]; then
				seen[${pane_by_pid[$p]}]=1
				printf '%s\t%s\t%s\n' "${pane_by_pid[$p]}" "$cwd" "$sid" >> "$tmp"
			fi
			break
		fi
		p="$(ps -o ppid= -p "$p" 2>/dev/null | tr -d ' ')"
	done
done

# Keep the previous list as a timestamped backup whenever it changes.
if [ -s "$out" ] && ! cmp -s "$tmp" "$out"; then
	mkdir -p "$(backup_dir)"
	cp -p "$out" "$(backup_dir)/$(date -r "$out" +%Y%m%dT%H%M%S).tsv"
	keep="$(get_tmux_option "@claude-resurrect-backups" "20")"
	ls -1t "$(backup_dir)"/*.tsv 2>/dev/null | tail -n +$((keep + 1)) | xargs -r rm -f
fi

mv "$tmp" "$out"

# A save you triggered yourself (not the auto-save loop) arms auto-save.
[ -n "$CLAUDE_RESURRECT_AUTO_SAVE" ] || arm_auto_save

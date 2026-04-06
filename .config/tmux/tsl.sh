#!/usr/bin/env bash
# tsl: tmux session launcher
# parses sessions.toml and creates tmux sessions from it
# usage: tsl.sh <session-name> | --list

CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/sessions.toml"

parse_sessions() {
    local name=""
    local -a win_paths=()
    local -a win_cmds=()

    flush() {
        [[ -n "$name" ]] || return
        if [[ "$1" == "list" ]]; then
            echo "$name"
        elif [[ "$1" == "$name" ]]; then
            launch "$name"
            exit 0
        fi
        name=""
        win_paths=()
        win_cmds=()
    }

    # strip comments, skip blanks, match toml headers and kv pairs
    while IFS= read -r line; do
        line="${line%%#*}"
        [[ -z "${line// /}" ]] && continue

        if [[ "$line" == "[[session]]" ]]; then
            flush "$1"
            continue
        fi

        if [[ "$line" == "[[session.window]]" ]]; then
            win_paths+=("")
            win_cmds+=("")
            continue
        fi

        if [[ "$line" =~ ^([a-z_]+)[[:space:]]*=[[:space:]]*\"(.*)\"$ ]]; then
            local key="${BASH_REMATCH[1]}" val="${BASH_REMATCH[2]}"
            local i=$((${#win_paths[@]} - 1))
            case "$key" in
                name) name="$val" ;;
                path) win_paths[$i]="${val/#\~/$HOME}" ;;
                command) win_cmds[$i]="$val" ;;
            esac
        fi
    done < "$CONFIG"
    flush "$1"
}

launch() {
    local name="$1"

    # if session exists, just switch to it
    if tmux has-session -t "=$name" 2>/dev/null; then
        tmux switch-client -t "=$name"
        return
    fi

    local first_path="${win_paths[0]}"
    local first_cmd="${win_cmds[0]}"

    local base_index
    base_index=$(tmux show-option -gv base-index 2>/dev/null || echo 0)

    # destroy-unattached kills detached sessions instantly,
    # so we disable it while building the session
    tmux set-option -g destroy-unattached off

    # first window comes from new-session itself
    tmux new-session -d -s "$name" -c "$first_path"
    [[ -n "$first_cmd" ]] && tmux send-keys -t "=$name:$base_index" "$first_cmd" Enter

    # remaining windows
    local i
    for ((i = 1; i < ${#win_paths[@]}; i++)); do
        tmux new-window -t "=$name" -c "${win_paths[$i]}"
        [[ -n "${win_cmds[$i]}" ]] && tmux send-keys -t "=$name:$((base_index + i))" "${win_cmds[$i]}" Enter
    done

    # focus first window, attach, restore destroy-unattached
    tmux select-window -t "=$name:$base_index"
    tmux switch-client -t "=$name"
    tmux set-option -g destroy-unattached on
}

if [[ ! -f "$CONFIG" ]]; then
    echo "No config found at $CONFIG" >&2
    exit 1
fi

case "$1" in
    --list) parse_sessions "list" ;;
    "") echo "Usage: tsl.sh <session-name> | --list" >&2; exit 1 ;;
    *) parse_sessions "$1" ;;
esac

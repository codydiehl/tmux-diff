#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

remove_empty_lines_from_end_of_file() {
  local file=$1
  local temp=$(cat $file)
  printf '%s\n' "$temp" > "$file"
}

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

display_message() {
	local message="$1"
	# display_duration defaults to 5 seconds, if not passed as an argument
	if [ "$#" -eq 2 ]; then
		local display_duration="$2"
	else
		local display_duration="5000"
	fi
	# saves user-set 'display-time' option
	local saved_display_time=$(get_tmux_option "display-time" "750")
	# sets message display time to 5 seconds
	tmux set-option -gq display-time "$display_duration"
	# displays message
	tmux display-message "$message"
	# restores original 'display-time' value
	tmux set-option -gq display-time "$saved_display_time"
}

wrong_num_panes_message() {
  echo "There must be 2 panes to run tmux-diff" 
}

capture_panes() {
  local file1="$HOME/~pane1"
  local file2="$HOME/~pane2"
  tmux capture-pane -t 1 -J -p > "${file1}"
  tmux capture-pane -t 2 -J -p > "${file2}"
  remove_empty_lines_from_end_of_file "${file1}"
  remove_empty_lines_from_end_of_file "${file2}"
}

view_diff() {
  tmux select-pane -t2
  tmux split-window -v
  tmux select-layout main-horizontal
  tmux swap-pane -t3 -s1
  tmux select-pane -t1
  tmux resize-pane -Z
  tmux send-keys -t1 C-z 'colordiff -yB ~/~pane1 ~/~pane2' Enter
}

kill_pane() {
  rm ~/~pane1 ~/~pane2
  tmux kill-pane -t1
}

check_panes() {
    $CURRENT_DIR/check_if_two_panes.sh
}

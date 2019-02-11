#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/shared.sh"

main() {
  local num="$(tmux list-panes | wc -l)"
  if [[ $num != "2" ]]; then
    display_message "$(wrong_num_panes_message)"
    exit 1
  fi
}
main

#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"

main() {
  if check_panes; then
    capture_panes
    view_diff
    display_message "Press prefix+shift+$end_diff_key to exit"
  fi
}
main

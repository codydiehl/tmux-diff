#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/shared.sh"

main() {
  tmux bind-key "$diff_key" run-shell "$CURRENT_DIR/diff.sh"
  tmux bind-key "$end_diff_key" run-shell "$CURRENT_DIR/end_diff.sh"
}
main

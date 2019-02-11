default_tmux_diff_key="C" # shift D
diff_key=$(tmux show-option -gqv "@diff_key")
diff_key=${diff_key:-$default_tmux_diff_key}

default_end_diff_key="Z" # shift Q
end_diff_key=$(tmux show-option -gqv "@end_diff_key")
end_diff_key=${end_diff_key:-$default_end_diff_key}

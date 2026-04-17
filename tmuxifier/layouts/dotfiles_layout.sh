# tmuxifier layout for dotfiles

layout() {
  # Create a new window named 'dotfiles'
  tmux new-window -n dotfiles -c "$PWD"

  # Split the window into two panes
  tmux split-window -h -c "$PWD"

  # Select the first pane
  tmux select-pane -t 0
}
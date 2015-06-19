
function emux() {
  [[ -z "$TMUX" ]] && exec tmux
}

# only when starting tmux
if [[ ! -z $TMUX ]]; then
  tmux set -g status-right-fg $(prompt_color)
fi

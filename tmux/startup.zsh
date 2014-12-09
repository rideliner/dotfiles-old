
function emux() {
  [[ -z "$TMUX" ]] && exec tmux
}

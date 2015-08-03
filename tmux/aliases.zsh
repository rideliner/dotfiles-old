function fail-outside-tmux() {
  (( $+TMUX )) && return 1 || { echo "Must be run inside tmux."; return 0; }
}

if [[ -f "/games/SteamLibrary/steamapps/common/Starbound/linux64" ]]; then
  function starbound() {
    fail-outside-tmux && return 1

    local game_path="/games/SteamLibrary/steamapps/common/Starbound/linux64"
    tmux new-window -n 'Starbound' -c "$game_path"
    tmux split-window -h -c "$game_path"
    tmux select-pane -t 0
    tmux send-keys "./starbound_server" C-m
    tmux select-pane -t 1
    tmux send-keys "./starbound" C-m
  }
fi

if [[ $+commands[wine] && -f "$HOME/.wine/drive_c/Program Files (x86)/World of Warcraft/Wow-64.exe" ]]; then
  function wow() {
    fail-outside-tmux && return 1

    local game_path="$HOME/.wine/drive_c/Program Files (x86)/World of Warcraft"
    tmux new-window -n 'WoW' -c "$game_path"
    tmux send-keys "wine Wow-64.exe" C-m
  }
fi

function rideliner() {
  fail-outside-tmux && return 1

  local -Ua machines
  machines=(marple hastings oliver poirot pyne)
  machines=(${(@)machines:#$(hostname -s)})

  tmux new-window -n 'Network'

  for (( i = 1; i <= $#machines; i++ )); do
    if (( i != 1 )); then
      tmux split-window -h
    fi

    tmux send-keys "ssh ${machines[i]}" C-m
  done

  tmux select-layout tiled
}
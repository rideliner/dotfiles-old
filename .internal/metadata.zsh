source "${0:A:h}/path.zsh"

function dotfiles/meta/load() {
  local -Ua _metaMods
  local mod

  for src ($DOTFILES_PATH/*/.meta(N)); do
    source $src
    _metaMods+=("${src:h:t}")
  done

  eval "$1=($_metaMods)"
}

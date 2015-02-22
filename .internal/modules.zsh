source "${0:A:h}/path.zsh"

function loadMeta() {
  for src ($DOTFILES_PATH/${(P)^1}/.meta(N)); do
    source $src
  done
}

function getModules() {
  local -Ua _mods
  zstyle -a ':ride' modules '_mods'

  _mods=(zsh $_mods)

  eval "$1=($_mods)"
}

function findAllModules() {
  local -Ua _mods

  _mods=($DOTFILES_PATH/*/.meta(N:h:t))

  eval "$1=($_mods)"
}

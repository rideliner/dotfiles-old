source "${0:A:h}/path.zsh"

function loadMeta() {
  local -Ua _metaMods

  for src ($DOTFILES_PATH/*/.meta(N)); do
    source $src
    _metaMods+=("${src:h:t}")
  done

  eval "$1=($_metaMods)"
}

function getModules() {
  local -Ua _mods _enabledMods
  local enabled

  loadMeta _mods

  for mod ($_mods); do
    zstyle -s ":ride:$mod" enabled enabled
    if [[ "$enabled" == "true" ]]; then
      _enabledMods+=($mod)
    fi
  done

  eval "$1=($_enabledMods)"
}

function findAllModules() {
  local -Ua _mods

  _mods=($DOTFILES_PATH/*/.meta(N:h:t))

  eval "$1=($_mods)"
}

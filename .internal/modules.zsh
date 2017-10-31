source "${0:A:h}/path.zsh"
source "${DOTFILES_PATH}/.internal/check.zsh"
source "${DOTFILES_PATH}/.internal/groups.zsh"
source "${DOTFILES_PATH}/.internal/metadata.zsh"

function dotfiles/modules/getActive() {
  local -Ua _mods _activeMods

  dotfiles/meta/load _mods

  for mod ($_mods); do
    if dotfiles/check/isActive ":ride:$mod"; then
      _activeMods+=($mod)
    fi
  done

  eval "$1=($_activeMods)"
}

function dotfiles/modules/getAll() {
  dotfiles/meta/load $1
}

function dotfiles/modules/getSome() {
  local -Ua _mods _selected

  dotfiles/meta/load _mods

  _selected=(${*[2, -1]})

  eval "$1=($(dotfiles/util/intersection _selected _mods))"
}

function dotfiles/debug/inactive() {
  local -Ua _mods _activeMods

  dotfiles/meta/load _mods

  for mod ($_mods); do
    dotfiles/log/wrapper/start "ACTV" "$mod"
    dotfiles/check/debugActive ":ride:$mod"
    dotfiles/log/wrapper/end ""
  done
}

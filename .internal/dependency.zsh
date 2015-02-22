source "${0:A:h}/modules.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"

function getModulesAndDependencies() {
  local _some _all

  getModules _some

  if [[ ${#_some} -eq 0 ]]; then
    fail 'No modules have been set through zstyle.'
    exit 1
  fi

  resolveAllDependencies _some _all

  eval "$1=($_all)"
}

function resolveAllDependencies() {
  local -a dependencies
  local -Ua total

  for mod in "${(P)1}"; do
    resolveDependencies $mod dependencies
    total+=($dependencies)
  done

  eval "$2=($total)"
}

function resolveDependencies() {
  local -a resolved unresolved
  resolveDependenciesInternal "$1" resolved unresolved

  eval "$2=($resolved)"
}

function resolveDependenciesInternal() {
  eval "$3+=($1)" # add to unresolved

  loadMeta $1
  zstyle -a ':ride:depend' $1 nodes

  for edge in $nodes; do
    # if edge not in resolved
    if [[ $(eval "echo \${$2[(i)$edge]}") -gt $(eval "echo \${#$2}") ]]; then
      # if edge in unresolved
      if [[ $(eval "echo \${$3[(i)$edge]}") -le $(eval "echo \${#$3}") ]]; then
        echo "Circular dependency detected: $1 -> $edge" >&2
        exit 1
      fi

      # recursive dependency check
      resolveDependenciesInternal "$edge" $2 $3
    fi
  done

  eval "$2+=($1)" # add to resolved
  eval "$3=(\"\${$3[@]/#%$1}\")" # remove from unresolved
}

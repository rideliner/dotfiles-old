source "${0:A:h}/modules.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"

function getModulesAndDependencies() {
  local _some _all _mixed

  getModules _mixed
  resolveModuleGroups _mixed _some

  if [[ ${#_some} -eq 0 ]]; then
    fail 'No modules or non-empty module groups have been set through zstyle.' ' '
    return $?
  fi

  resolveAllDependencies _some _all

  eval "$1=($_all)"
}

function resolveModuleGroups() {
  local -Ua splattered simple

  source "$DOTFILES_PATH/.groups"

  for mod (${(P)=1}); do
    if [[ $mod == '^'* ]]; then
      if zstyle -T ':ride:module-group' ${mod#^}; then
        warning "The module group $mod does not exist."
        continue
      fi

      zstyle -a ':ride:module-group' ${mod#^} simple
      if [[ $#simple == 0 ]]; then
        warning "The module group $mod is empty."
      else
        splattered+=($simple)
      fi
    else
      splattered+=($mod)
    fi
  done

  eval "$2=($splattered)"
}

function resolveAllDependencies() {
  local -a dependencies
  local -Ua total

  for mod (${(P)=1}); do
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

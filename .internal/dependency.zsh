source "${0:A:h}/modules.zsh"
source "$DOTFILES_PATH/.internal/log.zsh"

function getModulesResolved() {
  local _some _all _final

  getModules _some

  if [[ ${#_some} -eq 0 ]]; then
    fail 'No modules are enabled for this user/host setup.' ' '
    return $?
  fi

  resolveAllDependencies _some _all

  checkRequirements _all _final

  eval "$1=($_final)"
}

function checkRequirements() {
  local -a _resolvedRequirements
  local _reqs _valid

  for mod (${(P)=1}); do
    _valid="true"

    zstyle -a ":ride:$mod" requirements _reqs

    for req ($_reqs); do
      case $req in
        privileged )
          if [[ $UID != 0 ]]; then
            _valid="false"
            warning "The '$mod' module requires root privileges. Skipping." ' '
          fi
          ;;
        * )
          warning "'$req' is not a recognized requirement. Ignoring." ' '
      esac
    done

    if [[ $_valid == "true" ]]; then
      _resolvedRequirements+=($mod)
    fi
  done

  eval "$2=($_resolvedRequirements)"
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

  zstyle -a ":ride:$1" depend nodes

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

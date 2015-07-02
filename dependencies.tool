#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

zparseopts -D -E -A Args -- -all -dot -usage

if (( ${+Args[--usage]} )); then
  echo "Usage: $0 [--usage] [--dot|<module>*] [--all]"
  echo
  echo "--all"
  echo "    Show modules that don't have dependencies."
  echo "--dot"
  echo "    Load modules from ~/.dot.conf."
  echo "<module>*"
  echo "    Space separated list of modules to check the dependencies of."
else
  function {
    local i mods deps

    if (( ${+Args[--dot]} )); then
      source "$HOME/.dot.conf"
      getModules mods
    elif [[ $# -eq 0 ]]; then
      findAllModules mods
    else
      mods=($*)
    fi

    for mod in $mods; do
      resolveDependencies $mod deps

      if [[ ${+Args[--all]} -eq 1 || $#deps -gt 1 ]]; then
        echo "$mod"

        for ((i = $#deps - 2; i >= 0; i--)); do
          if [[ i -eq 0 ]]; then
            printf "\u2517"
          else
            printf "\u2523"
          fi

          echo "\u2501\u2501 ${deps[$((i + 1))]}"
        done

        echo
      fi
    done
  } $*
fi

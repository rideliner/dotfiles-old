#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

zparseopts -D -E -A Args -- -all -enabled -usage -help

if (( ${+Args[--usage]} || ${+Args[--help]} )); then
  echo "Usage: $0 [--usage|help] [--enabled|<module>*] [--all]"
  echo
  echo "--all"
  echo "    Show modules that don't have dependencies."
  echo "--enabled"
  echo "    Only check dependencies of enabled modules."
  echo "<module>*"
  echo "    Space separated list of modules to check the dependencies of."
else
  function {
    local i mods deps

    if (( ${+Args[--enabled]} )); then
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

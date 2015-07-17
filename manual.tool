#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/log.zsh"

zparseopts -D -E -A Args -- -usage -all

if (( ${+Args[--usage]} )); then
  echo "Usage: $0 [--usage] [<module>*]"
else
  function {
    local mods

    if (( ${+Args[--all]} )); then
      source "$DOTFILES_PATH/.internal/modules.zsh"
      findAllModules mods
    else
      mods=($*)
    fi

    if [[ $#mods -eq 0 ]]; then
      source "$DOTFILES_PATH/.man"
    else
      local mod file
      local majorRow="${(l:$COLUMNS::=:)}" minorRow="${(l:$COLUMNS::-:)}"

      for mod ($mods); do
        file="$DOTFILES_PATH/$mod/.man"

        echo
        echo "$majorRow"
        echo "${(l:$(( ($COLUMNS - $#mod) / 2 )):: :)}$mod"
        echo "$minorRow"
        echo

        if [[ -d $file:h ]]; then
          if [[ -f $file ]]; then
            source $file
          else
            warning "no manual file found" ' '
          fi
        else
          fail "not a module" ' '
        fi
      done
    fi
  } $*
fi

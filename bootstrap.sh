#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

function dotfiles() {
  local mods

  getModulesAndDependencies mods
  loadMeta mods

  for src ($DOTFILES_PATH/.internal/*.bootstrap(N) $DOTFILES_PATH/${^mods}/*.bootstrap(N)); do
    source "$src"

    status $? "run $src"
  done
}

function help() {
  if [[ $# -eq 0 ]]; then
    echo "Modules need to be set in ~/.dot"
    echo
    echo "Format:"
    echo "  zstyle ':ride' modules <mods>..."
    echo "ex. zstyle ':ride' modules tmux terminal rvm ruby"
    echo
    echo "Available modules:"

    local mods
    findAllModules mods

    for mod in $mods ; do
      echo "  $mod"
    done
  else
    local mod file

    for mod (${(s:,:)*//=/}); do
      file="$DOTFILES_PATH/$mod/.help"
      if [[ -d $file:h ]]; then
        if [[ -f $file ]]; then
          source $file
        else
          warning "Module '$mod' does not have a help file"
        fi
      else
        fail "'$mod' is not a module"
      fi
    done
  fi
}

source ~/.dot

zparseopts -D -E -A Args -- -help:: -usage

if (( ${+Args[--usage]} )); then
  echo "Usage: $0 [--usage|--help[=<module>[,<module>]*]]"
elif (( ${+Args[--help]} )); then
  help ${Args[--help]}
else
  dotfiles
fi

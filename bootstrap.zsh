#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

source ~/.dot

zparseopts -D -E -A Args -- -help:: -usage

if (( ${+Args[--usage]} )); then
  echo "Usage: $0 [--usage|--help[=<module>[,<module>]*]]"
elif (( ${+Args[--help]} )); then
  source "$DOTFILES_PATH/.help" ${Args[--help]}
else
  function {
    local mods src

    getModulesAndDependencies mods
    loadMeta mods

    mods=(.internal $mods)

    for src ($DOTFILES_PATH/${^mods}/*.bootstrap(N)); do
      moduleMode "\e[0;36mBOOT\e[0m" "${${src#$DOTFILES_PATH/}%.bootstrap}\n" "\u250F"

      source "$src"

      status $? "finished bootstrap" "\u2517"
    done
  }
fi

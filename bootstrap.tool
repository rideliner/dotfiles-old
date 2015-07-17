#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/log.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

function {
  local mods src name

  getModulesResolved mods

  mods=(.internal $mods)

  for src ($DOTFILES_PATH/${^mods}/*.bootstrap(N)); do
    name="${${src#$DOTFILES_PATH/}%.bootstrap}"
    moduleLog "\e[0;36mBOOT\e[0m" "$name\n" "\u250F"

    source "$src"

    status $? "finished $name bootstrap" "\u2517"
  done
}

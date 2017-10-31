#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/log.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

function {
  local mods src name bootstraps

  dotfiles/dependencies/getModulesResolved mods

  bootstraps=($DOTFILES_PATH/${^mods}/*.bootstrap(N))

  for src ($bootstraps(N)); do
    name="${${src#$DOTFILES_PATH/}%.bootstrap}"
    dotfiles/log/wrapper/start "BOOT" "$name"

    source "$src"

    dotfiles/log/wrapper/end "finished $name bootstrap"
  done

  $DOTFILES_PATH/bootstrap.tool
}

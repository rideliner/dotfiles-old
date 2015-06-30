#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

if [[ -s ~/.dot ]]; then
  source ~/.dot
else
  warning "$HOME/.dot does not exist or is empty." ' '
fi

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

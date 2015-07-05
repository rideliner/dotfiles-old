#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

if [[ -s ~/.dot.conf ]]; then
  source ~/.dot.conf
else
  warning "$HOME/.dot.conf does not exist or is empty." ' '
fi

function {
  local mods src name

  getModulesAndDependencies mods
  loadMeta mods

  mods=(.internal $mods)

  for src ($DOTFILES_PATH/${^mods}/*.bootstrap(N)); do
    name="${${src#$DOTFILES_PATH/}%.bootstrap}"
    moduleMode "\e[0;36mBOOT\e[0m" "$name\n" "\u250F"

    source "$src"

    status $? "finished $name bootstrap" "\u2517"
  done
}

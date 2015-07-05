#!/usr/bin/env zsh

source "${0:A:h}/../.internal/path.zsh"

file="$(whoami)@$(hostname -s)"

if [[ -f ~/.ssh/id_ed25519 ]]; then
  echo "ERROR: ~/.ssh/id_ed25519 already exists."
elif [[ -f $DOTFILES_PATH/keys/${file}.key ]]; then
  echo "ERROR: $DOTFILES_PATH/keys/${file}.key already exists."
else
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "$file" -o -a 100
  cp ~/.ssh/id_ed25519.pub $DOTFILES_PATH/keys/${file}.key
fi

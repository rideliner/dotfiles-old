#!/usr/bin/env zsh

source "${0:A:h}/../.internal/path.zsh"

file="$(whoami)@$(hostname -s)"

if [[ -f ~/.ssh/id_rsa ]]; then
  echo "ERROR: ~/.ssh/id_rsa already exists."
elif [[ -f $DOTFILES_PATH/keys/${file}.key ]]; then
  echo "ERROR: $DOTFILES_PATH/keys/${file}.key already exists."
else
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "$file" -o
  cp ~/.ssh/id_rsa.pub $DOTFILES_PATH/keys/${file}.key
fi

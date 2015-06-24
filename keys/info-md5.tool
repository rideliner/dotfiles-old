#!/usr/bin/env zsh

source "${0:A:h}/../.internal/path.zsh"

for key ($DOTFILES_PATH/keys/*.key(N)); do
  ssh-keygen -l -E md5 -f $key
done

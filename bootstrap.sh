#!/usr/bin/env zsh

function symlink_dotfiles {
  local REAL_PATH="${$(readlink -fnq $0)%/*}"

  local i patched
  for i in **/*.symlink(n) ; do
    patched=".${${i##*/}%\.*}"

    if [[ -d $i ]]; then
      ln -fns "${REAL_PATH}${DOTFILES}/${i}" "$HOME/$patched"
      echo "${REAL_PATH}${DOTFILES}/${i}\t$HOME/$patched"
    else
      ln -fs "${REAL_PATH}${DOTFILES}/${i}" "$HOME/$patched"
      echo "${REAL_PATH}${DOTFILES}/${i}\t$HOME/$patched"
    fi
  done
}

symlink_dotfiles
#!/usr/bin/env zsh

function user() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

function success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function link_file() {
  local src=$1 dst=$2

  local overwrite backup skip
  local action

  if [[ -f "$dst" || -d "$dst" || -L "$dst" ]]; then
    if [[ "$overwrite_all" == "false" && "$backup_all" == "false" &&  "$skip_all" == "false" ]]; then
      local currentSrc="$(readlink $dst)"

      if [[ "$currentSrc" == "$src" ]]; then
        skip="true"
      else
        user "File already exists: $(basename "$dst"), what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -s -k 1 "action"

        case "$action" in
          o )
            overwrite="true";;
          O )
            overwrite_all="true";;
          b )
            backup="true";;
          B )
            backup_all="true";;
          s )
            skip="true";;
          S )
            skip_all="true";;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [[ "$overwrite" == "true" ]]; then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [[ "$backup" == "true" ]]; then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [[ "$skip" == "true" ]]; then
      success "skipped $src"
    fi
  fi

  if [[ "$skip" != "true" ]]; then  # "false" or empty
    ln -s "$src" "$dst"
    success "linked $src to $dst"
  fi
}

function symlink_dotfiles() {
  local REAL_PATH="${$(readlink -fnq $0)%/*}"
  local src dst
  local overwrite_all=false backup_all=false skip_all=false

  for src in **/*.symlink(n) ; do
    dst="$HOME/.$(basename "${src%\.*}")"
    src="${REAL_PATH}/${src}"

    link_file "$src" "$dst"
  done
}

symlink_dotfiles

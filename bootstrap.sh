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

function dotfiles() {
  local REAL_PATH="${$(readlink -fnq $0)%/*}"

  if [[ $# != 0 ]]; then
    echo "Modules need to be set in ~/.dot"
    echo
    echo "Format:"
    echo "  zstyle ':ride' modules <mods>..."
    echo "ex. zstyle ':ride' modules tmux terminal rvm ruby"
    echo
    echo "Available modules:"

    local -aU mods

    mods+=($REAL_PATH/*.symlink(N:t:r))
    mods+=($REAL_PATH/*/*.symlink(N:h:t))
    mods+=($REAL_PATH/*/*.bootstrap(N:h:t))
    for mod in $mods ; do
      echo "  $mod"
    done
  else
    local src dst links boots
    local overwrite_all=false backup_all=false skip_all=false

    local -U mods mod_links mod_dirs

    zstyle -a ':ride' modules 'mods'

    mods=(zsh $mods)

    mod_links=($REAL_PATH/${^mods}.symlink(N))
    mod_dirs=($REAL_PATH/${^mods}/*.symlink(N))
    boots=($REAL_PATH/${^mods}/*.bootstrap(N))
    links=($mod_links $mod_dirs)

    for src in $links ; do
      dst="$HOME/.$(basename "${src%\.*}")"

      link_file "$src" "$dst"
    done

    for src in $boots ; do
      source "$src"
    done
  fi
}

source ~/.dot
dotfiles $*

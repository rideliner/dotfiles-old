#!/usr/bin/env zsh

function user() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

function success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function fail() {
  printf "\r\033[2k  [ \033[0;31mFAIL\033[0m ] $1\n"
}

function warning() {
  printf "\r\033[2k  [ \033[0;33mWARN\033[0m ] $1\n"
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

    mods+=($REAL_PATH/*/*.symlink(N:h:t))
    mods+=($REAL_PATH/*/*.bootstrap(N:h:t))
    mods+=($REAL_PATH/*/*.zsh(N:h:t))
    for mod in $mods ; do
      echo "  $mod"
    done
  else
    local mod src dst link boots modules
    local overwrite_all=false backup_all=false skip_all=false

    local -U mods

    zstyle -a ':ride' modules 'mods'

    mods=(zsh $mods)

    for src ($REAL_PATH/${^mods}/.meta(N)) ; do
      source $src
    done

    modules=($REAL_PATH/${^mods}/*.symlink(N))
    boots=($REAL_PATH/${^mods}/*.bootstrap(N))

    for src in $modules ; do
      mod=${src:h:t}
      link=${src:t:r}

      zstyle -T ":ride:symlink:$mod" $link
      origLink=$?
      zstyle -T ":ride:symlink:override:$mod" $link
      overLink=$?

      if [ $overLink -eq 1 ]; then
        zstyle -s ":ride:symlink:override:$mod" $link dst
      elif [ $origLink -eq 1 ]; then
        zstyle -s ":ride:symlink:$mod" $link dst
      else
        dst="~/.$link"
      fi

      link_file "$src" "$dst"
    done

    for src in $boots ; do
      source "$src"

      if [[ $? == 0 ]]; then
        success "run $src"
      else
        fail "run $src"
      fi
    done
  fi
}

source ~/.dot
dotfiles $*

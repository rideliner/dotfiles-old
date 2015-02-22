#!/usr/bin/env zsh

source "${0:A:h}/.internal/path.zsh"
source "$DOTFILES_PATH/.internal/mode.zsh"
source "$DOTFILES_PATH/.internal/dependency.zsh"

function link_file() {
  local src=$1 dst="${2:a}"

  local overwrite backup skip
  local action

  if [[ -f "$dst" || -d "$dst" || -L "$dst" ]]; then
    if [[ "$overwrite_all" == "false" && "$backup_all" == "false" &&  "$skip_all" == "false" ]]; then
      local currentSrc="${dst:A}"

      if [[ "$currentSrc" == "$src" ]]; then
        skip="true"
      else
        user "File already exists: ${dst:t}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
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
    success "linked $src to ${dst:a}"
  fi
}

function dotfiles() {
  if [[ $# != 0 ]]; then
    echo "Modules need to be set in ~/.dot"
    echo
    echo "Format:"
    echo "  zstyle ':ride' modules <mods>..."
    echo "ex. zstyle ':ride' modules tmux terminal rvm ruby"
    echo
    echo "Available modules:"

    local mods
    findAllModules mods

    for mod in $mods ; do
      echo "  $mod"
    done
  else
    local mod src dst link boots modules
    local overwrite_all=false backup_all=false skip_all=false

    local mods
    getModulesAndDependencies mods
    loadMeta mods

    modules=($DOTFILES_PATH/${^mods}/*.symlink(N))
    boots=($DOTFILES_PATH/${^mods}/*.bootstrap(N))

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
        dst="$HOME/.$link"
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
dotfiles

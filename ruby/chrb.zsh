#!/usr/bin/env zsh

function chrb/usage() {
  echo "Usage:"
  echo "  $1 <ruby>"
  echo "  $1 --current"
  echo "  $1 --default"
  echo "  $1 --default <ruby>"
  return 1
}

function chrb() {
  zparseopts -E -D -a opts -- -default -current

  if [[ $# == 0 && $#opts == 1 ]]; then
    if [[ ${opts[(i)--default]} -le ${#opts} ]]; then
      if [[ -z "$DOTFILES_RUBY" ]]; then
        echo "No default ruby has been set"
      else
        echo "The default ruby is $DOTFILES_RUBY"
        return 0
      fi
    elif [[ ${opts[(i)--current]} -le ${#opts} ]]; then
      if [[ -z "$DOTFILES_RUBY" ]]; then
        echo "No ruby is currently enabled"
      else
        echo "$DOTFILES_RUBY"
        return 0
      fi
    else
      chrb/usage "$0"
    fi
    return 1
  elif [[ $# != 1 ]]; then
    chrb/usage "$0"
    return 1
  fi

  if (( ! $+commands[$1] )); then
    echo "$1 does not exist; cancelling..."
    return 1
  elif [[ $1 == 'ruby' ]]; then
    echo "Changing ruby to $1 would result in recursion; cancelling..."
    return 1
  else
    dotfiles/ruby/remove_from_gem_path

    export DOTFILES_RUBY="$1"
    dotfiles/terminal/update_rprompt

    local new_p
    dotfiles/ruby/add_to_gem_path 'new_p'

    # at this point it can only be --default
    if [[ $#opts == 1 ]]; then
      echo "Setting default ruby to $1"

      if [[ -e "$DOTFILES_PATH/ruby/ruby.path" ]]; then
        rm "$DOTFILES_PATH/ruby/ruby.path"
      fi
      cat << EOF > "$DOTFILES_PATH/ruby/ruby.path"
if [[ -z "\$DOTFILES_RUBY" || "\$DOTFILES_RUBY" == "$1" ]]; then
  export DOTFILES_RUBY="$1"
  export GEM_HOME=($GEM_HOME)
  export path=($new_p \$path)
else
  source "\${0:A:h}/gem_path.zsh"
  dotfiles/ruby/add_to_gem_path
fi
EOF
    else
      echo "Changing ruby to $1"
    fi
  fi
}

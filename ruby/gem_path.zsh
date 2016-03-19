
function dotfiles/ruby/gem_path() {
  local gem_p="$($DOTFILES_RUBY -e 'print Gem.user_dir')"
  local home_p="$gem_p/bin"

  eval "$1=($home_p)"

  unset GEM_HOME
  export GEM_HOME="$gem_p"
}

function dotfiles/ruby/remove_from_gem_path() {
  if [[ ! -z "$DOTFILES_RUBY" ]]; then
    local old_p
    dotfiles/ruby/gem_path 'old_p'

    for p in $old_p; do
      export path=(${(@)path:#$p})
    done
  fi
}

function dotfiles/ruby/add_to_gem_path() {
  local total_p
  dotfiles/ruby/gem_path 'total_p'

  export path=($total_p $path)

  if [[ $# == 1 ]]; then
    eval "$1=($total_p)"
  fi
}

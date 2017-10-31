source "${0:A:h}/path.zsh"
source "$DOTFILES_PATH/.groups"

function dotfiles/groups/getMine() {
  zstyle -a ":ride" groups $1
}

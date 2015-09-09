
function updateDotfiles() {
  cd $DOTFILES_PATH
  git pull origin master
  cd -
}

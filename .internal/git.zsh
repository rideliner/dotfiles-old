
function doDotfilesUseGit() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}

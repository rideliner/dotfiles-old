
function() {
  if (( $+commands[keychain] )); then
    keychain --quiet --stop others
    eval $(keychain --eval --quiet)

    local -a keys
    zstyle -a ':ride:ssh' identities keys

    # load all keys
    for key in $keys; do
      keychain --nogui --quiet $key
    done
  fi
}

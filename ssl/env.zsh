if [[ $UID != 0 ]]; then
  source "$DOTFILES_PATH/.internal/resolve.zsh"

  function() {
    typeset -UTx SSL_CERT_DIR ssl_cert_dir

    local ssl_path
    zstyle -s ':ride:ssl:symlink:*' path ssl_path

    if [[ ! -z "$ssl_path" ]]; then
      dotfileSymlinkResolve ssl_path 'path' 'ssl'
      ssl_cert_dir+=($ssl_path)
    fi
  }
fi

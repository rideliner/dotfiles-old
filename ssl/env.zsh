if [[ $UID != 0 ]]; then
  function() {
    typeset -UTx SSL_CERT_DIR ssl_cert_dir

    local ssl_path
    zstyle -s ':ride:ssl:symlink:*' path ssl_path

    ssl_cert_dir+=($ssl_path)
  }
fi

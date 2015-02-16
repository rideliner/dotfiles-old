typeset -UTx SSL_CERT_DIR ssl_cert_dir

ssl_cert_dir+=("${$(readlink -fnq $0)%/*}")


# If clang is present, use it as the default C/C++ compiler
(( $+commands[clang] )) && export CC="$commands[clang]"
(( $+commands[clang++] )) && export CXX="$commands[clang++]"

case `hostname -f` in
  marple* )
    # Boost
    export BOOST_ROOT=/usr
    ;;
  *.cs.colostate.edu )
    # OpenMPI
    typeset -UTx LD_LIBRARY_PATH ld_library_path

    path+=(/usr/lib64/openmpi/bin)
    ld_library_path+=(/usr/lib/openmpi/lib)
esac

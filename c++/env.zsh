
# If clang is present, use it as the default C/C++ compiler
(( $+commands[clang] )) && export CC="$commands[clang]"
(( $+commands[clang++] )) && export CXX="$commands[clang++]"

case $DOTFILES_FULL_HOST in
  marple* )
    # Boost
    export BOOST_ROOT=/usr
    ;;
esac

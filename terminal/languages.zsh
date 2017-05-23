
function languages() {
  echo "Ruby:"; languages/ruby "\t"
  echo "C:"; languages/c "\t"
  echo "C++:"; languages/c++ "\t"
  echo "Go:"; languages/go "\t"
  echo "Java:"; languages/java "\t"
  echo "Python:"; languages/python "\t"
}

function languages/ruby/impl() {
  if (( $+commands[$1] )); then
    echo "$2$($1 --version | cut -d' ' -f -2) $([[ $1 == $DOTFILES_RUBY || */$1 == $DOTFILES_RUBY ]] && echo "(*)")"
  fi
}

function languages/ruby() {
  languages/ruby/impl mri $1
  languages/ruby/impl rbx $1
}

function languages/c/impl() {
  if (( $+commands[$1] )); then
    echo "$2$($1 --version | head -n1 | cut -d' ' -f1,3) $([[ $CC == $1 || $CC == */$1 ]] && echo "(CC)")"
  fi
}

function languages/c() {
  languages/c/impl clang $1
  languages/c/impl gcc $1
}

function languages/c++/impl() {
  if (( $+commands[$1] )); then
    echo "$2$($1 --version | head -n1 | cut -d' ' -f1,3) $([[ $CXX == $1 || $CXX == */$1 ]] && echo "(CXX)")"
  fi
}

function languages/c++() {
  languages/c++/impl clang++ $1
  languages/c++/impl g++ $1
}

function languages/go() {
  echo "$1$(go version | cut -d' ' -f3 | sed "s/go/go /")"
}

function languages/java() {
  echo "$1$(java -version 2>&1 | head -n1 | cut -d ' ' -f1,3 | sed "s/\"//g")"
}

function languages/python/impl() {
  if (( $+commands[$1] )); then
    echo "$2$($1 --version 2>&1 | sed "s/P/p/") $([[ ${commands[$1]:A} == ${commands[python]:A} ]] && echo "(*)")"
  fi
}

function languages/python() {
  languages/python/impl python2 $1
  languages/python/impl python3 $1
}

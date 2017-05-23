
function languages() {
  echo "Ruby:"; languages/ruby "\t"
  echo "C:"; languages/c "\t"
  echo "C++:"; languages/c++ "\t"
  echo "Go:"; languages/go "\t"
  echo "Java:"; languages/java "\t"
  echo "Python:"; languages/python "\t"
}

function languages/impl() {
  if (( $+commands[$1] )); then
    echo "$3$(languages/$2/impl "$commands[$1]")"
  fi
}

function languages/ruby/impl() {
  echo "$($1 --version | cut -d' ' -f -2)$([[ $1 == $DOTFILES_RUBY || $1 == */$DOTFILES_RUBY ]] && echo " (*)")"
}

function languages/ruby() {
  languages/impl mri ruby $1
  languages/impl rbx ruby $1
}

function languages/c/impl() {
  echo "$($1 --version | head -n1 | cut -d' ' -f1,3) $([[ $1 == $CC || $1 == */$CC ]] && echo "(CC)")"
}

function languages/c() {
  languages/impl clang c $1
  languages/impl gcc c $1
}

function languages/c++/impl() {
  echo "$($1 --version | head -n1 | cut -d' ' -f1,3) $([[ $1 == $CXX || $1 == */$CXX ]] && echo "(CXX)")"
}

function languages/c++() {
  languages/impl clang++ c++ $1
  languages/impl g++ c++ $1
}

function languages/go/impl() {
  echo "$($1 version | cut -d' ' -f3 | sed "s/go/go /")"
}

function languages/go() {
  languages/impl go go $1
}

function languages/java/impl() {
  echo "$($1 -version 2>&1 | head -n1 | cut -d' ' -f1,3 | sed "s/\"//g")"
}

function languages/java() {
  languages/impl java java $1
}

function languages/python/impl() {
  echo "$($1 --version 2>&1 | sed "s/P/p/") $([[ ${1:A} == ${commands[python]:A} ]] && echo "(*)")"
}

function languages/python() {
  languages/impl python2 python $1
  languages/impl python3 python $1
}

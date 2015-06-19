
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U add-zsh-hook

function prompt_color() {
  local color

  zstyle -s ':ride:config:terminal:prompt' color color
  [[ -z $color ]] && color='white'

  echo -e "$color"
}

function prompt_character() {
  local char

  zstyle -s ':ride:config:terminal:prompt' char char

  [[ -z $char || $(tty) > "/dev/tty" ]] && zstyle -s ':ride:config:terminal:prompt' console-char char
  [[ -z $char ]] && char='$'

  echo -e "%{$fg_bold[$(prompt_color)]%}$char"
}

PROMPT='$(prompt_character) %{$fg_bold[yellow]%}'

ls_on_chdir() { ls; }
reset_foreground() { echo -ne "$reset_color"; }

add-zsh-hook chpwd ls_on_chdir
add-zsh-hook preexec reset_foreground

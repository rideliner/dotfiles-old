
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U add-zsh-hook

function prompt_character() {
  local char color

  zstyle -s ':ride:config:terminal:prompt' char char
  [[ -z $char ]] && char='$'

  zstyle -s ':ride:config:terminal:prompt' color color
  [[ -z $color ]] && color='white'

  echo -e "%{$fg_bold[$color]%}$char"
}

PROMPT='$(prompt_character) %{$fg_bold[yellow]%}'

ls_on_chdir() { ls; }
reset_foreground() { echo -ne "$reset_color"; }

add-zsh-hook chpwd ls_on_chdir
add-zsh-hook preexec reset_foreground

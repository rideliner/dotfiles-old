
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U add-zsh-hook

function prompt_color() {
  local color

  zstyle -s ':ride:terminal:prompt' color color
  [[ -z $color ]] && color='white'

  echo -e "$color"
}

function prompt_character() {
  local char

  zstyle -s ':ride:terminal:prompt' char char

  [[ -z $char || $(tty) > "/dev/tty" ]] && zstyle -s ':ride:terminal:prompt' console-char char
  [[ -z $char ]] && char='$'

  echo -e "%{$fg_bold[$(prompt_color)]%}$char"
}

PROMPT='$(prompt_character) '

# cut down the time between prompts by caching RPROMPT
# this is necessary because of the startup time for rbx
function dotfiles/terminal/update_rprompt() {
  RPROMPT="$(ruby -v | cut -d ' ' -f -2)"
}
dotfiles/terminal/update_rprompt

ls_on_chdir() { ls; }

add-zsh-hook chpwd ls_on_chdir

zle_highlight=(default:fg=yellow,bold)

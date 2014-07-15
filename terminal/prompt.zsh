
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -U add-zsh-hook

# my personal color scheme:

#  color  | text color  | bold color
#---------+-------------+-------------
# black   |   #XXXXXX   |   #XXXXXX
# red     |   #XXXXXX   |   #XXXXXX
# green   |   #XXXXXX   |   #XXXXXX
# yellow  |   #XXXXXX   |   #XXXXXX
# blue    |   #XXXXXX   |   #XXXXXX
# magenta |   #XXXXXX   |   #XXXXXX
# cyan    |   #XXXXXX   |   #XXXXXX
# white   |   #XXXXXX   |   #XXXXXX

function prompt_character() {
  if [[ "`id -u`" -eq 0 ]]; then
    echo -e "%{$fg_bold[magenta]%} "
  else
    echo -e "%{$fg_bold[cyan]%}✝ "
  fi
}

PROMPT='$(prompt_character) %{$fg_bold[yellow]%}'

ls_on_chdir() { ls; }
reset_foreground() { echo -ne "$reset_color"; }

add-zsh-hook chpwd ls_on_chdir
add-zsh-hook preexec reset_foreground


if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }

  function zle-line-finish() {
    echoti rmkx
  }

  zle -N zle-line-init
  zle -N zle-line-finish
fi

# [Home] - go to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi

# [End] - go to end of line
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line
fi

# [Space] - do history expansion
bindkey ' ' magic-space

# [Ctrl-RightArrow] - move forward a word
bindkey '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward a word
bindkey '^[[1;5D' backward-word

# [Shift-Tab] - move backwards through completion menu
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey '^?' backward-delete-char

# [Delete] - delete forward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# [Up-Arrow] - history backward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
fi

# [Down-Arrow] - history forward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  bindkey "${terminfo[kcud1]}" history-beginning-search-forward
fi

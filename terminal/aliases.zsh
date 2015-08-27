
alias sudo='sudo '
alias reload!='source ~/.zshrc'

alias mkdir='mkdir -p'
alias md='mkdir'
alias rd='rmdir'
alias d='dirs -v | head -10'
alias disk='du -sch *(N) | sort -h'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias /='cd /'

alias clear='(( $+TMUX )) && tmux send-keys -R \; clear-history || echo -ne "\033c"'
alias exit='(( $+TMUX )) && tmux kill-pane \; select-layout || \exit'
alias make='make -j $PROCESSORS'

alias ls='ls --color=tty'

(( $+commands[htop] )) && alias top='htop'

alias path='echo -e ${PATH//:/\\n}'

alias todo='grep -R "TODO" *'
alias ping='ping -c4'
alias pong='ping 8.8.8.8'
alias my-ip='curl icanhazip.com'

alias @='pwd'


if (( $+commands[rdesktop] )); then
  function rdesktop() {
    local x_res y_res
    local pixels max_pixels
    local data res

    data=`xrandr | grep '*'`
    max_pixels=-1

    for res in ${(@f)data}; do
      if [[ $res =~ '([0-9]+)x([0-9]+)' ]]; then
        pixels=$(( $match[1] * $match[2] ))
        if [[ $pixels -gt $max_pixels ]]; then
          max_pixels=$pixels
          x_res=$match[1]
          y_res=$match[2]
        fi
      fi
    done

    # TODO a few pixels may need to be taken off to account for borders
    # the primary monitor may need a few more pixels taken off

    $commands[rdesktop] "$@" "-g ${x_res}x${y_res}"
  }

  alias elab='rdesktop elab.business.colostate.edu -d BUSINESS -u BUSINESS\\Nathan.B.Currier14'
fi

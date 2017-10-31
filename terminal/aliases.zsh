
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
alias my-ipv6='curl ipv6.icanhazip.com'
alias my-ipv4='curl ipv4.icanhazip.com'

alias @='pwd'


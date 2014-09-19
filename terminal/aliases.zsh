
alias sudo='sudo '
alias reload!='source ~/.zshrc'

alias mkdir='mkdir -p'
alias md='mkdir'
alias rd='rmdir'
alias d='dirs -v | head -10'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias /='cd /'

alias clear='[ "$TMUX" != "" ] && tmux send-keys -R \; clear-history || echo -ne "\033c"'
alias make='make -j $PROCESSORS'

alias ls='ls --color=tty'

alias top='htop'

alias path='echo -e ${PATH//:/\\n}'

alias todo='grep -R "TODO" *'
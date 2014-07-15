
alias sudo='sudo '
alias reload!='source ~/.zshrc'

alias md='mkdir -p'
alias rd='rmdir'
alias d='dirs -v | head -10'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias /='cd /'

alias clear='echo -ne "\033c"'
alias make='make -j 4'

alias ls='ls --color=tty'

alias top='htop'

alias path='echo -e ${PATH//:/\\n}'

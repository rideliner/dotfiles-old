
GREP_OPTIONS=

for PATTERN in .cvs .git .hg .svn; do
  GREP_OPTIONS+="--exclude-dir=$PATTERN "
done

GREP_OPTIONS+="--color=auto"
export GREP_COLOR='1;32' # '37;45' alternative?

alias grep="grep $GREP_OPTIONS"

unset GREP_OPTIONS

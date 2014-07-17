
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

GREP_OPTIONS=
for PATTERN in .cvs .git .hg .svn; do
  GREP_OPTIONS+="--exclude-dir=$PATTERN "
done

GREP_OPTIONS+="--color=auto"
export GREP_OPTIONS="$GREP_OPTIONS"
export GREP_COLOR='1;32' # '37;45' alternative?

# keep only the first occurences
typeset -gU cdpath fpath mailpath path

export PAGER="less"
export LESS="-R -F"

export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export LANGUAGE=en_US.utf8

export PROCESSORS="$(grep -c '^processor' /proc/cpuinfo)"

# URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

  setopt long_list_jobs         # list jobs in the long format
  setopt auto_resume            # attempt to resume existing jobs
  setopt notify                 # report status of background jobs immediately
unsetopt bg_nice                # don't nice background tasks
unsetopt hup                    # don't kill jobs on shell exit
unsetopt hist_beep              # don't beep on invalid history entry
unsetopt list_beep              # don't beep on ambiguous completion
  setopt local_options          # allow functions to have local options
  setopt local_traps            # allow functions to have local traps
  setopt hist_verify            #
  setopt hist_ignore_dups       # don't add to history if same as previous
  setopt hist_save_no_dups      #
  setopt hist_reduce_blanks     # remove blanks from commands
unsetopt share_history          # don't share history between sessions
  setopt extended_history       # add timestamps to history
unsetopt check_jobs             # don't repot on jobs when shell exit
  setopt auto_cd                # cd if cmd doesn't exist and directory does
  setopt auto_pushd             # cd pushes the old directory onto the stack
  setopt pushd_ignore_dups      # don't push multiple copies of a directory
  setopt pushd_silent           # don't print the stack after pushd/popd
  setopt pushd_to_home          # pushd witout args acts like `pushd $HOME`
  setopt cdable_vars            # precede cd command with ~ as a last resort
  setopt auto_name_dirs         #
  setopt multios                #
  setopt extended_glob          #
  setopt pushdminus             #
unsetopt clobber                #
unsetopt case_glob              # make globbing case insensitivee
  setopt rc_quotes              # allow '...''...' to signify a single quote
  setopt interactive_comments   # allow # comments in interactive shell
  setopt prompt_subst           # allow substitution in PROMPT


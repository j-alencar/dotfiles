HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

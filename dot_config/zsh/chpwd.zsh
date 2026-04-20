autoload -U zmv
autoload -U add-zsh-hook

_chpwd_ls() { ls --color=auto }
add-zsh-hook chpwd _chpwd_ls

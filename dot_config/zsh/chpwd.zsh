autoload -U zmv
autoload -U add-zsh-hook

_chpwd_ls() { timeout 0.2 ls --color=auto 2>/dev/null || true }
add-zsh-hook chpwd _chpwd_ls

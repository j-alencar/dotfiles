bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5A' up-line-or-history
bindkey '\e[1;5B' down-line-or-history
bindkey '\e[3;5~' kill-word

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word

bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line

bindkey '\e[1;5H' beginning-of-buffer-or-history
bindkey '\e[1;5F' end-of-buffer-or-history

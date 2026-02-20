alias ,clpy='just clean'
alias ,test='just test'
alias ,cov='just cov'
alias ,lint='just lint'
alias ,typing='just typing'
alias ,check='just check-all'
alias ,serve='just serve'
alias ,req='just req'
alias ,browser='just browser'
alias ,update='just update'
alias ,install='just install'
alias ,clean='just clean'
alias ,fresh='just fresh'
alias ,lock='just lock'
alias ,prewarm='just prewarm'

,uvls() {
    uv lock "$@" && uv sync "$@"
}

,jinit() {
    cp "${XDG_CONFIG_HOME:-$HOME/.config}/just/project.justfile" justfile
    if [ -d .git ]; then
        grep -qxF 'justfile' .gitignore 2>/dev/null || echo 'justfile' >> .gitignore
    fi
}

,pcinit() {
    cp ~/.config/git/pre-commit-config.yaml .pre-commit-config.yaml
}

,venvinit() {
    echo 'layout venv' > .envrc
    direnv allow
}

alias ,dockerd='sudo systemctl start docker'
alias ,clip='xclip -selection clipboard'

,ldocker() {
    systemctl is-active --quiet docker || sudo systemctl start docker
    lazydocker
}

,st() {
    pgrep -x syncthing >/dev/null || syncthing serve --no-browser &>/dev/null &
    disown
}

,whatdo() {
    echo "tldr <command>        — community-maintained help pages"
    echo "curl cheat.sh/<cmd>   — cheat sheets from the terminal"
    echo "eg <command>          — useful examples for commands"
    echo "firefox https://devhints.io/<topic>  — devhints.io cheatsheets"
}

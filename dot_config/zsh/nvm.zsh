export NVM_DIR="$HOME/.nvm"

_nvm_load() {
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

nvm() { _nvm_load && nvm "$@" }
node() { _nvm_load && node "$@" }
npm() { _nvm_load && npm "$@" }
npx() { _nvm_load && npx "$@" }

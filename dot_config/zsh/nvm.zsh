export NVM_DIR="$HOME/.nvm"

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

    # Eagerly add default nvm node bin to PATH so nvm-installed tools
    # are found before Windows npm PATH entries
    _nvm_default_bin="$NVM_DIR/alias/default"
    if [[ -f "$_nvm_default_bin" ]]; then
        _nvm_default_version=$(<"$_nvm_default_bin")
        while [[ -f "$NVM_DIR/alias/$_nvm_default_version" ]]; do
            _nvm_default_version=$(<"$NVM_DIR/alias/$_nvm_default_version")
        done
        _nvm_bin="$NVM_DIR/versions/node/$_nvm_default_version/bin"
        [[ -d "$_nvm_bin" ]] && path=("$_nvm_bin" $path)
    fi
    unset _nvm_default_bin _nvm_default_version _nvm_bin
fi

# Bun-packaged opencode binaries (opencode-linux-x64*) SIGBUS on WSL2 kernel 5.15 due to
# incompatible mmap behaviour. The curl-installed binary at ~/.opencode/bin/opencode is a
# standard glibc build that works. OPENCODE_BIN_PATH tells the npm launcher to use it instead.
if [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
    [[ -x "$HOME/.opencode/bin/opencode" ]] && export OPENCODE_BIN_PATH="$HOME/.opencode/bin/opencode"
fi

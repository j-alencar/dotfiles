# Snippets

Copy these, then cut what the case does not need.

## Fail fast on a missing binary

```bash
need() {
  command -v "$1" >/dev/null && return 0
  printf 'devex: %s not found -- install it with: %s\n' "$1" "$2" >&2
  return 127
}
```

Use `|| exit` in a script, `|| return` in anything sourced:

```bash
need ffprobe 'apt-get install ffmpeg' || exit
need jq 'apt-get install jq' || exit
```

127 is the shell's own code for "command not found", so callers and CI read it the same way.

## Wrap a command without taking anything away

```bash
#!/usr/bin/env bash

need uv 'https://docs.astral.sh/uv/getting-started/installation/' || exit

exec uv run pytest "$@"
```

`exec` replaces the shell, so the terminal, both streams, signals and the exit code belong to
pytest. `"$@"` keeps `-k`, `-x` and `--pdb` reachable.

## Probe a value instead of describing it

```bash
ffmpeg -version | awk 'NR == 1 { print $3 }'   # want 7.0 or newer
nproc --all                                    # lscpu -p=cpu | grep -cv '^#' where nproc is missing
echo "workers=$(( $(nproc --all) / 2 ))"
```

## Pin the whole toolchain in one file

`mise.toml`:

```toml
[tools]
python = "3.12"
node = "20"
ffmpeg = "7"

[env]
XYZZY_MODE = "foo"

[tasks.up]
run = "docker compose up -d xyzzy"

[tasks.render]
depends = ["up"]
run = "uv run python -m render"
```

The README then carries one block and a toolchain list:

```bash
mise trust && mise run render
```

```markdown
## Required toolchain

- [Docker Engine](https://docs.docker.com/engine/install/)
- [mise](https://mise.jdx.dev/getting-started.html)
```

## Ship the box when the host cannot be trusted

`Vagrantfile`:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.provision "shell", inline: <<~SHELL
    apt-get update -qq
    apt-get install -y ffmpeg xyzzy
    install -m 0644 /vagrant/xyzzy.conf /etc/xyzzy.conf
  SHELL
end
```

```bash
vagrant up && vagrant ssh -c 'make render'
```

`xyzzy.conf` is committed with `mode = foo` and `frobnicate = true` already set, so the settings
are never something a reader has to know about.

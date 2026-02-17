set dotenv-load

PORT := env("PORT", "8000")
ARGS_TEST := env("_UV_RUN_ARGS_TEST", "")
ARGS_SERVE := env("_UV_RUN_ARGS_SERVE", "")


@_:
    just --list


[group('qa')]
test *args:
    uv run {{ ARGS_TEST }} -m pytest {{ args }}

_cov *args:
    uv run -m coverage {{ args }}

[group('qa')]
@cov:
    just _cov erase
    just _cov run -m pytest tests
    just _cov combine
    just _cov report
    just _cov html

[group('qa')]
lint *args:
    uvx ruff check {{ args }}
    uvx ruff format {{ args }}

[group('qa')]
typing *args:
    uvx ty check --python .venv src {{ args }}

[group('qa')]
check-all: lint cov typing


[group('run')]
serve *args:
    uv run {{ ARGS_SERVE }} -m fastapi dev --port {{ PORT }} {{ args }}

[group('run')]
req path="" *args:
    @just _http {{ args }} http://127.0.0.1:{{ PORT }}/{{ path }}

_http *args:
    uvx --from httpie http {{ args }}

[group('run')]
browser:
    uv run -m webbrowser -t http://127.0.0.1:{{ PORT }}


[group('lifecycle')]
update *args:
    uv sync --upgrade {{ args }}

[group('lifecycle')]
install *args:
    uv sync {{ args }}

[group('lifecycle')]
lock *args:
    uv lock {{ args }}

[group('lifecycle')]
prewarm *args:
    uv cache prewarm {{ args }}

[group('lifecycle')]
clean:
    #!/usr/bin/env bash
    set -euo pipefail
    rm -rf .venv .pytest_cache .mypy_cache .ruff_cache .coverage htmlcov
    find . -type d -name '*egg-info' -exec rm -rf {} + 2>/dev/null || true
    find . -type d -name '__pycache__' | while read -r cache_dir; do
        parent="$(dirname "$cache_dir")"
        count=$(find "$parent" -maxdepth 1 -mindepth 1 | wc -l)
        if [[ "$count" -eq 1 ]]; then
            rm -rf "$parent"
        else
            rm -rf "$cache_dir"
        fi
    done

[group('lifecycle')]
fresh: clean install

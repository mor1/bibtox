_default:
    @just --list

# smoke test
[group("test")]
run:
    uv run -- ./src/bib2html --debug ./test/bibinputs.json

# compare results
[group("test")]
compare:
    diff -us test/gold <(just run 2>/dev/null)

# update environment
[group("env")]
sync:
    source .envrc

# update lockfile
[group("env")]
lock:
    uv lock

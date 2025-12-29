_default:
    @just --list

dif := "git diff --minimal --no-index --word-diff=color"

# smoke test
[group("test")]
run-bib:
    uv run -- ./bibtox --debug ./test/bibinputs.json

[group("test")]
run-html:
    uv run -- ./bibtox --debug --html ./test/bibinputs.json

# compare results
[group("test")]
compare:
    {{dif}} test/gold-bib <(just run-bib 2>/dev/null) || true
    {{dif}} test/gold-html <(just run-html 2>/dev/null) || true

# update environment
[group("env")]
sync:
    source .envrc

# update lockfile
[group("env")]
lock:
    uv lock

# validate bib files
[group("test")]
[no-cd]
validate tgt:
    biber --tool --validate-datamodel {{file_stem(tgt)}}.bib

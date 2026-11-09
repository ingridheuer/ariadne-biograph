# Working agreements for Claude

## Read first
- `docs/design/DESIGN.md` is the source of truth for vision, principles, architecture, stack and conventions. Read it before proposing changes.
- `docs/design/decisions.md` records why things are the way they are. It is **append-only**: never edit past entries. Add a new one that supersedes them.
- `docs/design/specs/` holds component specs. Write a spec from `TEMPLATE.md` when a component's phase starts, before writing its code.

## How we work
- The repo owner is learning as much as building. **Explain architecture decisions and their trade-offs before implementing**, and prefer plan mode for anything non-trivial.
- Talk to the owner in **Spanish**, using English technical terms where natural. Everything committed to the repo (code, docs, commits) is in **English**.
- Never commit to `main`. Work on a branch (`phase-N/<topic>` or `feat/<topic>`) and open small, reviewable PRs.
- If a change affects design, update `DESIGN.md` in the same PR. If it reverses or makes a hard-to-reverse choice, add an entry to `decisions.md`.
- Prefer simple and cheap solutions. For anything that creates cloud resources, state the estimated cost and how to shut it down.

## Code conventions
- Python 3.12, `src/` layout, managed with `uv`.
- Type hints on public functions. Code must be ruff-clean.
- No hardcoded paths, seeds or hyperparameters: they belong in `configs/`.
- Notebooks only call package code. Logic lives in `src/ariadne_biograph/`.
- Data goes in `data/` and artifacts in `artifacts/`. Both are git-ignored and rebuilt by command.
- Components exchange standard biological IDs, never tensor indices.

## Commands
```bash
make install   # uv sync
make check     # ruff lint + format check + pytest (what CI runs)
make format    # auto-format and fix
```

## Domain notes
- Evaluation must use degree-aware negative sampling and stratified reporting. See DESIGN §5. Always compare models against the degree baseline.
- The same core subgraph is used by the model, Neo4j and the UI. Do not let them diverge.

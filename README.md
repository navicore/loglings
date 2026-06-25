# loglings

```
    _             _ _
   | | ___   __ _| (_)_ __   __ _ ___
   | |/ _ \ / _` | | | '_ \ / _` / __|
   | | (_) | (_| | | | | | | (_| \__ \
   |_|\___/ \__, |_|_|_| |_|\__, |___/
            |___/           |___/

   "Logic programs, slightly broken."
```

Interactive exercises for learning Prolog, powered by [patch-prolog](https://git.navicore.tech/navicore/patch-prolog).

Inspired by [rustlings](https://github.com/rust-lang/rustlings) and [seqlings](https://git.navicore.tech/navicore/seqlings).

**Home Code Repository** is at [git.navicore.tech](https://git.navicore.tech/navicore/loglings)

**PRs and issues** welcome at [codeberg.org mirror](https://codeberg.org/navicore/loglings)

## Prerequisites

You need the `plgc` compiler (from [patch-prolog](https://git.navicore.tech/navicore/patch-prolog), crate `plg-compiler`) on your `PATH`, plus **`clang` ≥ 15** — `plgc` compiles each exercise to a native binary via LLVM and links it with clang. See the [patch-prolog README](https://git.navicore.tech/navicore/patch-prolog) for details.

## Quick start

```bash
cargo install loglings           # or: cargo install --path . from a local clone
loglings init                    # creates ./my-loglings with all exercises
cd my-loglings
loglings                         # starts watch mode
```

The exercises, hints, and reference solutions all live inside the `loglings`
binary — `init` just extracts them into a directory you choose. You never need
to clone this repo to use the tool.

In watch mode, loglings re-checks the current exercise as you save the file
and advances when it passes.

To reset a single exercise back to its starting state:

```bash
loglings reset 01-fact
```

## How it works

1. loglings shows the current exercise
2. Open the `.pl` file in your editor
3. Read the comment, fix or complete the code
4. Delete the `% I AM NOT DONE` marker when you think it's done
5. loglings re-checks on save and advances to the next exercise on success

## Commands

| Command | Description |
|---|---|
| `loglings init [path]` | Create a fresh workspace (default `./my-loglings`) |
| `loglings update` | Refresh untouched exercises from a newer `loglings` (your in-progress work is preserved) |
| `loglings update --dry-run` | Show what `update` would do, without writing |
| `loglings update --force <name>` | Force-replace a specific exercise even if you've touched it |
| `loglings` | Watch mode (default, when run inside a workspace) |
| `loglings list` | Show all exercises with status |
| `loglings verify` | Check every exercise once |
| `loglings hint` | Print a hint for the current exercise |
| `loglings hint <name>` | Hint for a specific exercise |
| `loglings next` | Skip to the next exercise |
| `loglings reset` | Reset the current exercise to original |
| `loglings reset <name>` | Reset a specific exercise |

## Curriculum

| Section | Topics |
|---|---|
| **00-intro** | Facts, queries, multiple solutions, rules, lists |
| **01-arithmetic** | `is/2` and the four operators (`+ - * //`) |
| **02-terms** | Atoms vs numbers, variables & unification, compound terms, arity (`name/N`) |
| **03-operators** | Operators as terms (`=..`), prefix vs infix, precedence & associativity |
| **04-lists** | Destructuring: `[H\|T]`, exact shapes, skipping with `_`, heads build too |
| **05-comparison** | `<` `>` `=<` `>=` `=:=` `=\=`, and choosing `is` vs `=` vs `=:=` |
| **06-recursion** | Base case + recursive step: countdown, factorial, sum, length, map |
| **07-equality** | Term identity (`==` `\==`), standard order of terms (`@<`, `compare/3`), `sort/2` vs `msort/2` |
| **08-control** | Disjunction (`;`), if-then-else (`-> ;`), and the "how many solutions?" trio: negation (`\+`, none), `once/1` (one), `findall/3` (all) |
| **09-cut** | The cut (`!`): committing, commit-or-default (green vs load-bearing), the cut-fail idiom, transparency in `;` |
| **10-list-library** | `member/2` (test & generate), `append/3` (join & split — multi-mode), `reverse/2`, `length/2`, `last/2`, `between/3` |
| **11-meta** | Higher-order predicates with `call/N`: forall, filter, map (one rule for any predicate you pass), plus `=..` dispatch (a name in data choosing the goal) |
| **12-types** | Type-test guards: `var`/`nonvar` (has a value yet?), `number`/`integer`/`float` (make arithmetic safe over mixed data), `atom`/`compound`/`is_list` (classify a term — the tests overlap, so order matters) |
| **13-arith-depth** | Deeper arithmetic: the division family (`//` `mod` `rem` `div`, and the sign rules), `^` (int) vs `**` (float) powers, bitwise flags (`<<` `>>` `/\` `\|/` `xor`), and the two-way relations `succ/2` and `plus/3` (which run backwards, unlike `is/2`) |

More sections will be added as the curriculum grows. The engine is still gaining features; expect new sections to follow new engine capabilities.

## Prolog basics

Prolog is **declarative** logic programming. You write facts and rules; you ask questions; the engine searches for answers.

```prolog
% A fact: parent(tom, bob) means "tom is a parent of bob"
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).

% A rule: grandparent(X, Z) if X is a parent of some Y and Y is a parent of Z
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
```

Ask a question:

```
?- grandparent(tom, X).
X = ann.
```

## Development

The [`justfile`](justfile) is the single source of truth for build/test/lint —
both local development and CI run the same recipes, so they can't drift.

Run the full check suite before pushing:

```bash
just ci      # fmt-check + lint + test + build
```

`just ci` runs, in order: formatting (`cargo fmt --check`), clippy with
warnings treated as errors, the test suite, and a release build. Other handy
recipes: `just fmt`, `just install`, `just clean`, `just stats`.

### Tests

The real test surface is the Prolog corpus, exercised by
[`tests/curriculum.rs`](tests/curriculum.rs) on every `cargo test`:

- **Structural** (no engine): the registry is consistent, every exercise has a
  solution + hint, starters carry the `% I AM NOT DONE` marker and solutions
  don't, hints leak no answers, no corpus file is orphaned.
- **Semantic** (runs the compiler): every reference solution makes its hidden
  `test/0` pass, and every starter parses, by compiling each with real `plgc`.

The semantic tests require `plgc` (and `clang`) on your `PATH` — which you
already have if you can run the exercises.

CI runs on **Forgejo Actions** ([`.forgejo/workflows/ci-linux.yml`](.forgejo/workflows/ci-linux.yml))
on pull requests to `main`. It provisions `plgc` (so the semantic tests can
compile), then calls `just ci`. The Rust toolchain is pinned in
[`rust-toolchain.toml`](rust-toolchain.toml), which must match the
`navicore-rust` runner image (which also provides `clang`).

## Reporting issues

If an exercise feels unfair, the hint is wrong, or you've discovered an engine gap (loglings refuses to accept your obviously-correct answer because the engine can't parse it), please open an issue at:

- Curriculum/runner issues: [loglings issues](https://git.navicore.tech/navicore/loglings/issues)
- Compiler bugs: [patch-prolog issues](https://git.navicore.tech/navicore/patch-prolog/issues)

## License

MIT

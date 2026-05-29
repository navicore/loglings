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

## Prerequisites

You need `patch-prolog` installed and on your `PATH`. See the [patch-prolog README](https://git.navicore.tech/navicore/patch-prolog) for setup.

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

## Curriculum (starting slice)

| Section | Topics |
|---|---|
| **00-intro** | Facts, queries, multiple solutions, rules, lists |

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

## Reporting issues

If an exercise feels unfair, the hint is wrong, or you've discovered an engine gap (loglings refuses to accept your obviously-correct answer because the engine can't parse it), please open an issue at:

- Curriculum/runner issues: [loglings issues](https://git.navicore.tech/navicore/loglings/issues)
- Engine bugs: [patch-prolog issues](https://git.navicore.tech/navicore/patch-prolog/issues)

## License

MIT

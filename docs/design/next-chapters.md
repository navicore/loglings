# Design: `17-interpreters` & `18-search` chapters

Status: **proposed.** Designs chapters A (interpreters) and B (search) in full;
C/D/E appear as ambitions only. The doc stays open until C is designed too.

## Intent

The foundation (00–16) teaches the mechanism thoroughly but stops short of
*building something with it*. These two chapters are the synthesis tier: each
takes machinery the foundation introduced and applies it to a system a student
constructs. A is "terms-as-data" (compute *over* terms); B is "lists-as-control"
(compute *over* state). They're complementary, ordered A before B because B's
search machinery is the bigger payoff and A's `solve/1` is the smaller, more
self-contained synthesis. `copy_term/2` — the one builtin the foundation
deferred (ch. 11, "waiting for a motivated home") — lands in ch. 17.

## Constraints

- **Don't disturb 00–16.** Append-only: two new chapter dirs, no renumbering.
- Exercise contract unchanged: `% I AM NOT DONE` marker, hidden `test/0` below
  `% Do not edit below this line`, `:- dynamic(F/A).` for learner fact predicates.
- **Probe every exercise against installed `plgc` before authoring** (the
  standing rule). The one probe genuinely worth flagging: `copy_term/2`
  freshening a clause body with variables (17-04) — verified before authoring.
- No `loglings` source changes. `runner`/`bisect`/`exercise`/`update` untouched.
- No tier label in `info.toml` (no schema change; 17/18 are plain chapters).

## Approach

A: a meta-circular interpreter over an **encoded** program — `clause(Head,
Body)` facts authored as data (plgc has no `clause/2` builtin; this is the ch.
16 "no dynamic DB" boundary made productive). `solve/1` walks goal terms;
native goals escape via a `builtin/1` table; `copy_term/2` freshens clause
bodies. Capstone: a tracer (`solve/2` with a proof tree).

B: state-space search with the frontier as a list of path-carrying nodes,
`findall/3` for successor generation, `member/2` for the visited check. DFS
(natural recursion) → BFS (explicit frontier) → structured states (water jugs)
→ generate-and-test (N-queens) → place-and-check pruning.

## Structure

### Module / file boundaries

- `exercises/17-interpreters/` — 5 exercises; mirrored in `solutions/` + `hints/`.
- `exercises/18-search/` — 5 exercises; mirrored likewise.
- `exercises/info.toml` — 10 new ordered entries appended after `16-boundaries`.
- README + ROADMAP curriculum tables — two rows added; ROADMAP "Future" line
  unchanged (C+ remain).

### Public interfaces (conventions these chapters teach)

- **ch 17**: `clause(Head, Body)` data-encoding; `solve/1` goal-walker; a
  `builtin/1` reflection table; `copy_term/2` for clause-body freshening.
- **ch 18**: `node(State, PathReversed)` frontier elements; `findall/3`
  successor generation; `member/2` visited check; BFS = `append(Frontier,
  Succs)` vs DFS = `append(Succs, Frontier)`.

### Data shapes

- **ch 17**: `clause(Head, Body)` facts (a fact `h.` encodes as
  `clause(h, true)`); `solve/1` over `(A,B)` / `(C->T;E)` / atoms / builtins.
- **ch 18**: frontier `[node(S, PathRev)]`; successor via
  `findall(node(S2,[Op|PathRev]), (move(S,Op,S2), \+ member(S2,Visited)), Succs)`;
  solution = `reverse(PathRev, Path)`.

## Exercises — `17-interpreters`

**17-01/encode** — a program is data. Encode given rules/facts as `clause/2`
facts; define one-step `prove(G) :- clause(G, true)` (facts only). Establishes
representation + that proving = matching a clause head.
```prolog
% task: encode `parent(tom,bob).` and `likes(tom, X) :- parent(tom, X).`
clause(parent(tom, bob), true).
clause(likes(tom, X), parent(tom, X)).
prove(G) :- clause(G, true).
% test: prove(parent(tom,bob)); \+ prove(likes(tom,_)) fails (no recursion yet).
```

**17-02/conjunction** — walk bodies. `prove((A,B)) :- prove(A), prove(B).`
`prove(G) :- clause(G, Body), prove(Body).` Propositional only (no clause
variables) — so copy_term isn't needed yet.

**17-03/native** — the reflection moment. An encoded program using `is/2` and
`=` needs those called natively, not interpreted. Student writes the `builtin/1`
table entries and the escape clause `prove(G) :- builtin(G), call(G)`.

**17-04/variables** — `copy_term/2` lands here. The encoded program gains a
recursive rule with variables (`ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y)`).
Used at two instantiations in one proof, variables collide without freshening.
Student adds `copy_term(clause(H,B), clause(H,Bc)), prove(Bc)`. The test drives
a two-step ancestor proof so the collision is observable.

**17-05/tracer** (capstone) — `solve(Goal, Trace)` builds a proof-tree term.
Conjunction → `(TA,TB)`; clause use → `Goal <- BodyProof`; builtin → `Goal <
native>`. Test asserts the trace shape for a small derivation. The interpreter
as introspection tool.

## Exercises — `18-search`

**18-01/dfs** — natural recursion + visited accumulator + path. Callback to
ch. 06 recursion and `deps.pl`'s `needs/2`, now cycle-safe and path-collecting.
`path(Here, Goal, Visited, PathRev)`.

**18-02/bfs** — explicit frontier as a queue of `node(State, PathRev)` nodes.
The search lives in data, not the call stack. `bfs([node(G,Pr)|_], G, Sol) :-
reverse(Pr, Sol).` Successors appended to the back.

**18-03/jugs** — water jugs. State is a structured term `s(A,B)`; moves have
preconditions (`A #< cap` style via `=<`). Applies the 18-02 machinery to a
state space where successors are generated by rules, not edges. The
generalization that proves the solver is generic.

**18-04/queens-naive** — N-queens by generate-and-test: `between/3` to place
each queen into columns, then `\+` + `member` to test the whole placement for
no-attack. The pure, slow baseline.

**18-05/queens-pruned** — place-and-check: extend a partial placement one queen
at a time, rejecting immediately on attack. The contrast with 18-04 is the
generate-and-test-vs-propagate lesson. Test asserts it finds solutions 18-04
also finds, faster.

## Ambitions (not designed here)

- **C — symbolic term manipulation.** Terms as trees; walk/transform with
  `=..` + `functor/3`/`arg/3` + recursion. Anchors: expression simplifier
  (`x+0 → x`, constant folding), symbolic differentiation (then simplify), a
  boolean normaliser. Shares ch. 17's "term-as-data" mindset; the chapter that
  lands terms as a *first-class data structure*. Strongest of the three.
- **D — difference lists.** O(1) append via the difference trick; `flatten/2`
  to a difference list; the technique DCGs are sugar for, taught by hand
  because plgc has no DCG. Likely one exercise within a broader chapter.
- **E — relational / mode-aware predicate design.** Designing predicates that
  terminate in every intended mode; `var/1` guards; multi-directionality
  (`append/3` as mascot). "Advanced Prolog *thinking*" — harder to make into
  discrete exercises; likely a capstone framing rather than a technique chapter.

## Domain Events

- **Chapter authored** → 5 exercises + solutions + nudge-hints added per
  chapter; three trees mirrored; `info.toml` extended; README + ROADMAP tables
  refreshed; `just ci` green (every solution passes, every starter parses).
- **A proposed exercise won't compile/pass on `plgc`** → a `plgc` gap/bug →
  file upstream, defer the exercise (the harness working as intended).
- **`copy_term/2` probe fails on 17-04** → that's a `plgc` issue, not an
  exercise rewrite — verify before authoring, per the standing rule.

## Checkpoints

1. `just ci` green after each chapter — full corpus compiles and passes.
2. 17-04 demonstrably fails *without* `copy_term/2` and passes with it (the
   payoff must be observable, not theoretical).
3. 18-05 finds the same solution set as 18-04 (correctness) — pruning changes
   speed, not answers.
4. Every chapter's capstone (17-05, 18-05) runs a non-trivial program the
   student *authored*, not just a builtin demo — the synthesis-tier bar.

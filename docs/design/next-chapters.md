# Design: `17-interpreters` & `18-search` chapters

Status: **ch. 17 and ch. 18 authored and in the curriculum.** Designs
chapters A (interpreters) and B (search) in full; C/D/E appear as ambitions
only. The doc stays open until C is designed too.

**Probe correction (ch. 17):** the `copy_term/2` pollution premise was false on
`plgc` — user-fact `clause/2` does not exhibit variable pollution across
selections, so `prove/1` works *without* `copy_term`. `copy_term` is therefore
**not taught in ch. 17** and reverts to deferred — most likely landing in ch. C
(symbolic rewriting), where capture-avoiding substitution is a genuine need.

**Capstone dropped (ch. 17):** a tracer (`solve/2` building a proof tree) was
the planned 4th exercise, but it was transcription — the prose gave the clauses
*and* the asserted tree, so copying solved it, and the tree had no consumer to
motivate it. Ch. 17 ships at **3 exercises** (encode, conjunction, native); a
working meta-circular interpreter with native escape is a complete synthesis.
See the Probe log at the end of this doc.

## Intent

The foundation (00–16) teaches the mechanism thoroughly but stops short of
*building something with it*. These two chapters are the synthesis tier: each
takes machinery the foundation introduced and applies it to a system a student
constructs. A is "terms-as-data" (compute *over* terms); B is "lists-as-control"
(compute *over* state). They're complementary, ordered A before B because B's
search machinery is the bigger payoff and A's `prove/1` is the smaller, more
self-contained synthesis. `copy_term/2` — the one builtin the foundation
deferred (ch. 11, "waiting for a motivated home") — does **not** land here; it
waits for ch. C.

## Constraints

- **Don't disturb 00–16.** Append-only: two new chapter dirs, no renumbering.
- Exercise contract unchanged: `% I AM NOT DONE` marker, hidden `test/0` below
  `% Do not edit below this line`, `:- dynamic(F/A).` for learner fact predicates.
- **Probe every exercise against installed `plgc` before authoring** (the
  standing rule).
- No `loglings` source changes. `runner`/`bisect`/`exercise`/`update` untouched.
- No tier label in `info.toml` (no schema change; 17/18 are plain chapters).

## Approach

A: a meta-circular interpreter over an **encoded** program — `clause(Head,
Body)` facts authored as data (plgc has no `clause/2` builtin; this is the ch.
16 "no dynamic DB" boundary made productive). `prove/1` walks goal terms;
native goals escape via a `builtin/1` table. No capstone — three exercises
(encode, conjunction, native) is a complete synthesis. `copy_term/2` was
originally to be taught here but the probe pass showed `prove/1` doesn't need
it on `plgc`; a planned tracer capstone was dropped in authoring (transcription,
no consumer for the tree); both are deferred to ch. C.

B: state-space search with the frontier as a list of path-carrying nodes,
`findall/3` for successor generation, `member/2` for the visited check. DFS
(natural recursion) → BFS (explicit frontier) → structured states (water jugs)
→ generate-and-test (N-queens) → place-and-check pruning.

## Structure

### Module / file boundaries

- `exercises/17-interpreters/` — 3 exercises; mirrored in `solutions/` + `hints/`.
- `exercises/18-search/` — 5 exercises; mirrored likewise.
- `exercises/info.toml` — 8 new ordered entries appended after `16-boundaries`.
- README + ROADMAP curriculum tables — two rows added; ROADMAP "Future" line
  unchanged (C+ remain).

### Public interfaces (conventions these chapters teach)

- **ch 17**: `clause(Head, Body)` data-encoding; `prove/1` goal-walker; a
  `builtin/1` reflection table for native goals (a fact-as-unification-template
  idiom — `builtin(_ is _)` matches any `is/2` goal).
- **ch 18**: `node(State, Path)` frontier elements (path carried **forward**,
  start-to-goal — see the probe-log note on why not reversed); `findall/3`
  successor generation; `member/2` visited check; BFS = `append(Frontier,
  Succs)` vs DFS = `append(Succs, Frontier)`.

### Data shapes

- **ch 17**: `clause(Head, Body)` facts (a fact `h.` encodes as
  `clause(h, true)`); `prove/1` over `true` / `(A,B)` / clause lookup /
  builtin-escape.
- **ch 18**: frontier `[node(S, Path)]` with `Path` forward (start-to-goal);
  successor via
  `findall(node(S2, P2), (move(S, S2), \+ member(S2, Path), append(Path, [S2], P2)), Succs)`;
  the goal node's `Path` is returned as-is (no `reverse`).

## Exercises — `17-interpreters` (3 exercises)

**17-01/encode** — a program is data. Encode given rules/facts as `clause/2`
facts; define one-step `prove(G) :- clause(G, true)` (facts only). Establishes
representation + that proving = matching a clause head; sets up that bodies
aren't interpreted yet (so a rule head fails — the motivation for 17-02).

**17-02/conjunction** — walk bodies. `prove(true).` and
`prove((A,B)) :- prove(A), prove(B).` plus
`prove(G) :- clause(G, Body), prove(Body).` Now rule bodies are interpreted,
including multi-goal conjunctions. Recursion in the encoded program comes free
(prove calls prove) and works without `copy_term` on `plgc` (probed).

**17-03/native** — the reflection moment. An encoded program using `is/2` and
`=` needs those called natively, not interpreted. Student writes the `builtin/1`
table entries and the escape clause `prove(G) :- builtin(G), call(G)` (no cut
needed — builtin goals have no clauses, so the clause-lookup clause fails
through cleanly). **Prose explicitly teaches the fact-as-unification-template
idiom** — `builtin(_ is _)` is a fact whose argument is the compound term
`is(_,_)` (data, not a call); querying `builtin(G)` unifies `G` against it with
`_` as wildcards — and bridges to the same unify-against-a-fact move the
student already did in 17-01's `clause(G, true)`. Without this bridge the
`_ is _` pattern reads as magic.

~~**17-04/tracer** (capstone)~~ — **dropped in authoring.** The tracer gave
its clauses *and* the asserted proof tree in the prose, so it was transcription,
and the tree had no consumer to motivate it. A working `prove/1` (encode →
conjunction → native) is a complete synthesis; no capstone is forced. If a
4th exercise is later wanted, the better framing is an *extractor* over a
given `solve/2` tree (count clause applications, list facts used) — a task that
can't be copied and gives the tree a purpose.

## Exercises — `18-search`

**18-01/dfs** — natural recursion + visited accumulator + path. Callback to
ch. 06 recursion and `deps.pl`'s `needs/2`, now cycle-safe and path-collecting.
`path(Here, Goal, Visited, Path)`.

**18-02/bfs** — explicit frontier as a queue of `node(State, Path)` nodes
(**path forward**, matching 18-01). The prose walks a worked frontier trace so
the queue discipline is concrete, not just described. Revised after field
feedback (the reversed-path version packed too many new ideas into one step —
see probe log).
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
  lands terms as a *first-class data structure*. **`copy_term/2` likely lands
  here** — capture-avoiding substitution is a genuine need during rewriting.
  Strongest of the three.
- **D — difference lists.** O(1) append via the difference trick; `flatten/2`
  to a difference list; the technique DCGs are sugar for, taught by hand
  because plgc has no DCG. Likely one exercise within a broader chapter.
- **E — relational / mode-aware predicate design.** Designing predicates that
  terminate in every intended mode; `var/1` guards; multi-directionality
  (`append/3` as mascot). "Advanced Prolog *thinking*" — harder to make into
  discrete exercises; likely a capstone framing rather than a technique chapter.

## Domain Events

- **Chapter authored** → exercises + solutions + nudge-hints added (3 for
  ch. 17, 5 for ch. 18); three trees mirrored; `info.toml` extended; README +
  ROADMAP tables refreshed; `just ci` green (every solution passes, every
  starter parses).
- **A proposed exercise won't compile/pass on `plgc`** → a `plgc` gap/bug →
  file upstream, defer the exercise (the harness working as intended).
- **An exercise is transcription (the prose gives the answer)** → rework it so
  the task requires inference the prose doesn't hand over, or drop it. The
  tracer was dropped for this reason.

## Checkpoints

1. `just ci` green after each chapter — full corpus compiles and passes.
2. 17-03's `builtin/1` table + `call` actually fires for `is/2` in an encoded
   rule (probe-verified: `prove_bi(dbl(tom))` succeeds).
3. 18-05 finds the same solution set as 18-04 at N=4 (correctness) — pruning
   changes speed, not answers. Verified: both find `[2,4,1,3]` and `[3,1,4,2]`.
4. Every exercise requires inference the prose doesn't hand over (the
   transcription guard — the tracer was dropped for failing this).
5. **Every test runs under the runner's default step budget (10000 steps, no
   `PLG_MAX_STEPS`).** This shaped the N-queens sizes (below).

## Probe log (ch. 17)

- `clause(p(X), holds(X))` served `clause(p(a), B)` then `clause(p(b), B)` →
  `holds(a)`, `holds(b)`. **Fact variables are not polluted across selections**
  on `plgc`; the classic meta-circular pollution premise is false here.
- `prove/1` *without* `copy_term` succeeds on a 3-deep recursive chain
  (`ancestor(tom, ann)` over `parent(tom,bob)`, `parent(bob,sue)`,
  `parent(sue,ann)`). Recursion-in-the-encoded-program works unaided.
- Native escape via `builtin/1` table + `call` (no cut) verified:
  `prove_bi(dbl(tom))` over `clause(dbl(X), (value(X,V), R is V*2, Ans=R))`
  succeeds.
- `copy_term/2`'s one observable home on `plgc`: N independent template copies
  (`dup_good(3, slot(_,_), L)` gives fresh variables per element). Real but
  thin — deferred to ch. C where capture-avoiding substitution motivates it.
- `findall/3` cannot be reimplemented in pure Prolog (needs a primitive);
  rejected as a `copy_term` teaching home.
- **Tracer capstone dropped in authoring.** `solve/2` building a proof tree was
  transcription (prose gave the clauses and the asserted tree) and the tree had
  no consumer. A working `prove/1` is a complete synthesis at 3 exercises; the
  tracer idea is noted for a future *extractor-over-a-given-tree* exercise if a
  4th rung is wanted.

## Probe log (ch. 18)

- **One graph serves both DFS and BFS.** `edge(a,b). edge(a,c). edge(b,d).
  edge(d,e). edge(c,e). edge(e,a). edge(e,f).` — a cycle (e→a) makes the
  visited list load-bearing; DFS finds `a→e = [a,b,d,e]` (long, edge order)
  while BFS finds `a→e = [a,c,e]` (short), landing the DFS/BFS contrast; `f` is
  an unreachable sink for the negative test.
- **The `length/2` saga (issue patch-prolog#54).** Naive N-queens built its
  skeleton with `length(Rows, N)` — which *diverged* on plgc ≤ 0.4.4 because
  stdlib `length/2` recursed into negative counts on backtracking. Filed as
  patch-prolog#54; fixed in 0.4.5 (PR#55, verified independently). The ch. 18
  naive exercise uses the natural `length/2` form, which is safe on ≥ 0.4.5.
- **Step budget shapes the queens tests.** The runner uses the default 10000
  steps (no `PLG_MAX_STEPS`). Under it: naive N=4 works, **naive N=5 blows the
  budget**; pruned N=4/5/6 work, pruned N=8 blows. So 18-04 naive tests N=4
  (both solutions); 18-05 pruned tests N=4 (same two) **and N=6 = 4 solutions**
  — the payoff: pruned reaches boards naive can't. All probes re-verified under
  the default budget, not a raised one.
- **18-03 jugs test is robust to move-clause order.** Asserts start `s(0,0)`,
  end `s(2,_)`, and `length(Path, 7)` (the 6-move minimum BFS finds) rather
  than an exact path — so any valid clause ordering of the student's pour rules
  passes.
- Water jugs BFS reuses 18-02's solver verbatim except `edge/2` → `move/2` and
  a fixed goal state → a `goal/1` property. Verified: the solver is generic.
- **18-02 revised after field feedback (forward path, added trace).** The first
  cut carried the path *reversed* (`node(State, PathRev)`, `reverse/2` at the
  goal) — the idiomatic O(1)-prepend scheme, but it packed ~6 new ideas into
  one step and the reversed path had nothing to do with BFS. A learner found it
  too dense/abstract. Revised to a **forward** path (`append(Path,[N],NP)` per
  extension, no `reverse`), which matches 18-01's forward path and drops the
  whole `reverse`/`PathRev` idiom, plus a worked frontier trace in the prose.
  18-03's given solver updated to match. Verified: identical results
  (`a→e=[a,c,e]`, `b→c=[b,d,e,a,c]`, `f→a` none) with less machinery.

# Source exercise coverage map

This map inventories all 208 marked exercises in the Fall 2026 CS 3110
textbook at source commit `92827148583ed72060c4984c6075cf995d1d0a5e`.
Only exercise names are indexed here. The detailed table records the legacy
E01-E41 textbook coverage before consolidation; the extra graph lab E42 is
mapped in the summary. E01-E06 remain in place, and the required replacement
sequence is E07-E20. Low-value repetition remains available in the pinned PDF.

## Consolidated sequence

| New file | Consolidates legacy material | Compression decision |
|---|---|---|
| E07 functions/dataflow | E08-E10 higher-order and fold work | repeated combinators and matrix implementation |
| E08 Base/PPX | HOP library use plus public Jane Street conventions | duplicate Stdlib implementations |
| E09 modules/interfaces | E11, E16, E17 | repeated staged modules and algebra refactors |
| E10 persistent structures | E12-E15, E32 | one queue and BST plus balancing analysis; production clients use Core collections |
| E11 hashing/graphs | E30-E31, E42 | one probing implementation; retain DFS, BFS, components, bipartite testing |
| E12 specs/invariants | E07, E23-E24 | one integrated AF/RI and error-boundary case |
| E13 testing/coverage | E25-E26 | translate OUnit/Bisect/QCheck repetition into expect tests and Base_quickcheck |
| E14 proofs/types | E27-E29, E41 | consolidate repeated proofs; retain induction, strengthening, laws, Curry-Howard |
| E15 mutation/performance | E18-E19 and practical E30 work | one measured pure/mutable comparison rather than repeated loops |
| E16 sequences/laziness | E33-E35 | combine producers, fairness, numerical streams, forcing, and space behavior |
| E17 Async/Pipe | E20-E22 | target Async directly; omit hand promises and the Lwt detour |
| E18 interpreter | E36-E39 | one cumulative language instead of multiple generated-parser project stages |
| E19 inference | E36 and E40 | retain constraints, unification, occurs checks, and inference |
| E20 Command/I/O | integration of sexps, Async, validation | one real executable instead of a separate capstone tree |

| Pinned PDF / web source | Legacy lab | Legacy fidelity status | Source exercise names |
|---|---|---|---|
| [PDF §4.9 / web Basics](https://cs3110.github.io/textbook/chapters/basics/exercises.html) | E01 | Partial, protected: `poly types`, application `associativity`, and `hello world` are absent | values; operators; equality; assert; if; double fun; more fun; RMS; poly types; divide; associativity; average; hello world |
|  | E02 | Partial, protected: `date fun` is materially adapted and the debugging extension misdiagnoses its bug | date fun; fib; fib fast |
| [PDF §5.14 / web Data](https://cs3110.github.io/textbook/chapters/data/exercises.html) | E03 | Partial, protected: OUnit objectives are absent and `patterns` is adapted | list expressions; product; concat; product test; patterns; library; library test; library puzzle |
|  | E04 | Direct + labelled extension | take drop; take drop tail; unimodal; powerset; print int list rec; print int list iter |
|  | E05 | Direct + labelled extension | student; pokerecord; safe hd and tl; pokefun; date before; earliest date; assoc list |
|  | E06 | Direct + labelled extensions | cards; matching; quadrant; quadrant when; quadrant poly |
|  | E07 | Direct + labelled extension | depth; shape; list max exn; list max exn string; list max exn ounit; is_bst |
| [PDF §6.9 / web Higher-order programming](https://cs3110.github.io/textbook/chapters/hop/exercises.html) | E08 | Direct + labelled extensions | twice, no arguments; mystery operator 1; mystery operator 2; repeat; library uncurried; map composition |
|  | E09 | Direct | product; terse product; sum_cube_odd; sum_cube_odd pipeline; exists; account balance; more list fun; association list keys |
|  | E10 | Direct + labelled extensions | valid matrix; row vector add; matrix add; matrix multiply |
| [PDF §7.11 / web Modules](https://cs3110.github.io/textbook/chapters/modules/exercises.html) | E11 | Direct + labelled extension | complex synonym; complex encapsulation; fraction; fraction reduced |
|  | E12 | Direct + labelled extensions | big list queue; big batched queue; queue efficiency |
|  | E13 | Direct + labelled extension | binary search tree map; make char map; char ordered; use char map; bindings |
|  | E14 | Direct + labelled extensions | date order; calendar; print calendar; is for; first after; sets |
|  | E15 | Direct + labelled extensions | ToString; Print; Print Int; Print String; Print Reuse; Print String reuse revisited |
|  | E16 | Direct through four real compilation-unit stages + extension | implementation without interface; implementation with interface; implementation with abstracted interface; printer for date |
|  | E17 | Direct interface-preserving refactor | refactor arith |
| [PDF §8.5 / web Mutability](https://cs3110.github.io/textbook/chapters/mut/exercises.html) | E18 | Direct + labelled extension | mutable fields; refs; inc fun; addition assignment; physical equality |
|  | E19 | Direct + labelled extension | norm; normalize; norm loop; normalize loop; init matrix |
| [PDF §9.10 / web Concurrency](https://cs3110.github.io/textbook/chapters/conc/exercises.html) | E20 | Direct + labelled extensions | promise and resolve; map via bind; map anew |
|  | E21 | Direct + labelled extensions | promise and resolve lwt; timing challenge 1; timing challenge 2; timing challenge 3; timing challenge 4; file monitor |
|  | E22 | Direct | add opt; fmap and join; fmap and join again; bind from fmap+join; list monad; trivial monad laws |
| [PDF §10.11 / web Correctness](https://cs3110.github.io/textbook/chapters/correctness/exercises.html) | E23 | Direct adversarial/specification work + labelled implementation extensions | spec game; poly spec; poly impl |
|  | E24 | Direct + labelled extensions | interval arithmetic; function maps |
|  | E25 | Direct OUnit/Bisect/QCheck practice + labelled extension | set black box; set glass box; random lists |
|  | E26 | Direct QCheck practice + labelled extensions | qcheck odd divisor; qcheck avg |
|  | E27 | Direct proof work + labelled checks | exp; fibi; expsq; expsq simplified; mult |
|  | E28 | Direct proof work + labelled extension | append nil; rev dist append; rev involutive; reflect size; fold theorem 2; propositions |
|  | E29 | Direct + labelled executable extensions | list spec; bag spec |
| [PDF §11.9 / web Data structures](https://cs3110.github.io/textbook/chapters/ds/exercises.html) | E30 | Direct + labelled extensions | hash insert; relax bucket RI; strengthen bucket RI; hash values; hashtbl usage; hashtbl stats; hashtbl bindings; hashtbl load factor; functorial interface; equals and hash; bad hash |
|  | E31 | Direct + labelled model-checking extension | linear probing |
|  | E32 | Direct + labelled invariant-auditor extension | functorized BST; efficient traversal; RB draw complete; RB draw insert |
|  | E33 | Direct + labelled extensions | pow2; more sequences; nth; hd tl; filter; interleave |
|  | E34 | Direct + labelled extensions | sift; primes; approximately e; better e |
|  | E35 | Direct + labelled forcing extensions | different sequence rep; lazy hello; lazy and; lazy sequence |
| [PDF §12.8 / web Interpreters](https://cs3110.github.io/textbook/chapters/interp/exercises.html) | E36 | Direct through real SimPL/ocamllex/Menhir stages + labelled recursive-descent extension | parse; simpl ids; times parsing; infer; subexpression types; typing |
|  | E37 | Direct labelled semantics + implementation extensions | substitution; step expressions; step let expressions; variants; application; omega |
|  | E38 | Direct through one cumulative SimPL pair stage + labelled richer-language extensions | pair parsing; pair type checking; pair evaluation; desugar list; list not empty; generalize patterns |
|  | E39 | Direct derivations and both substitution/environment recursion models | let rec; simple expressions; let and match expressions; closures; lexical scope and shadowing; more evaluation; dynamic scope; more dynamic scope |
|  | E40 | Direct manual inference work + implementation extensions | constraints; unify; unify more; infer apply; infer double; infer S |
| [PDF §13.7 / web Curry-Howard](https://cs3110.github.io/textbook/chapters/adv/curry-howard.html#exercises) | E41 | Direct + labelled extensions | propositions as types; programs as proofs; evaluation as simplification |

## Count audit

| Source area | Count |
|---|---:|
| Basics | 16 |
| Data | 32 |
| Higher-order programming | 18 |
| Modules | 29 |
| Mutability | 10 |
| Concurrency | 15 |
| Correctness | 23 |
| Data structures | 30 |
| Interpreters | 32 |
| Curry-Howard | 3 |
| **Total** | **208** |

## Supplemental practice

The former 15-task 99 Problems supplement is not part of the consolidated
required path. E06 Tasks 8–9 remain only because E06 is protected learner work;
they are explicitly optional. The other supplemental prompts were removed.

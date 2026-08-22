# CS 3110 OCaml Fast Track

This is a single sequence of incremental concept files. E01–E06 preserve the
learner work already completed or in progress. E07–E20 replace the previous
E07–E42 block by teaching every high-value competency once.

The reduced sequence keeps the useful CS 3110 foundation, transitions into
Jane Street's public OCaml libraries. It removes repeated implementations,
obsolete library detours, and supplemental busywork—not data structures,
algorithms, testing, proofs, laziness, interpreters, or type inference. The
pinned textbook remains in `reference/` for optional depth.

## Continue here

Keep and build all current E06 work. Task 6 (polymorphic variants) remains
required; Tasks 7–9 are optional extensions, with Tasks 8–9 being supplemental
99 Problems practice. Then continue to E07.

Finish Task 6, then start E07:

```sh
opam exec -- dune build exercises/e06_variants_and_patterns.exe
opam exec -- dune exec exercises/e06_variants_and_patterns.exe
opam exec -- dune build exercises/e07_functions_and_dataflow.exe
```

Then open `exercises/e07_functions_and_dataflow.ml` and do Task 1.

## Course sequence

| Files | Concepts | Status |
|---|---|---|
| E01–E02 | expressions, types, functions, recursion, tail state | preserved learner work |
| E03–E04 | lists, pattern matching, tail recursion, complexity | preserved learner work |
| E05–E06 Tasks 1–5 | records, options, variants, pattern coverage | preserved learner work |
| E06 Task 6 | polymorphic variants | required next step |
| E07 | higher-order functions, pipelines, folds | required |
| E08 | Base conventions, Or_error, PPX, sexps, comparators | required |
| E09 | real `.ml`/`.mli` abstraction boundaries | required |
| E10 | persistent queues, BSTs, balancing, Map, Set, functors | required |
| E11 | hashing, linear probing, DFS, BFS, graph properties | required |
| E12 | specifications, error context, AF/RI, atomic updates | required |
| E13 | expect tests, Base_quickcheck, shrinking, coverage | required |
| E14 | induction, equational reasoning, propositions as types | required |
| E15 | refs, aliasing, arrays, Hashtbl, performance decisions | required |
| E16 | productive sequences, fairness, `Lazy.t`, space behavior | required |
| E17 | Async, Deferred, Pipe, pushback, async errors | required |
| E18 | parsing, substitution, operational semantics, interpreters | required |
| E19 | constraints, unification, occurs checks, type inference | required |
| E20 | Command, streaming I/O, sexp boundaries | required |

The replacement path is **14 files and 72 tasks**, versus E07–E42's 36 files
and roughly 218 task blocks.

## Setup

```sh
opam switch create . 5.3.0
opam install . --deps-only
eval "$(opam env)"
opam exec -- dune build @exercises/all
```

The existing switch can skip the first command. The project uses the Jane
Street ocamlformat profile already selected in `.ocamlformat`.

## One-task workflow

1. Write predictions, contracts, or invariants before running code.
2. Implement only the current numbered task.
3. Add the requested normal and boundary checks.
4. Build and run the current file; do not continue through a compiler error.
5. Format only the file just completed and inspect its diff.
6. Run the completion gate after the final task in that file.

For example:

```sh
opam exec -- dune build exercises/e07_functions_and_dataflow.exe
opam exec -- dune exec exercises/e07_functions_and_dataflow.exe
python3 tools/check_completion.py e07
```

E09 also has a real interface file. E13 runs through `dune runtest` because it
is an inline-test library. E17 starts the Async scheduler. E20 is verified as a
real Command executable.

## Provenance

`SOURCE_MAP.md` retains the exact inventory of the pinned textbook's 208 public
exercise names and records how the old blocks were consolidated or omitted.
The unmodified Fall 2026 textbook and source commit are recorded under
`reference/`.

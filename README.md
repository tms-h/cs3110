# CS 3110 Fast Track

An exercise-first OCaml curriculum derived from the progression of Cornell's
Fall 2026 CS 3110 textbook. It compresses 208 public textbook exercises into
41 original labs for an experienced C++ programmer.

## Start here

Work through `exercises/e01_semantics_sprint.ml`, then continue in numeric
order. Open only the current file: its header contains the reading links,
constraints, commands, and completion criteria you need.

```sh
opam exec -- dune build exercises/e01_semantics_sprint.exe
opam exec -- dune exec exercises/e01_semantics_sprint.exe
```

Replace the executable name as you advance. `failwith "TODO"` is an intentional
typed hole: the file should compile before it is complete and fail when run.
Solve every TODO, prediction, debugging note, and explanation before moving on.

The official Fall 2026 setup uses OCaml 5.3.0. This curriculum was verified on
OCaml 5.4.1 and Dune 3.24.2. The only non-stdlib exercise dependency is Lwt:

```sh
opam install dune ocamlformat lwt
```

## The fast loop

1. Predict types, values, errors, ordering, or complexity before running code.
2. Make the smallest experiment that could falsify the prediction.
3. Implement against the tests and specifications in the file.
4. Read compiler errors literally; write down the cause before fixing one.
5. Look up one unfamiliar library operation in the linked official docs.
6. Refactor once after tests pass, then run `ocamlformat` and inspect the diff.
7. Finish the transfer task without copying the preceding implementation.

Suggested commands:

```sh
opam exec -- ocamlc -i exercises/e08_function_composition.ml
opam exec -- ocamlformat --enable-outside-detected-project \
  --inplace exercises/e08_function_composition.ml
opam exec -- dune exec exercises/e08_function_composition.exe
```

The build enables high-signal compiler warnings but suppresses scaffold-only
noise such as unused typed holes. Warnings are not errors. Treat every warning
you do see as an exercise: understand it before suppressing it.

## Route

| Labs | Theme | Approx. time |
|---|---|---:|
| 01-02 | Expressions, functions, recursion | 1 h |
| 03-07 | Lists, variants, records, trees, errors | 3-4 h |
| 08-10 | Higher-order functions and data pipelines | 1.5-2.5 h |
| 11-17 | Modules, abstraction, functors, refactoring | 4-5 h |
| 18-19 | State, aliasing, arrays | 1-1.5 h |
| 20-22 | Promises, Lwt, monads | 2-2.5 h |
| 23-29 | Specs, testing, property discovery, proofs | 4-5 h |
| 30-35 | Hashing, balanced trees, sequences, laziness | 3.5-4.5 h |
| 36-40 | Parsing, semantics, interpreters, inference | 4 h |
| 41 | Curry-Howard synthesis | 30 min |

The module/testing/debugging/state portions are deliberately a little denser
because they transfer well to production OCaml codebases. The subject matter
and order remain CS 3110's; this is not a trading-themed replacement course.

## Offline reference and provenance

The unmodified Fall 2026 textbook is stored at
`reference/ocaml_programming_fall_2026.pdf`. Use it only when a lab's linked
section or terminology is unfamiliar. `SOURCE_MAP.md` records every source
exercise and the lab that covers it.

The textbook is © 2021-2026 Michael R. Clarkson et al. and distributed under
CC BY-NC-ND 4.0. This repository does not reproduce or modify its exercise
text: the labs are newly written prompts, and the source names/links are an
index for personal study.

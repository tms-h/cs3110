# CS 3110 Fast Track

An exercise-first OCaml curriculum derived from Cornell's Fall 2026 CS 3110
textbook. It compresses 208 public textbook exercises into 41 from-scratch
labs for an experienced C++ programmer.

## Start here

Work through `exercises/e01_semantics_sprint.ml`, then continue in numeric
order. Each file is one cumulative program divided into small tasks. Add your
code directly below the current task, write the requested assertions, build,
and run before reading the next task.

```sh
opam exec -- dune build exercises/e01_semantics_sprint.exe
opam exec -- dune exec exercises/e01_semantics_sprint.exe
```

Replace the executable name as you advance. Untouched starter files build and
run successfully, but intentionally contain no completed exercise work. Your
own assertions become the regression suite that reruns after every increment.

The official Fall 2026 setup uses OCaml 5.3.0. This curriculum was verified on
OCaml 5.4.1 and Dune 3.24.2. The only non-stdlib exercise dependency is Lwt:

```sh
opam install dune ocamlformat lwt
```

## The fast loop

1. Write the smallest requested piece from scratch.
2. Write at least one assertion; normally use both an ordinary and a boundary
   or adversarial case.
3. Build and run the file. Do not continue while either command fails.
4. For prediction or debugging work, record the prediction before the
   experiment and explain the first mismatch before editing.
5. Keep every passing assertion so later tasks rerun all earlier checks.
6. After the last task, format once and inspect the diff.

Suggested commands:

```sh
opam exec -- ocamlc -i exercises/e08_function_composition.ml
opam exec -- ocamlformat --enable-outside-detected-project \
  --inplace exercises/e08_function_composition.ml
opam exec -- dune exec exercises/e08_function_composition.exe
```

The build enables high-signal compiler warnings. Warnings are not errors. Treat
every warning as an exercise: understand it before suppressing it.

## Route

| Labs | Theme | Approx. time |
|---|---|---:|
| 01-02 | Expressions, functions, recursion | 2 h 5 min-2 h 50 min |
| 03-07 | Lists, variants, records, trees, errors | 5 h 25 min-7 h 35 min |
| 08-10 | Higher-order functions and data pipelines | 3 h 15 min-4 h 30 min |
| 11-17 | Modules, abstraction, functors, refactoring | 10 h 10 min-13 h 50 min |
| 18-19 | State, aliasing, arrays | 2 h 15 min-3 h 5 min |
| 20-22 | Promises, Lwt, monads | 4 h 25 min-6 h 5 min |
| 23-29 | Specs, testing, property discovery, proofs | 10 h 10 min-13 h 55 min |
| 30-35 | Hashing, balanced trees, sequences, laziness | 9 h 15 min-12 h 50 min |
| 36-40 | Parsing, semantics, interpreters, inference | 9 h 5 min-12 h 25 min |
| 41 | Curry-Howard synthesis | 50-70 min |

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

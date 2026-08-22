# CS 3110 Fast Track

This is an exercise-first companion to the pinned Fall 2026 edition of
*OCaml Programming: Correct + Efficient + Beautiful*. It reorganizes the
textbook's 208 public exercises into 41 cumulative core labs while retaining
the actual activity being taught: prediction, implementation, interface
experimentation, specification, testing-tool practice, derivation, or proof.
Fifteen supplemental practice tasks are woven into the sequence from E06
onward, including the thematically placed E42 graph lab.

`SOURCE_MAP.md` is an exact inventory of the 208 source exercise names. Its
status column distinguishes direct coverage, labelled extensions, and the
known partial coverage in the protected E01-E03 learner work. “Related topic”
is not counted as coverage.

## Protected learner work

E01, E02, and E03 contain completed or in-progress learner work. They are not
starter templates and are intentionally left unchanged. Begin new curriculum
work at E04 unless you are the owner continuing those files.

## Setup

Cornell's Fall 2026 environment uses OCaml 5.3.0. The repository declares all
exercise and documented-tool dependencies in `cs3110_fast_track.opam`: Dune,
Menhir, utop, ocamlformat, Lwt, OUnit, QCheck, and Bisect.

For an isolated project-local switch:

```sh
opam switch create . 5.3.0
opam install . --deps-only
eval "$(opam env)"
```

The exercise files also work in another compatible switch once those
dependencies are installed.

## One-task workflow

Except where a task explicitly names a staged companion directory, each file
is one cumulative program. Work on only the current task:

1. For a prediction, trace, specification, derivation, or proof, write the
   requested answer before running or reading further.
2. Add the smallest requested implementation below the task.
3. Add the specified ordinary, boundary, and adversarial checks. Use the named
   framework when a task requires OUnit or QCheck.
4. Build and run. Do not continue while either command fails.
5. Preserve earlier public tests. When a later task seals a representation,
   keep representation-specific tests in the implementation/white-box scope
   identified by the prompt.
6. After the final task, print the exact `E## passed` marker and run the
   completion gate described in `COMPLETION.md`.

For example:

```sh
opam exec -- dune build exercises/e04_tail_recursion_and_shape.exe
opam exec -- dune exec exercises/e04_tail_recursion_and_shape.exe
python3 tools/check_completion.py e04
```

An untouched prompt-only file can still be valid OCaml and may build. It is not
complete. The completion gate rejects comment-only and marker-only files,
checks the fixed lab manifest, and enforces the executable's final-marker
protocol. It cannot decide whether a written proof, specification, derivation,
or explanation is substantively correct; use the human checklist in
`COMPLETION.md` for those deliverables.

Task prompts are deliberately staged so every completed task leaves the file
compilable. Modules are either completed in one task, assembled from top-level
helpers after those helpers exist, or developed as explicit stage modules.

## Recommended course order

The file numbers preserve the source-map grouping, but the recommended order
is intentionally not strictly numeric in the modules block:

| Order | Labs | Main purpose |
|---:|---|---|
| 1 | E04 | List recursion and tail position |
| 2 | E05-E07 | Records, options, variants, patterns, errors, trees |
| 3 | E08-E10 | Higher-order functions, folds, and matrices |
| 4 | E11 | Signatures, encapsulation, and staged abstraction |
| 5 | E16 | Real `.ml`/`.mli` compilation-unit experiments |
| 6 | E15 | Functors and `include` |
| 7 | E12-E14 | Generic queues, maps, sets, and cost models |
| 8 | E17 | Interface-preserving algebra refactor |
| 9 | E18-E19 | State, aliasing, and arrays |
| 10 | E20-E22 | Promises, Lwt scheduling, and monads |
| 11 | E23-E29 | Specifications, AF/RI, OUnit, Bisect, QCheck, and proofs |
| 12 | E30-E32 | Hashing, probing, and ordered trees |
| 13 | E42 | Supplemental graph representations and search |
| 14 | E33-E35 | Productive sequences, numerical streams, and laziness |
| 15 | E36-E40 | Parsing, formal semantics, environments, and inference |
| 16 | E41 | Curry-Howard synthesis |

Project-only material is retained where useful and is labelled `Extension`.
An extension supplements the source exercise; it is not its mapped
counterpart.

## Supplemental 99 Problems practice

The 15 added task blocks begin at E06; nothing was inserted into E01-E05. They
were selected only where the existing sequence lacked the same exercise:
recursive nested data and codecs, global sorting criteria, a priority worklist,
list-monad search, generative trees, Gray-code layers, arithmetic clients of the
prime stream, and graph search. E42 is numbered after the core sequence but is
recommended immediately after E32 so it stays inside the data-structures block.

The ideas are adapted from [MassD/99 at commit
`aa564de`](https://github.com/MassD/99/tree/aa564decb846577e74de4bc91ba8d8f0d6f5960a),
which is MIT-licensed. The prompts and edge-case contracts here are newly
written; `SOURCE_MAP.md` records the exact selections separately from the 208
textbook exercises. The supplemental tasks are ordinary numbered tasks, so the
completion gate requires them rather than silently treating them as optional.

## Special workflows

E16 uses four real compilation-unit stages under
`exercises/e16_interface_stages/`. Follow its stage-specific build and utop
commands rather than simulating `.mli` behavior with nested modules. The
completion gate builds all four stages.

E25 and E26 use the textbook's actual testing tools. Their prompts contain the
OUnit, Bisect, and QCheck commands and state what evidence to inspect. A custom
random loop does not satisfy a QCheck task.

E36 uses three complete SimPL projects under `exercises/e36_simpl_stages/` to
make the textbook's actual ocamllex/Menhir associativity and precedence
experiments reproducible. E38 uses one cumulative learner-edited SimPL project
under `exercises/e38_pair_stage/work/`; its black-box check must fail before
pair support and pass only after parsing, typing, and both evaluators agree.

E36-E40 preserve manual parser observations, labelled operational traces,
typing derivations, constraint collection, and unification work before asking
for automation. Getting the final value or type alone is not completion.

## Formatting and diagnostics

Warnings are enabled but are not promoted to errors. Understand each warning
before suppressing it. Format only the lab you have just completed and inspect
its diff:

```sh
opam exec -- ocamlformat --enable-outside-detected-project \
  --inplace exercises/e08_function_composition.ml
git diff -- exercises/e08_function_composition.ml
```

## Offline reference and provenance

The unmodified textbook is stored at
`reference/ocaml_programming_fall_2026.pdf`. Its SHA-256 and pinned source
commit are recorded in `reference/README.md`. The printed PDF section numbers
differ from the older numbers embedded in the public website URLs;
`SOURCE_MAP.md` records both.

The textbook is © 2021-2026 Michael R. Clarkson et al. and distributed under
CC BY-NC-ND 4.0. The exercise prompts here are newly written study material;
the source names and links are a provenance index, not a claim of verbatim
reproduction. The supplemental provenance above is independent of the pinned
textbook coverage count.

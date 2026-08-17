(** E01 — Semantics sprint (25-35 min)

    OUTCOME

    - Replace C++ instincts with OCaml's syntax, type, and evaluation rules.
    - Classify failures by phase before trying to fix them.

    START HERE

    - Do not run the file yet.
    - Open the [PREDICTIONS] block immediately below this comment.

    STEP 1 — PREDICT THE PHRASES

    - Record the type and value, or the kind of error, for each phrase:
      [7 * (1 + 2 + 3)], ["CS " ^ string_of_int 3110], [3.14 /. 2.],
      [if true then 42 else 7], [if true then 42 else 7.],
      [let add x y = x + y in add 5], and [(fun x -> x) (fun y -> y)].
    - For an error, choose lexing, parsing, typing, or evaluation.

    STEP 2 — CHECK THE PREDICTIONS

    - Run small experiments only after every prediction is written.
    - Quote the decisive part of each compiler message in the block below.
    - Predict and check [(=)] versus [(==)] on independently built equal strings.

    STEP 3 — READ ONE DOCUMENTATION PAGE

    - Use https://ocaml.org/manual/5.4/expr.html.
    - Find the float operators and exponentiation function yourself.

    STEP 4 — IMPLEMENT TOP-TO-BOTTOM

    - Explain the inferred types of [choose] and [keep].
    - Implement each typed hole in source order.
    - Do not convert between [int] and [float] to avoid choosing an operator.
<D-a
    STEP 5 — FINISH

    - Run [opam exec -- dune exec exercises/e01_semantics_sprint.exe].
    - Inspect types with
      opam exec -- dune exec exercises/e01_semantics_sprint.exe].
    - Refactor once for clarity after all checks pass.

    Source coverage: values; operators; equality; assert; if; double fun; more fun; RMS;
    poly types; divide; associativity; average; hello world. *)

(* PREDICTIONS:
   1. int = 42
   2. string, "CS 3110"
   3. float, 1.57
   4. int 42
   5. error, typing
   6. int, 5
   7. fun? idk
   ERROR EXPLANATION for [if true then 42 else 7.]:
*)

let choose b x y = if b then x else y
let keep b x = if b then x else x
let double (_x : int) : int = _x * 2
let cube (_x : float) : float = _x ** 3.
let sign_if (_x : int) : int = if (_x = 0) then 0 else _x / abs(_x)
let circle_area (_radius : float) : float = _radius ** 2. *. Float.pi
let rms (_x : float) (_y : float) : float = Float.sqrt (( _x ** 2. +. _y ** 2.) /. 2. )
let divide ~numerator ~denominator : float = numerator /. denominator
let ( +/. ) (_x : float) (_y : float) : float = (_x +. _y) /. 2.
let close a b = Float.abs (a -. b) < 1e-10

let () =
  assert (double 7 = 14);
  assert (close (cube 2.) 8.);
  assert (List.map sign_if [ -9; 0; 8 ] = [ -1; 0; 1 ]);
  assert (close (circle_area 2.) (4. *. Float.pi));
  assert (close (rms 3. 4.) (sqrt 12.5));
  assert (close (divide ~denominator:4. ~numerator:9.) 2.25);
  assert (close (1. +/. 2.) 1.5);
  print_endline "E01 complete"

(** E02 — Recursion under pressure (30-45 min)

    OUTCOME

    - Turn a direct recursive definition into a constant-stack linear process.
    - Use invariants and counterexamples to debug recursive state.

    STEP 1 — MODEL DATES

    - Decide how [days_in_month] reports an unknown month.
    - Implement it first, then implement [valid_date] by consuming its result.
    - Ignore leap years. Run only the three date assertions if you need feedback.

    STEP 2 — WRITE THE DIRECT FIBONACCI FUNCTION

    - Implement the mathematical definition for [n >= 1].
    - Before timing anything, predict why [fib 45] is much slower than [fib 35].
    - Check small values first; do not wait for a large call to finish.

    STEP 3 — DERIVE THE FAST VERSION

    - Write the invariant for [loop remaining previous current] in the marked block.
    - Implement [fib_fast] only after the invariant is precise.
    - Compare it with [fib] on the supplied range.

    STEP 4 — FIND MACHINE OVERFLOW

    - Implement [first_nonpositive_fib] as a search.
    - Do not hard-code the word size or the expected answer.

    STEP 5 — DEBUG UNFAMILIAR CODE

    - Trace [fib_buggy] on paper for the first few inputs.
    - Record the smallest counterexample and explain the bad state transition.
    - Implement [fib_repaired] independently; do not copy [fib_fast].

    FINISH

    - Run [opam exec -- dune exec exercises/e02_recursion_under_pressure.exe].
    - Read https://cs3110.github.io/textbook/chapters/basics/rec_functions.html only if
      a recursive state or base case remains unclear.

    Source coverage: date fun; fib; fib fast. *)

let days_in_month (_month : string) : int option =
  failwith "TODO: Jan..Dec, including Sept"

let valid_date (_day : int) (_month : string) : bool =
  failwith "TODO: consume days_in_month"

let rec fib (_n : int) : int = failwith "TODO: direct recursive definition"

(* INVARIANT for [loop remaining previous current]: ... *)
let fib_fast (_n : int) : int = failwith "TODO: tail-recursive Fibonacci"
let first_nonpositive_fib () : int = failwith "TODO: search using fib_fast"

let fib_buggy n =
  let rec loop remaining previous current =
    if remaining = 1 then previous else loop (remaining - 1) current (previous + current)
  in
  if n < 1 then invalid_arg "fib_buggy" else loop n 0 1

(* BUG EXPLANATION: ... *)
let fib_repaired (_n : int) : int = failwith "TODO: independent repair"

let () =
  assert (valid_date 30 "Apr");
  assert (not (valid_date 31 "Apr"));
  assert (not (valid_date 1 "Smarch"));
  assert (List.map fib [ 1; 2; 3; 7; 10 ] = [ 1; 1; 2; 13; 55 ]);
  assert (List.init 25 (fun i -> fib_fast (i + 1)) = List.init 25 (fun i -> fib (i + 1)));
  assert (first_nonpositive_fib () > 40);
  assert (
    List.init 25 (fun i -> fib_repaired (i + 1))
    = List.init 25 (fun i -> fib_fast (i + 1)));
  print_endline "E02 complete"

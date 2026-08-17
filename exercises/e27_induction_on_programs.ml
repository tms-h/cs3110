(** E27 — Induction on recursive programs (35-50 min)

    OUTCOME

    - Align proof structure with recursion.
    - Strengthen a claim when the original statement is too weak to induct on.

    STEP 1 — PROVE THE POWER ADDITION LAW

    - State the natural-number preconditions.
    - Prove [pow x (m + n) = pow x m * pow x n] by induction on [m].
    - Name every algebraic fact used in the inductive step.

    STEP 2 — STRENGTHEN FIBONACCI

    - Write the accumulator invariant for [fib_iter].
    - Prove the stronger invariant before implementing the function.
    - Explain why a final-result-only claim does not fit the recursive call.

    STEP 3 — IMPLEMENT AND PROVE SQUARING

    - Implement [pow_square].
    - Prove equivalence to [pow] by strong induction on [n].
    - Split even and odd cases and justify integer division.

    STEP 4 — REMOVE A SPECIAL CASE

    - Implement [pow_square_short] without an [n = 1] branch.
    - Record exactly what changes in the proof.

    STEP 5 — INDUCT ON DATA

    - Implement Peano [mul].
    - Prove [mul n Z = Z] by structural induction on [n].

    STEP 6 — USE TESTS AS PROOF DEBUGGERS

    - Run the bounded checks.
    - Name one implementation bug those checks could miss.
    - Run [opam exec -- dune exec exercises/e27_induction_on_programs.exe].

    Reading fallback:
    https://cs3110.github.io/textbook/chapters/correctness/proving_correctness.html

    Source coverage: exp; fibi; expsq; expsq simplified; mult. *)

let rec pow x n = if n = 0 then 1 else x * pow x (n - 1)
let fib_iter (_n : int) : int = failwith "TODO: accumulator implementation"

let rec pow_square (_x : int) (_n : int) : int =
  failwith "TODO: exponentiation by squaring"

let rec pow_square_short (_x : int) (_n : int) : int =
  failwith "TODO: no n=1 special case"

type nat = Z | S of nat

let rec plus a b = match a with Z -> b | S n -> S (plus n b)
let rec mul (_a : nat) (_b : nat) : nat = failwith "TODO"

(* PROOF 1 — pow addition:

   PROOF 2 — fib accumulator invariant:

   PROOF 3 — pow_square equivalence:

   PROOF 4 — simplified proof delta:

   PROOF 5 — mul n Z:
*)

let () =
  for x = -4 to 4 do
    for n = 0 to 12 do
      assert (pow_square x n = pow x n);
      assert (pow_square_short x n = pow x n)
    done
  done;
  assert (mul (S (S (S Z))) Z = Z);
  print_endline "E27 complete"

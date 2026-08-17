(** E26 — Property-driven debugging (35-50 min)

    OUTCOME

    - Turn prose into executable properties and minimal counterexamples.
    - Debug optimized code against a deliberately obvious oracle.

    IMPORTANT

    - Both implementations below are intentionally buggy.
    - Do not inspect their bodies until you have written the properties.

    STEP 1 — SPECIFY THE FACTOR RESULT

    - Require a positive, odd result that divides [n].
    - Require no smaller odd factor at least 3, except where result 1 is allowed.
    - Exhaustively find the smallest failing [n >= 1].

    STEP 2 — LOCALIZE AND REPAIR

    - Record which property isolates the fault most clearly.
    - Inspect [least_odd_factor_buggy] only now.
    - Implement [least_odd_factor] and retain the counterexample as a regression.

    STEP 3 — BUILD A MEAN ORACLE

    - Implement an obviously correct mean with fold and length.
    - Choose and justify a float tolerance; do not use [(=)].
    - Enumerate short lists whose values range from -2 through 2.

    STEP 4 — SHRINK BEFORE FIXING

    - Find a disagreement with [mean_fast_buggy].
    - Delete elements while the failure persists.
    - Record the smallest counterexample in the marked block.

    STEP 5 — REPAIR AND STRESS

    - Implement [mean_repaired].
    - Run 10,000 deterministic cases against the oracle.
    - Run [opam exec -- dune exec exercises/e26_property_driven_debugging.exe].
    - QCheck reference for later projects: https://github.com/c-cube/qcheck

    Source coverage: qcheck odd divisor; qcheck avg. *)

let least_odd_factor_buggy n =
  if n <= 2 then 1
  else
    let rec search candidate =
      if candidate * candidate >= n then candidate
      else if n mod candidate = 0 then candidate
      else search (candidate + 2)
    in
    search 3

let least_odd_factor (_n : int) : int = failwith "TODO: repaired"

let mean_fast_buggy xs =
  let rec pairs sum count = function
    | a :: b :: rest when a = b -> pairs (sum + a) (count + 1) rest
    | a :: b :: rest -> pairs (sum + a + b) (count + 2) rest
    | [ x ] -> (sum + x, count + 1)
    | [] -> (sum, count)
  in
  let sum, count = pairs 0 0 xs in
  float_of_int sum /. float_of_int count

let mean_reference (_xs : int list) : float = failwith "TODO: obvious oracle"
let mean_repaired (_xs : int list) : float = failwith "TODO"
let smallest_bad_factor_input () : int = failwith "TODO: exhaustive search"
let smallest_bad_mean_input () : int list = failwith "TODO: enumerate and shrink"

(* FAILURE EXPLANATIONS:
   factor:
   mean:
*)

let () =
  let n = smallest_bad_factor_input () in
  assert (n >= 1);
  assert (
    List.for_all
      (fun x ->
        let d = least_odd_factor x in
        d mod 2 = 1 && x mod d = 0)
      (List.init 500 (fun i -> i + 1)));
  let bad = smallest_bad_mean_input () in
  assert (bad <> []);
  assert (Float.abs (mean_fast_buggy bad -. mean_reference bad) > 1e-12);
  assert (Float.abs (mean_repaired bad -. mean_reference bad) < 1e-12);
  print_endline "E26 complete"

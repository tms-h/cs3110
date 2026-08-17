(** E18 — References, aliasing, and state transitions (30-45 min)

    OUTCOME

    - Reason about object identity separately from current contents.
    - Keep mutation local and make state transitions testable.

    STEP 1 — DRAW THE HEAP

    - Implement [raise_gpa] and the three reference values.
    - Draw boxes and arrows for [bool ref], [int list ref], and [int ref list].
    - Mark which values are mutable and which are immutable.

    STEP 2 — STORE A FUNCTION IN STATE

    - Implement [reach_3110] by dereferencing [step].
    - Predict which clients observe a later assignment to [step].
    - Replace the function temporarily, test the prediction, and restore it.

    STEP 3 — IMPLEMENT SMALL MUTATIONS

    - Implement [(+:=)] and [swap].
    - State the read/write sequencing assumed by each implementation.

    STEP 4 — PREDICT ALIAS COMPARISONS

    - Fill the marked prediction block before running comparisons.
    - Predict [x == y], [x == z], [x = y], and [x = z].
    - Mutate [x], predict again, then check.
    - Explain why structural equality on mutable graphs can be expensive or diverge.

    STEP 5 — ROLLBACK ON FAILURE

    - Implement [apply_atomically].
    - Restore the old value when the update raises.
    - Re-raise the same exception and test both success and failure.
    - Run [opam exec -- dune exec exercises/e18_refs_aliasing_and_state.exe].

    Source coverage: mutable fields; refs; inc fun; addition assignment; physical
    equality. *)

type student = { name : string; mutable gpa : float }

let raise_gpa (_s : student) (_new_gpa : float) : unit = failwith "TODO"
let bool_cell : bool ref = failwith "TODO"
let list_cell : int list ref = failwith "TODO"
let cell_list : int ref list = failwith "TODO"
let step = ref (fun x -> x + 1)
let reach_3110 () : int = failwith "TODO: use !step"
let ( +:= ) (_cell : int ref) (_amount : int) : unit = failwith "TODO"
let swap (_a : 'a ref) (_b : 'a ref) : unit = failwith "TODO"

let apply_atomically (_cell : 'a ref) (_update : 'a -> 'a) : unit =
  failwith "TODO: rollback and re-raise"

(* ALIAS PREDICTIONS before mutation: ...
   ALIAS PREDICTIONS after mutation: ...
   STRUCTURAL-EQUALITY RISK: ... *)

let () =
  let alice = { name = "Alice"; gpa = 3.7 } in
  raise_gpa alice 4.0;
  assert (alice.gpa = 4.0);
  assert (!bool_cell && !list_cell = [ 1; 2 ] && List.map ( ! ) cell_list = [ 3; 4 ]);
  assert (reach_3110 () = 3110);
  let n = ref 10 in
  n +:= 5;
  assert (!n = 15);
  let a = ref 1 and b = ref 2 in
  swap a b;
  assert ((!a, !b) = (2, 1));
  apply_atomically a (fun x -> x + 10);
  assert (!a = 12);
  assert (
    try
      apply_atomically a (fun _ -> failwith "boom");
      false
    with
    | Failure "boom" -> !a = 12
    | _ -> false);
  print_endline "E18 complete"

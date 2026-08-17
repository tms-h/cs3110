(** E04 — Tail recursion and list shape (35-50 min)

    OUTCOME

    - Derive accumulator invariants instead of adding an [acc] mechanically.
    - Recognize when a one-pass algorithm needs an explicit state machine.

    CONTRACT

    - A negative count is invalid. Raise [Invalid_argument].

    STEP 1 — BUILD THE SIMPLE VERSIONS

    - Implement [take] and [drop] directly recursively.
    - Check empty, short, exact-length, and overlong inputs.

    STEP 2 — MAKE THEM CONSTANT-STACK

    - Write the accumulator invariant in the marked block before writing code.
    - Implement [take_tr] and [drop_tr] with explicit helpers.
    - Test with a list of one million elements.

    STEP 3 — SCAN A LIST AS A STATE MACHINE

    - Implement [is_unimodal] in one pass and O(1) auxiliary space.
    - Allow equal adjacent values before or after the peak.
    - Debug with [1; 3; 2; 4], which changes direction twice.

    STEP 4 — FOLLOW THE RECURSIVE SHAPE

    - Derive [powerset] from P(S) and P(x union S).
    - Avoid duplicate recursive calls.
    - Explain why the output size is unavoidable.

    STEP 5 — COMPARE ITERATION STYLES

    - Implement [print_int_list] directly recursively.
    - Implement [print_int_list_iter] with [List.iter].
    - Keep formatting separate from traversal.

    STEP 6 — TRANSFER

    - Implement [chunks_of] tail-recursively without [take] or [drop].
    - Permit a short final chunk.
    - Run [opam exec -- dune exec exercises/e04_tail_recursion_and_shape.exe].

    Source coverage: take drop; take drop tail; unimodal; powerset; print int list rec;
    print int list iter. *)

let rec take (_n : int) (_xs : 'a list) : 'a list = failwith "TODO"
let rec drop (_n : int) (_xs : 'a list) : 'a list = failwith "TODO"

(* ACCUMULATOR INVARIANT for [take_tr]: ... *)
let take_tr (_n : int) (_xs : 'a list) : 'a list = failwith "TODO"
let drop_tr (_n : int) (_xs : 'a list) : 'a list = failwith "TODO"
let is_unimodal (_xs : int list) : bool = failwith "TODO: one-pass state machine"
let rec powerset (_xs : 'a list) : 'a list list = failwith "TODO"
let rec print_int_list (_xs : int list) : unit = failwith "TODO"
let print_int_list_iter (_xs : int list) : unit = failwith "TODO: List.iter"
let chunks_of (_width : int) (_xs : 'a list) : 'a list list = failwith "TODO: transfer"

let () =
  assert (take 3 [ 1; 2; 3; 4; 5 ] = [ 1; 2; 3 ]);
  assert (drop 3 [ 1; 2; 3; 4; 5 ] = [ 4; 5 ]);
  assert (take_tr 99 [ 1; 2 ] = [ 1; 2 ] && drop_tr 99 [ 1; 2 ] = []);
  assert (is_unimodal [] && is_unimodal [ 1; 2; 2; 5; 4; 4; -1 ]);
  assert (not (is_unimodal [ 1; 3; 2; 4 ]));
  assert (List.length (powerset [ 1; 2; 3; 4 ]) = 16);
  assert (chunks_of 3 [ 1; 2; 3; 4; 5; 6; 7 ] = [ [ 1; 2; 3 ]; [ 4; 5; 6 ]; [ 7 ] ]);
  print_endline "E04 complete"

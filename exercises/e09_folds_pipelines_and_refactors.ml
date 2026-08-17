(** E09 — Folds, pipelines, and representation changes (35-50 min)

    OUTCOME

    - Choose map, filter, or fold from the shape of the required result.
    - Reason about accumulator order before refactoring implementations.

    STEP 1 — COMPARE THE TWO FOLDS

    - Implement [product_left] and [product_right].
    - Keep them terse, but retain names that reveal argument order.

    STEP 2 — BUILD A DATA PIPELINE

    - Implement [sum_cube_odd] with map, filter, and fold.
    - Write [sum_cube_odd_pipe] with [|>].
    - Define no new recursive helper for either version.

    STEP 3 — TEST SHORT-CIRCUITING

    - Implement [exists_rec], [exists_fold], and [exists_lib].
    - Predict which implementations can stop before the list ends.
    - Verify with a predicate that increments a counter.

    STEP 4 — DEBUG OPERAND ORDER

    - Implement the three balance functions.
    - Use a non-symmetric debit example to expose a wrong [fold_right] order.
    - Explain the required order before fixing it.

    STEP 5 — CHOOSE ONE COMBINATOR PER JOB

    - Use https://ocaml.org/manual/5.4/api/List.html.
    - Implement [long_strings], [increment_floats], and [join].
    - Ensure [join] emits no leading or trailing separator.

    STEP 6 — DEDUPLICATE AND FINISH

    - Implement [unique_keys] after reading [List.sort_uniq].
    - State its time complexity.
    - Run [opam exec -- dune exec exercises/e09_folds_pipelines_and_refactors.exe].

    Source coverage: product; terse product; sum_cube_odd; sum_cube_odd pipeline;
    exists; account balance; more list fun; association list keys. *)

let product_left : float list -> float = failwith "TODO"
let product_right : float list -> float = failwith "TODO"
let sum_cube_odd (_n : int) : int = failwith "TODO: no rec"
let sum_cube_odd_pipe (_n : int) : int = failwith "TODO: use |>"
let rec exists_rec (_p : 'a -> bool) (_xs : 'a list) : bool = failwith "TODO"
let exists_fold (_p : 'a -> bool) (_xs : 'a list) : bool = failwith "TODO"
let exists_lib (_p : 'a -> bool) (_xs : 'a list) : bool = failwith "TODO"
let rec balance_rec (_initial : int) (_debits : int list) : int = failwith "TODO"
let balance_left (_initial : int) (_debits : int list) : int = failwith "TODO"
let balance_right (_initial : int) (_debits : int list) : int = failwith "TODO"
let long_strings (_xs : string list) : string list = failwith "TODO"
let increment_floats (_xs : float list) : float list = failwith "TODO"
let join (_sep : string) (_xs : string list) : string = failwith "TODO"
let unique_keys (_bindings : ('k * 'v) list) : 'k list = failwith "TODO"

let () =
  assert (product_left [] = 1. && product_right [ 2.; 3.; 4. ] = 24.);
  assert (sum_cube_odd 5 = 153 && sum_cube_odd_pipe 5 = 153);
  assert (exists_rec (( = ) 3) [ 1; 2; 3 ]);
  assert (exists_fold (fun x -> x < 0) [ 1; -1; 2 ]);
  assert (not (exists_lib (fun x -> x = 0) [ 1; 2 ]));
  assert (balance_rec 100 [ 10; 5; 12 ] = 73);
  assert (balance_left 100 [ 10; 5; 12 ] = 73);
  assert (balance_right 100 [ 10; 5; 12 ] = 73);
  assert (long_strings [ "one"; "three"; "seven" ] = [ "three"; "seven" ]);
  assert (increment_floats [ 0.; 2.5 ] = [ 1.; 3.5 ]);
  assert (join "," [ "hi"; "bye" ] = "hi,bye" && join "," [] = "");
  assert (unique_keys [ (2, "b"); (1, "x"); (2, "c") ] = [ 1; 2 ]);
  print_endline "E09 complete"

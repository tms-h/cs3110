(** E10 — A checked matrix pipeline (40-50 min)

    OUTCOME

    - Compose validation, transposition, dot products, and nested mapping.
    - Turn shape mistakes into explicit API errors.

    STEP 1 — VALIDATE THE REPRESENTATION

    - Implement [shape].
    - Accept only a non-empty matrix with non-empty, equal-width rows.
    - Return [(rows, columns)] instead of a Boolean.

    STEP 2 — ADD WITH A CHECKED BOUNDARY

    - Implement [add_rows] with [List.map2].
    - Implement polymorphic [map2_matrix].
    - Convert a size mismatch into [Shape_mismatch] at your API boundary.

    STEP 3 — CHOOSE A DOT-PRODUCT TOOL

    - Read [List.combine], [List.map2], and [List.fold_left2].
    - Choose one for [dot] and write down why.
    - Implement [dot] only after deciding mismatch behavior.

    STEP 4 — BUILD MULTIPLICATION

    - Implement [transpose] without mutable arrays.
    - Validate both matrices before multiplication.
    - Map over rows and transposed columns to produce the result.

    STEP 5 — DEBUG THE NESTING

    - Predict which test would fail if the nested maps were swapped.
    - Make the swap temporarily, run the test, and explain the dimensions.
    - Restore the correct order.

    FINISH

    - Run [opam exec -- dune exec exercises/e10_matrix_pipeline.exe].

    Source coverage: valid matrix; row vector add; matrix add; matrix multiply. *)

type matrix_error = Invalid_matrix | Shape_mismatch of (int * int) * (int * int)

let shape (_m : 'a list list) : (int * int) option = failwith "TODO"
let add_rows (_a : int list) (_b : int list) : int list = failwith "TODO"

let map2_matrix (_f : 'a -> 'b -> 'c) (_a : 'a list list) (_b : 'b list list) :
    ('c list list, matrix_error) result =
  failwith "TODO"

let add_matrices a b = map2_matrix ( + ) a b
let dot (_a : int list) (_b : int list) : int = failwith "TODO"
let transpose (_m : 'a list list) : 'a list list = failwith "TODO"

let multiply (_a : int list list) (_b : int list list) :
    (int list list, matrix_error) result =
  failwith "TODO"

let () =
  assert (shape [ [ 1; 2; 3 ]; [ 4; 5; 6 ] ] = Some (2, 3));
  assert (shape [] = None && shape [ []; [] ] = None && shape [ [ 1 ]; [ 2; 3 ] ] = None);
  assert (add_rows [ 1; 1; 1 ] [ 9; 8; 7 ] = [ 10; 9; 8 ]);
  assert (
    add_matrices [ [ 1; 2 ]; [ 3; 4 ] ] [ [ 4; 3 ]; [ 2; 1 ] ]
    = Ok [ [ 5; 5 ]; [ 5; 5 ] ]);
  assert (transpose [ [ 1; 2; 3 ]; [ 4; 5; 6 ] ] = [ [ 1; 4 ]; [ 2; 5 ]; [ 3; 6 ] ]);
  assert (
    multiply [ [ 1; 2; 3 ]; [ 4; 5; 6 ] ] [ [ 7; 8 ]; [ 9; 10 ]; [ 11; 12 ] ]
    = Ok [ [ 58; 64 ]; [ 139; 154 ] ]);
  print_endline "E10 complete"

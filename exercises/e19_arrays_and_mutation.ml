(** E19 — Arrays, mutation, and alias-safe construction (35-45 min)

    OUTCOME

    - Compare functional array traversals with explicit loops.
    - Detect and prevent shared-row aliasing in nested arrays.

    STEP 1 — WRITE THE NONMUTATING NORM

    - Open https://ocaml.org/manual/5.4/api/Array.html.
    - Implement [norm_functional] with Array mapping/folding.
    - Confirm the input array is unchanged.

    STEP 2 — NORMALIZE IN PLACE

    - Decide and document behavior for a zero vector.
    - Implement [normalize_functional_style] with [Array.iteri].
    - Test the return value, mutated contents, and resulting norm.

    STEP 3 — REIMPLEMENT WITH LOOPS

    - Implement [norm_loop] and [normalize_loop] with [for].
    - Compare both styles on deterministic randomized small arrays.
    - Explain any numerical tolerance you use.

    STEP 4 — PREDICT THE MATRIX ALIAS BUG

    - Fill [ARRAY.MAKE ALIAS PREDICTION] before coding [init_matrix].
    - Predict the effect of mutating one cell in an [Array.make] matrix.
    - Implement [init_matrix] with independent rows and verify the prediction.

    STEP 5 — TRANSFER AND FINISH

    - Reject a nonsquare matrix before any mutation.
    - Implement [transpose_square_in_place] without a second matrix.
    - Run [opam exec -- dune exec exercises/e19_arrays_and_mutation.exe].

    Source coverage: norm; normalize; norm loop; normalize loop; init matrix. *)

type vector = float array

let norm_functional (_v : vector) : float = failwith "TODO"
let normalize_functional_style (_v : vector) : unit = failwith "TODO"
let norm_loop (_v : vector) : float = failwith "TODO"
let normalize_loop (_v : vector) : unit = failwith "TODO"

let init_matrix (_rows : int) (_cols : int) (_f : int -> int -> 'a) : 'a array array =
  failwith "TODO: independent rows"

let transpose_square_in_place (_m : 'a array array) : unit = failwith "TODO: transfer"

(* ARRAY.MAKE ALIAS PREDICTION: ... *)

let close a b = Float.abs (a -. b) < 1e-10

let () =
  assert (close (norm_functional [| 3.; 4. |]) 5.);
  assert (close (norm_loop [| 3.; 4. |]) 5.);
  let a = [| 3.; 4. |] and b = [| 3.; 4. |] in
  normalize_functional_style a;
  normalize_loop b;
  assert (Array.to_list a = Array.to_list b && close (norm_loop a) 1.);
  let m = init_matrix 2 3 (fun i j -> (10 * i) + j) in
  m.(0).(0) <- 99;
  assert (m.(1).(0) = 10);
  let square = [| [| 1; 2; 3 |]; [| 4; 5; 6 |]; [| 7; 8; 9 |] |] in
  transpose_square_in_place square;
  assert (
    Array.map Array.to_list square
    |> Array.to_list
    = [ [ 1; 4; 7 ]; [ 2; 5; 8 ]; [ 3; 6; 9 ] ]);
  print_endline "E19 complete"

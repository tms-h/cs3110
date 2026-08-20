(** E10 — Matrix pipelines (70-95 min)

    Build: [opam exec -- dune build exercises/e10_matrix_pipeline.exe] Run:
    [opam exec -- dune exec exercises/e10_matrix_pipeline.exe] *)

(* Task 1 — Validate matrix shape.
   Extension: define variant [matrix_error] with [Invalid_matrix] and
   [Shape_mismatch of (int * int) * (int * int)].

   Define [shape matrix] to return [Some (rows, columns)] exactly for a nonempty
   list of nonempty rows that all have equal length; otherwise return [None].
   Test a 2-by-3 matrix, [], [[]], [ []; [] ], and a ragged matrix.
   Example form: [type grid_error = Empty_grid | Uneven_rows of int * int]
   Build and run before continuing. *)

(* Task 2 — Add row vectors.
   Define [add_rows a b] with [List.map2] to add corresponding integers. Let
   [Invalid_argument] escape when lengths differ.

   Test two empty rows, [1; 1; 1] plus [9; 8; 7], and mismatched lengths.
   Example form: [let pairwise_max xs ys = List.map2 max xs ys]
   Build and run before continuing. *)

(* Task 3 — Extension: map over two matrices.
   Define [map2_matrix f a b]. Return [Error Invalid_matrix] if either matrix has
   no valid shape. If valid shapes differ, return
   [Error (Shape_mismatch (shape_a, shape_b))]. Otherwise return [Ok result],
   where [result] has the same dimensions and each cell is [f] applied to the
   corresponding cells of [a] and [b].

   Test two 2-by-2 matrices, a ragged input, and a 1-by-2 versus 2-by-1 mismatch.
   Example form: [match dimensions grid with None -> Error Empty_grid | Some size -> Ok size]
   Build and run before continuing. *)

(* Task 4 — Add matrices.
   Define [add_matrices a b] by calling [map2_matrix] with integer addition.
   Test two 2-by-2 matrices whose result is [[5; 5]; [5; 5]], and test one shape
   mismatch.
   Example form: [let combine_grids a b = map2_grid ( + ) a b]
   Build and run before continuing. *)

(* Task 5 — Extension: factor dot products.
   Define [dot a b] as the sum of corresponding products. Return 0 for two empty
   lists and let [Invalid_argument] escape when lengths differ.

   Test empty lists, [1; 2; 3] with [4; 5; 6], and mismatched lengths.
   Example form: [List.map2 max xs ys |> List.fold_left max min_int]
   Build and run before continuing. *)

(* Task 6 — Extension: factor matrix transposition.
   Define [transpose matrix] for valid matrices so rows become columns. Define
   [transpose [] = []]. The result for invalid nonempty matrices is outside the
   contract because callers validate first.

   Test [] and [[1; 2; 3]; [4; 5; 6]]. Test that transposing a valid matrix
   twice returns the original.
   Stop when the rows are empty; only take heads and tails after the caller has
   established that every current row is nonempty.
   Example form: [let all_empty rows = List.for_all (fun row -> row = []) rows]
   Build and run before continuing. *)

(* Task 7 — Multiply matrices.
   Define [multiply a b]. Return [Error Invalid_matrix] if either input is
   invalid. For valid shapes [(ar, ac)] and [(br, bc)], return
   [Error (Shape_mismatch ((ar, ac), (br, bc)))] when [ac <> br]. Otherwise
   return the [ar]-by-[bc] matrix of row-column dot products.

   Test a 2-by-3 times 3-by-2 product yielding [[58; 64]; [139; 154]], one
   incompatible pair, and one invalid matrix. After every required assertion and
   written explanation in E10 is present, print exactly [E10 passed].
   Example form: [let cell row column = List.map2 ( * ) row column |> List.fold_left ( + ) 0]
   Build and run before continuing. *)

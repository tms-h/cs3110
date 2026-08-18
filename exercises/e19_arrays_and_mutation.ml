(** E19 — Arrays and alias-safe construction (70-95 min)

    Build: [opam exec -- dune build exercises/e19_arrays_and_mutation.exe] Run:
    [opam exec -- dune exec exercises/e19_arrays_and_mutation.exe] Reading:
    https://ocaml.org/manual/5.4/api/Array.html *)

(* Task 1 — Compute a vector norm functionally.
   Define [vector = float array]. Define [close a b] as absolute difference less
   than [1e-10]. Define [norm_functional v] with Array map/fold as
   [sqrt (v[0]² + ... + v[n-1]²)]. The norm of an empty vector is 0.0 and the
   input must not change.

   Example form: [let total squares = Array.fold_left ( +. ) 0.0 squares]
   Test [], [3.0; 4.0], and unchanged input contents.
   Build and run before continuing. *)

(* Task 2 — Normalize with [Array.iteri].
   Define [normalize_functional_style v] to divide every element by the original
   norm in place. Return unit. Leave a zero-norm vector unchanged.

   Test [3.0; 4.0] becomes approximately [0.6; 0.8] with norm 1.0, and test a
   zero vector remains unchanged.
   Example form: [Array.iteri (fun i x -> values.(i) <- x +. offset) values]
   Build and run before continuing. *)

(* Task 3 — Reimplement with loops.
   Define [norm_loop v] and [normalize_loop v] with [for] loops and the same
   contracts as Tasks 1 and 2.

   Generate deterministic arrays from lengths 0 through 20 with values in
   [-5.0, 5.0]. Test the two norms approximately agree and both normalizers
   produce approximately equal arrays.
   Example form: [for i = 0 to Array.length values - 1 do total := !total + values.(i) done]
   Build and run before continuing. *)

(* Task 4 — Initialize independent matrix rows.
   Define [init_matrix rows cols f] returning an array of [rows] arrays, where
   cell [(i, j)] equals [f i j]. Raise [Invalid_argument "dimensions"] when a
   dimension is negative. Every row must be a distinct array.

   Test a 2-by-3 matrix with [f i j = 10*i + j]. Mutate cell (0,0) and test cell
   (1,0) remains 10. Test zero rows, zero columns, and a negative dimension.
   Example form: [Array.init height (fun row -> Array.init width (fun column -> row + column))]
   Build and run before continuing. *)

(* Task 5 — Transpose a square matrix in place.
   Define [transpose_square_in_place matrix]. First verify the matrix has [n]
   rows and every row has length [n]; raise [Invalid_argument "square"] before
   any mutation otherwise. Swap only cells above the diagonal and allocate no
   second matrix.

   Test empty, 1-by-1, and the 3-by-3 matrix containing 1 through 9. Test a
   nonsquare matrix raises and retains its original contents.
   Example form: [let saved = values.(i) in values.(i) <- values.(j); values.(j) <- saved]
   Build and run before continuing. *)

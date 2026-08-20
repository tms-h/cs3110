(** E19 — Arrays and alias-safe construction (70-95 min)

    Build: [opam exec -- dune build exercises/e19_arrays_and_mutation.exe] Run:
    [opam exec -- dune exec exercises/e19_arrays_and_mutation.exe] Reading:
    https://ocaml.org/manual/5.3/api/Array.html *)

(* Task 1 — Compute a vector norm with array combinators.
   Define [type vector = float array] and [close a b] using absolute difference
   below [1e-10]. Define [norm v] with [Array.map] and an array fold. It computes
   the square root of the sum of squared components and must not mutate [v].

   Preserve the textbook's representation invariant that vectors are nonempty.
   Test [|3.0; 4.0|], a one-element vector, and unchanged input contents.
   Build and run before continuing. *)

(* Task 2 — Normalize with [Array.iteri].
   Define [normalize_iteri v] to divide every component by the vector's original
   norm in place and return unit. State the missing mathematical precondition
   explicitly: the input has nonzero norm.

   Test that [|3.0; 4.0|] becomes approximately [|0.6; 0.8|] with norm 1.0, and
   that the function returns unit.
   Build and run before continuing. *)

(* Task 3 — Reimplement both operations with loops.
   Define [norm_loop] and [normalize_loop] with [for] loops and the same
   contracts as Tasks 1 and 2. Generate comparison inputs with
   [Array.init length (fun i -> float_of_int (((7 * i) + length) mod 11 - 5))]
   for lengths 1 through 20, skipping generated zero-norm inputs before calling
   either normalization function. Assert the norms and normalized arrays agree.
   Build and run before continuing. *)

(* Task 4 — Initialize independent matrix rows.
   Define [init_matrix rows cols f] returning [rows] separately allocated arrays,
   with cell [(i,j)] equal to [f i j]. Require nonnegative dimensions.

   Test a 2-by-3 matrix, mutate cell (0,0), and assert row 1 did not change. Also
   test zero rows and zero columns. Do not use [Array.make_matrix] for the
   implementation.
   Build and run before continuing. *)

(* Extension — Define boundary behavior.
   Relax the vector RI to permit empty arrays, define [norm [||] = 0.0], and make
   both normalization functions leave empty and zero-norm vectors unchanged.
   Test both implementations on [||] and [|0.0; 0.0|]. Also replace the matrix
   dimension precondition with a checked failure: each negative dimension raises
   exactly [Invalid_argument "dimensions"]. *)

(* Extension — Transpose a square matrix in place.
   Define [transpose_square_in_place]. Validate the complete square shape before
   mutating; on failure raise [Invalid_argument "square"] and leave the matrix
   unchanged. Swap only cells above the diagonal and allocate no second matrix.
   Test [||], 1-by-1, 3-by-3, and an invalid matrix. *)

(* Final task — Completion marker.
   Only after every required assertion above passes, make the completed program
   print exactly [E19 passed] once. *)

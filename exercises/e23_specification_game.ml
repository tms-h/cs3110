(** E23 — Specifications and polynomial abstraction (90-120 min)

    Build: [opam exec -- dune build exercises/e23_specification_game.exe] Run:
    [opam exec -- dune exec exercises/e23_specification_game.exe] Reading:
    https://cs3110.github.io/textbook/chapters/correctness/specifications.html *)

(* Task 1 — Turn prose into exact contracts.
   Define [is_sorted xs] to return true exactly when adjacent integers are
   nondecreasing. Define [second_largest xs] to return the second greatest
   distinct integer, or [None] when fewer than two distinct values exist. Define
   [num_vowels s] to count ASCII a, e, i, o, and u case-insensitively.

   Write requires/returns clauses in comments. Test [], duplicates, descending
   data, [second_largest [3; 1; 3; 2]], and [num_vowels "OCaml Universe"].
   Example form: [(* Returns [true] exactly when every integer in [values] is positive. *)]
   Build and run before continuing. *)

(* Task 2 — Define the polynomial interface.
   Define module type [POLY] with abstract [t], [zero], [of_coefficients],
   [coefficients], [eval], [add], [mul], [degree], and [equal]. Coefficients use
   ascending powers: [a0; a1; ...] means [a0 + a1*x + ...]. The zero polynomial
   has coefficients [0] and degree [None]. Trailing zeros are ignored.

   Use the operation types implied by integer coefficients and evaluation. Run
   interface inspection before implementing the module.
   Example form: [module type SERIES = sig type t val empty : t val evaluate : t -> int -> int end]
   Build and run before continuing. *)

(* Task 3 — Normalize polynomial construction.
   Begin unsealed [Poly_impl] with [int list] representation. Define
   [normalize coefficients] to remove trailing zeros while representing every
   all-zero list, including [], as [0]. Define [zero] and [of_coefficients].

   Test [], [0; 0], [1; 2; 0; 0], and [0; 1; 1].
   Example form: [let rec remove_trailing_empty items = List.rev items |> drop_empty |> List.rev]
   Build and run before continuing. *)

(* Task 4 — Observe and evaluate polynomials.
   Define [coefficients], [degree], [equal], and [eval]. [degree] is the greatest
   nonzero exponent or [None] for zero. [equal] compares mathematical
   polynomials. Implement evaluation with Horner's rule.

   Test zero, [1; 2; 0; 0], equality with [1; 2], and evaluation of [0; 1; 1]
   at 10 yielding 110.
   Example form: [let decimal_value digits = List.fold_left (fun acc digit -> (10 * acc) + digit) 0 digits]
   Build and run before continuing. *)

(* Task 5 — Add polynomials.
   Define [add a b] by adding corresponding coefficients and normalizing the
   result. Missing coefficients count as zero.

   Test [1; 2] + [-1; 3; 4] = [0; 5; 4], addition with zero, and cancellation
   to the canonical zero polynomial.
   Example form: [let pairwise_larger left right = List.map2 max left right]
   Build and run before continuing. *)

(* Task 6 — Multiply and seal polynomials.
   Define [mul a b] by convolution: result coefficient [k] is
   [sum (a[i] * b[k-i])] over valid indices. Normalize the result. Seal the
   finished module as [Poly : POLY].

   Test [1; 1] * [1; -1] = [1; 0; -1], multiplication by zero, and a constant
   times [0; 1; 1].
   Example form: [let weighted values = List.mapi (fun index value -> index * value) values]
   Build and run before continuing. *)

(* Task 7 — Test the client boundary.
   Define [client_demo (module P : POLY)] to build [p = 0 + x + x²], add
   [1 - x], and return its value at 10 plus its degree. Test the result is
   [(101, Some 2)].

   Change [Poly_impl] to an array representation without changing [POLY] or
   [client_demo], then rerun every client test.
   Example form: [let client (module S : SERIES) = S.evaluate S.empty 7]
   Build and run before continuing. *)

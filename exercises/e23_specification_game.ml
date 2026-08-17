(** E23 — The specification game (40-50 min)

    OUTCOME

    - Write contracts that resist a devious but literal implementation.
    - See how representation and canonicalization affect an API.

    STEP 1 — ATTACK THREE CONTRACTS

    - Write requires, returns, and raises clauses for [is_sorted], [second_largest], and
      [num_vowels] in the marked block.
    - Invent one implementation per function that exploits an ambiguity.
    - Tighten each contract to close the loophole before continuing.

    STEP 2 — SPECIFY POLYNOMIALS FIRST

    - Read [POLY] as a client.
    - Decide coefficient order, the degree of zero, treatment of trailing zeros, integer
      overflow behavior, and semantic equality.
    - Finish every specification before editing [Poly].

    STEP 3 — STATE AND ENFORCE THE RI

    - Use no trailing zero coefficient.
    - Give zero exactly one representation.
    - Implement [normalize] first and route constructors through it.

    STEP 4 — IMPLEMENT IN DEPENDENCY ORDER

    - Implement observations, evaluation, addition, and multiplication.
    - Write multiplication without mutation first.
    - State its complexity before any optional array-backed refactor.

    STEP 5 — TEST THE BOUNDARY

    - Write a client using only [POLY].
    - Change the hidden representation from list to array.
    - Confirm the client remains unchanged.
    - Run [opam exec -- dune exec exercises/e23_specification_game.exe].

    Reading fallback:
    https://cs3110.github.io/textbook/chapters/correctness/specifications.html

    Source coverage: spec game; poly spec; poly impl. *)

(* CONTRACTS AND DEVIOUS IMPLEMENTATIONS:
   is_sorted:
   second_largest:
   num_vowels:
*)

module type POLY = sig
  type t

  val zero : t
  (** TODO: finish every specification before code. *)

  val of_coefficients : int list -> t
  val coefficients : t -> int list
  val eval : int -> t -> int
  val add : t -> t -> t
  val mul : t -> t -> t
  val degree : t -> int option
  val equal : t -> t -> bool
end

module Poly : POLY = struct
  type t = int list

  let normalize (_coefficients : int list) : t = failwith "TODO: enforce RI"
  let zero = [ 0 ]
  let of_coefficients xs = normalize xs
  let coefficients (_p : t) : int list = failwith "TODO"
  let eval (_x : int) (_p : t) : int = failwith "TODO: prefer Horner"
  let add (_a : t) (_b : t) : t = failwith "TODO"
  let mul (_a : t) (_b : t) : t = failwith "TODO"
  let degree (_p : t) : int option = failwith "TODO"
  let equal (_a : t) (_b : t) : bool = failwith "TODO"
end

let client_demo (module P : POLY) =
  let p = P.of_coefficients [ 0; 1; 1 ] in
  let q = P.add p (P.of_coefficients [ 1; -1 ]) in
  (P.eval 10 q, P.degree q)

let () =
  let open Poly in
  assert (coefficients (of_coefficients [ 1; 2; 0; 0 ]) = [ 1; 2 ]);
  assert (degree zero = None);
  assert (eval 10 (of_coefficients [ 0; 1; 1 ]) = 110);
  assert (
    coefficients (add (of_coefficients [ 1; 2 ]) (of_coefficients [ -1; 3; 4 ]))
    = [ 0; 5; 4 ]);
  assert (
    coefficients (mul (of_coefficients [ 1; 1 ]) (of_coefficients [ 1; -1 ]))
    = [ 1; 0; -1 ]);
  assert (client_demo (module Poly) = (101, Some 2));
  print_endline "E23 complete"

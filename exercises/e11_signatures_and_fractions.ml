(** E11 — Signatures, sealing, and fraction invariants (40-50 min)

    OUTCOME

    - Hide a representation behind a useful public contract.
    - Preserve one canonical form through every constructor and operation.

    STEP 1 — PROBE A SMALL SIGNATURE

    - Complete [COMPLEX] using its [t] synonym.
    - Predict the error from omitting [zero], hiding [add], and using integer pairs.
    - Try those changes one at a time; record the decisive message; then revert.

    STEP 2 — DESIGN FROM THE CLIENT BACKWARDS

    - Read the tests before implementing [FRACTION].
    - Check that [t] is abstract at the client boundary.
    - Add or clarify specifications before touching the representation.

    STEP 3 — STATE THE INVARIANT

    - Require a positive denominator.
    - Require [gcd (abs numerator) denominator = 1].
    - Decide and document the canonical representation and printing of zero.

    STEP 4 — IMPLEMENT THROUGH ONE NORMALIZER

    - Implement [gcd] and [normalize] first.
    - Route [make], [add], and [mul] through [normalize].
    - Implement accessors and conversions only after constructors preserve the RI.

    STEP 5 — TRANSFER AND INSPECT

    - Explain the abstraction function in the marked block.
    - Implement [compare] without float conversion; discuss integer overflow.
    - Run [opam exec -- dune exec exercises/e11_signatures_and_fractions.exe].
    - Inspect with [opam exec -- ocamlc -i exercises/e11_signatures_and_fractions.ml].

    Reading fallback: https://cs3110.github.io/textbook/chapters/modules/modules.html

    Source coverage: complex synonym; complex encapsulation; fraction; fraction reduced.
*)

module type COMPLEX = sig
  type t = float * float

  val zero : t
  val add : t -> t -> t
end

module Complex : COMPLEX = struct
  type t = float * float

  let zero = (0., 0.)
  let add (_a : t) (_b : t) : t = failwith "TODO"
end

module type FRACTION = sig
  type t

  val make : int -> int -> t
  val numerator : t -> int
  val denominator : t -> int
  val to_string : t -> string
  val to_float : t -> float
  val add : t -> t -> t
  val mul : t -> t -> t
  val compare : t -> t -> int
end

module Fraction : FRACTION = struct
  type t = int * int

  let rec gcd (_a : int) (_b : int) : int = failwith "TODO"
  let normalize (_n : int) (_d : int) : t = failwith "TODO: enforce RI"
  let make n d = normalize n d
  let numerator (_x : t) : int = failwith "TODO"
  let denominator (_x : t) : int = failwith "TODO"
  let to_string (_x : t) : string = failwith "TODO"
  let to_float (_x : t) : float = failwith "TODO"
  let add (_a : t) (_b : t) : t = failwith "TODO"
  let mul (_a : t) (_b : t) : t = failwith "TODO"
  let compare (_a : t) (_b : t) : int = failwith "TODO: no floats"
end

(* AF: ...
   WHY CANONICALIZATION ENABLES REPRESENTATION EQUALITY: ... *)

let () =
  assert (Complex.add Complex.zero (2., -3.) = (2., -3.));
  let half = Fraction.make 2 4 in
  let minus_half = Fraction.make 3 (-6) in
  assert (Fraction.to_string half = "1/2");
  assert (Fraction.to_string minus_half = "-1/2");
  assert (Fraction.to_string (Fraction.add half minus_half) = "0/1");
  assert (Fraction.to_string (Fraction.mul half (Fraction.make 10 3)) = "5/3");
  assert (Fraction.compare half minus_half > 0);
  print_endline "E11 complete"

(** E17 — Algebra refactor under API lock (40-50 min)

    OUTCOME

    - Remove structural duplication with signatures, [include], and functors.
    - Preserve every public [RING] and [FIELD] type while refactoring.

    CONSTRAINTS

    - Declare each operation name directly in only one base signature.
    - Define primitive integer operations once and float operations once.
    - Define [of_int] algorithmically once in a reusable functor.
    - Produce both rational fields from one functor.

    STEP 1 — MAP THE CODEBASE

    - Read all signatures, modules, functors, and tests before editing.
    - Draw the intended reuse graph.
    - Run [ocamlc -i exercises/e17_algebra_refactor.ml] as a baseline.

    STEP 2 — ADD INTEGER CONVERSION ONCE

    - Implement [Add_of_int] using only operations supplied by [R].
    - Handle negative inputs.
    - Use doubling so recursion depth is not linear in the magnitude.
    - Compile before continuing.

    STEP 3 — BUILD THE CONCRETE RINGS AND FIELDS

    - Complete [Int_core] and [Float_core].
    - Construct rings and fields with [include], not repeated wrappers.
    - Recheck inferred interfaces.

    STEP 4 — GENERATE RATIONAL FIELDS

    - State the rational representation invariant.
    - Decide how division by zero is reported.
    - Implement [Rational] without float-based normalization.

    STEP 5 — AUDIT AND FINISH

    - Compare final [ocamlc -i] output with the baseline public APIs.
    - Explain each surprising equality or hidden type.
    - Run [opam exec -- dune exec exercises/e17_algebra_refactor.exe].

    Source coverage: refactor arith. *)

module type CORE_RING = sig
  type t

  val zero : t
  val one : t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
end

module type RING = sig
  include CORE_RING

  val of_int : int -> t
end

module type FIELD = sig
  include RING

  val div : t -> t -> t
end

module Add_of_int (R : CORE_RING) : RING with type t = R.t = struct
  include R

  let of_int (_n : int) : t = failwith "TODO: doubling, including negative"
end

module Int_core : CORE_RING with type t = int = struct
  type t = int

  let zero = 0
  let one = 1
  let add (_a : t) (_b : t) = failwith "TODO"
  let sub (_a : t) (_b : t) = failwith "TODO"
  let mul (_a : t) (_b : t) = failwith "TODO"
end

module Float_core : CORE_RING with type t = float = struct
  type t = float

  let zero = 0.
  let one = 1.
  let add (_a : t) (_b : t) = failwith "TODO"
  let sub (_a : t) (_b : t) = failwith "TODO"
  let mul (_a : t) (_b : t) = failwith "TODO"
end

module Int_ring = Add_of_int (Int_core)
module Float_ring = Add_of_int (Float_core)

module Int_field : FIELD with type t = int = struct
  include Int_ring

  let div (_a : t) (_b : t) = failwith "TODO"
end

module Float_field : FIELD with type t = float = struct
  include Float_ring

  let div (_a : t) (_b : t) = failwith "TODO"
end

module Rational (F : FIELD) : FIELD with type t = F.t * F.t = struct
  type t = F.t * F.t

  let zero = (F.zero, F.one)
  let one = (F.one, F.one)
  let add (_a : t) (_b : t) : t = failwith "TODO"
  let sub (_a : t) (_b : t) : t = failwith "TODO"
  let mul (_a : t) (_b : t) : t = failwith "TODO"
  let div (_a : t) (_b : t) : t = failwith "TODO"
  let of_int n = (F.of_int n, F.one)
end

module Int_rational = Rational (Int_field)
module Float_rational = Rational (Float_field)

let () =
  assert (Int_ring.of_int (-13) = -13);
  assert (Float_ring.of_int 7 = 7.);
  assert (Int_field.div 7 2 = 3);
  assert (Float_field.div 7. 2. = 3.5);
  assert (Int_rational.add (1, 2) (1, 3) = (5, 6));
  print_endline "E17 complete"

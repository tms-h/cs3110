(** E17 — Refactor a duplicated algebra implementation (105-145 min)

    This file begins with the pinned textbook's working [algebra.ml] starter.
    Refactor the code in place; do not replace its public API with a new one.

    Build: [opam exec -- dune build exercises/e17_algebra_refactor.exe] Run:
    [opam exec -- dune exec exercises/e17_algebra_refactor.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e17_algebra_refactor.ml] *)

(* Task 1 — Establish the baseline.
   Build the untouched starter below. Save the complete output of the inspection
   command in a comment. The public API that must remain unchanged contains
   [Ring], [Field], [IntRing], [IntField], [FloatRing], [FloatField],
   [IntRational], and [FloatRational]. In particular, preserve the operators,
   unary negation, [to_string], [of_int], and the abstract result types.
   Build and run before continuing. *)

(* Task 2 — Refactor signature duplication.
   Use [include] and any private helper signatures you need so that no public
   operation is directly declared in more than one base signature. Do not add,
   remove, rename, or reorder behavior in the public [Ring] and [Field] APIs.
   Re-run interface inspection and compare it with the baseline.
   Build and run before continuing. *)

(* Task 3 — Refactor implementation duplication.
   Reorganize the integer and float structures so their shared ring operations
   are directly defined once per representation and reused by the corresponding
   field. Preserve the public abstraction: clients must still see each module
   through [Ring] or [Field], not a manifest [int] or [float] type.

   Add client assertions through [of_int], the arithmetic operators, and
   [to_string] without accessing a hidden representation.
   Build and run before continuing. *)

(* Task 4 — Share [of_int].
   Introduce a functor that can construct [of_int] for an arbitrary ring core;
   directly define that conversion algorithm only once. Derive it solely from
   the core's [zero], [one], addition, and negation behavior. The final public
   module interfaces must still match Task 1.
   Build and run before continuing. *)

(* Task 5 — Share rational arithmetic.
   Replace [IntRational] and [FloatRational]'s duplicated bodies with one functor
   applied to [IntRing] and [FloatRing]. Its parameter needs ring operations, not
   base-field division. Preserve unary negation and [to_string]. State the
   representation precondition that stored denominators are nonzero and the
   division precondition that the divisor's numerator is nonzero.

   Test addition, negation, multiplication, division by a nonzero rational, and
   conversion from an integer through each public module.
   Build and run before continuing. *)

(* Task 6 — Prove interface preservation.
   Run interface inspection again and compare every public declaration with the
   saved baseline. In comments, count the remaining direct definitions and
   explain where reuse now occurs. A refactor that changes a public name, hides
   [to_string], exposes [type t = int], or replaces unary negation with binary
   subtraction is not complete.
   Build and run before continuing. *)

(* Extension — Logarithmic conversion.
   Improve the shared [of_int] algorithm to use doubling with logarithmic
   recursion depth. Include [min_int] in the tests; do not compute [-min_int]. *)

(* Final task — Completion marker.
   Only after the final interface matches the saved baseline and all required
   assertions and explanations pass, add the required
   [let () = print_endline "E17 passed"] statement at the physical end of this
   file, after the refactored starter code below. It must print exactly once. *)

module type Ring = sig
  type t

  val zero : t
  val one : t
  val ( + ) : t -> t -> t
  val ( ~- ) : t -> t
  val ( * ) : t -> t -> t
  val to_string : t -> string
  val of_int : int -> t
end

module type Field = sig
  type t

  val zero : t
  val one : t
  val ( + ) : t -> t -> t
  val ( ~- ) : t -> t
  val ( * ) : t -> t -> t
  val ( / ) : t -> t -> t
  val to_string : t -> string
  val of_int : int -> t
end

module IntRing : Ring = struct
  type t = int

  let zero = 0
  let one = 1
  let ( + ) = ( + )
  let ( ~- ) = ( ~- )
  let ( * ) = ( * )
  let to_string = string_of_int
  let of_int n = n
end

module IntField : Field = struct
  type t = int

  let zero = 0
  let one = 1
  let ( + ) = ( + )
  let ( ~- ) = ( ~- )
  let ( * ) = ( * )
  let ( / ) = ( / )
  let to_string = string_of_int
  let of_int n = n
end

module FloatRing : Ring = struct
  type t = float

  let zero = 0.
  let one = 1.
  let ( + ) = ( +. )
  let ( ~- ) = ( ~-. )
  let ( * ) = ( *. )
  let to_string = string_of_float
  let of_int = float_of_int
end

module FloatField : Field = struct
  type t = float

  let zero = 0.
  let one = 1.
  let ( + ) = ( +. )
  let ( ~- ) = ( ~-. )
  let ( * ) = ( *. )
  let ( / ) = ( /. )
  let to_string = string_of_float
  let of_int = float_of_int
end

module IntRational : Field = struct
  type t = int * int

  let zero = (0, 1)
  let one = (1, 1)
  let ( + ) (a, b) (c, d) = ((a * d) + (c * b), b * d)
  let ( ~- ) (a, b) = (-a, b)
  let ( / ) (a, b) (c, d) = (a * d, b * c)
  let ( * ) (a, b) (c, d) = (a * c, b * d)
  let to_string (a, b) = string_of_int a ^ "/" ^ string_of_int b
  let of_int n = (n, 1)
end

module FloatRational : Field = struct
  type t = float * float

  let zero = (0., 1.)
  let one = (1., 1.)
  let ( + ) (a, b) (c, d) = ((a *. d) +. (c *. b), b *. d)
  let ( ~- ) (a, b) = (-.a, b)
  let ( / ) (a, b) (c, d) = (a *. d, b *. c)
  let ( * ) (a, b) (c, d) = (a *. c, b *. d)
  let to_string (a, b) = string_of_float a ^ "/" ^ string_of_float b
  let of_int n = (float_of_int n, 1.)
end

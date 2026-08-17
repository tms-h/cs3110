(** E17 — Algebraic reuse with modules (105-145 min)

    Build: [opam exec -- dune build exercises/e17_algebra_refactor.exe] Run:
    [opam exec -- dune exec exercises/e17_algebra_refactor.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e17_algebra_refactor.ml] *)

(* Task 1 — Define ring and field signatures.
   Define [CORE_RING] with type [t], values [zero] and [one], and binary [add],
   [sub], and [mul]. Define [RING] by including [CORE_RING] and adding
   [of_int : int -> t]. Define [FIELD] by including [RING] and adding
   [div : t -> t -> t].

   Run interface inspection and verify each operation name is declared in only
   one base signature.
   Build and run before continuing. *)

(* Task 2 — Generate [of_int].
   Define [Add_of_int (R : CORE_RING)] returning [RING with type t = R.t]. Include
   [R]. Define [of_int n] using [zero], [one], [add], and [sub] only. Handle
   negative integers and use doubling so recursion depth is O(log |n|).

   Instantiate a minimal integer core and test -13, 0, 1, and 14.
   Build and run before continuing. *)

(* Task 3 — Define integer and float rings.
   Define [Int_core : CORE_RING with type t = int] and
   [Float_core : CORE_RING with type t = float] using the native arithmetic
   operators. Define [Int_ring = Add_of_int (Int_core)] and
   [Float_ring = Add_of_int (Float_core)].

   Test integer -13 and float 7.0 through [of_int], plus one addition and one
   multiplication in each ring.
   Build and run before continuing. *)

(* Task 4 — Extend rings to fields.
   Define [Int_field : FIELD with type t = int] by including [Int_ring] and using
   integer division. Define [Float_field : FIELD with type t = float] by including
   [Float_ring] and using float division.

   Test [Int_field.div 7 2 = 3] and [Float_field.div 7.0 2.0 = 3.5]. Test integer
   division by zero raises [Division_by_zero], and test positive float division
   by 0.0 produces positive infinity with [Float.is_infinite].
   Build and run before continuing. *)

(* Task 5 — Define rational-pair arithmetic.
   Define [Rational (F : FIELD)] returning [FIELD with type t = F.t * F.t]. Treat
   [(n, d)] as [n/d], with nonzero denominator as a client precondition. Define
   [zero = (F.zero, F.one)], [one = (F.one, F.one)], and:

   - add [(a*d + c*b, b*d)]
   - sub [(a*d - c*b, b*d)]
   - mul [(a*c, b*d)]
   - div [(a*d, b*c)]
   - [of_int n = (F.of_int n, F.one)]

   Do not reduce pairs. Test 1/2 + 1/3 = 5/6 and 2/3 * 3/4 = 6/12 with the
   integer field.
   Build and run before continuing. *)

(* Task 6 — Instantiate both rational modules.
   Define [Int_rational = Rational (Int_field)] and
   [Float_rational = Rational (Float_field)]. Test zero, one, [of_int 4], one
   subtraction, and one division in each module using exact pair results.

   Inspect the final interfaces and verify both rational modules came from the
   same functor body.
   Build and run before continuing. *)

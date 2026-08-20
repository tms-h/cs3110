(** E11 — Signatures and fraction invariants (90-120 min)

    Build: [opam exec -- dune build exercises/e11_signatures_and_fractions.exe] Run:
    [opam exec -- dune exec exercises/e11_signatures_and_fractions.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e11_signatures_and_fractions.ml] Reading:
    https://cs3110.github.io/textbook/chapters/modules/modules.html *)

(* Task 1 — Define and explain a manifest complex-number signature.
   Define module type [COMPLEX] with manifest type [t = float * float], value
   [zero : t], and [add : t -> t -> t]. In a comment, also write the equivalent
   expanded types without the synonym and explain what repetition [t] removes.

   Define sealed module [Complex : COMPLEX] with componentwise addition. Test
   that adding [zero] to [(2.0, -3.0)] returns [(2.0, -3.0)].
   Example form: [module type POINT = sig type t = int * int val origin : t end]
   Build and run before continuing. *)

(* Task 2 — Investigate signature matching and encapsulation.
   In utop, make each of these changes independently to a copy of [Complex], then
   undo it before trying the next one:

   - remove [zero] from the structure;
   - remove [add] from the signature but leave it in the structure;
   - change the structure's zero to [(0, 0)] instead of [(0.0, 0.0)].

   Predict each result before evaluating it. Record in comments whether the copy
   is accepted, which values remain visible through the sealed signature, and why
   any error occurs. Do not leave an intentionally ill-typed experiment in this
   file.
   Build and run before continuing. *)

(* Task 3 — Specify an abstract fraction interface.
   Define module type [FRACTION] with abstract type [t] and operations [make],
   [numerator], [denominator], [to_string], [to_float], [add], and [mul]. Use:

   - [make : int -> int -> t]
   - [numerator : t -> int] and [denominator : t -> int]
   - [to_string : t -> string] and [to_float : t -> float]
   - [add : t -> t -> t] and [mul : t -> t -> t]

   Extension: also include [compare : t -> t -> int]. Define no implementation
   yet. Run the interface-inspection command and verify that [t] remains abstract.
   Example form: [module type COUNTER = sig type t val create : unit -> t val read : t -> int end]
   Build and run before continuing. *)

(* Task 4 — Strengthen and normalize the representation.
   The basic fraction interface could represent one half as [(2, 4)]. Now adopt
   the stronger invariant that every stored pair is reduced, has a positive
   denominator, and represents zero as [(0, 1)].

   At top level, define [type fraction_rep = int * int], [gcd a b], and
   [make_rep n d]. [gcd] returns a nonnegative greatest common divisor;
   [make_rep] enforces the invariant and raises [Invalid_argument "denominator"]
   when [d = 0]. Test 2/4, 3/(-6), 0/5, (-2)/(-4), and denominator zero.

   Assume inputs and intermediate arithmetic stay within OCaml's [int] range;
   record that limitation in a comment.
   Example form: [let standardize (hours, minutes) = (hours + (minutes / 60), minutes mod 60)]
   Build and run before continuing. *)

(* Task 5 — Observe the staged representation.
   At top level, define [numerator_rep], [denominator_rep], [to_string_rep], and
   [to_float_rep] over [fraction_rep]. Format strings as ["n/d"] with the sign
   only on [n].

   Test 2/4 as numerator 1, denominator 2, string ["1/2"], and float 0.5. Test
   3/(-6) as ["-1/2"] and zero as ["0/1"].
   Example form: [let render (hours, minutes) = Printf.sprintf "%d:%02d" hours minutes]
   Build and run before continuing. *)

(* Task 6 — Add staged fraction arithmetic.
   At top level, define [add_rep (a, b) (c, d)] as
   [(a*d + c*b)/(b*d)] and [mul_rep (a, b) (c, d)] as [(a*c)/(b*d)]. Route both
   results through [make_rep].

   Extension: define [compare_rep (a, b) (c, d)] by comparing [a*d] with [c*b]
   without floats. The integer-range limitation from Task 4 applies to all three
   operations, not just comparison.

   Test 1/2 + (-1/2) = 0/1, 1/2 + 1/3 = 5/6, and 1/2 * 10/3 = 5/3.
   Example form: [let add_minutes normalize (hours, minutes) extra = normalize (hours, minutes + extra)]
   Build and run before continuing. *)

(* Task 7 — Assemble and seal the fraction module.
   Define one complete [Fraction_impl] module whose type [t] is [fraction_rep]
   and whose operations reuse the top-level functions from Tasks 4–6. Because
   the module is completed in this single task, the file remains compilable after
   every earlier task.

   Seal it as [module Fraction : FRACTION = Fraction_impl]. Test 1/2 against
   -1/2, equality of 2/4 and 1/2, and -3/4 against -1/2 using only [Fraction].
   After every required assertion and written explanation in E11 is present,
   print exactly [E11 passed].
   Example form: [module Clock : CLOCK = Clock_impl]
   Build and run before continuing. *)

(** E11 — Signatures and fraction invariants (90-120 min)

    Build: [opam exec -- dune build exercises/e11_signatures_and_fractions.exe] Run:
    [opam exec -- dune exec exercises/e11_signatures_and_fractions.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e11_signatures_and_fractions.ml] Reading:
    https://cs3110.github.io/textbook/chapters/modules/modules.html *)

(* Task 1 — Define a manifest complex-number signature.
   Define module type [COMPLEX] with manifest type [t = float * float], value
   [zero : t], and [add : t -> t -> t]. Define sealed module [Complex : COMPLEX]
   with componentwise addition.

   Test that adding [zero] to [(2.0, -3.0)] returns [(2.0, -3.0)].
   Build and run before continuing. *)

(* Task 2 — Specify an abstract fraction interface.
   Define module type [FRACTION] with abstract type [t] and operations [make],
   [numerator], [denominator], [to_string], [to_float], [add], [mul], and
   [compare]. Use these types:

   - [make : int -> int -> t]
   - [numerator : t -> int] and [denominator : t -> int]
   - [to_string : t -> string] and [to_float : t -> float]
   - [add : t -> t -> t], [mul : t -> t -> t], and [compare : t -> t -> int]

   Define no implementation yet. Run the interface-inspection command and check
   that [t] remains abstract.
   Build and run before continuing. *)

(* Task 3 — Normalize fraction construction.
   Begin unsealed module [Fraction_impl] with representation [int * int]. Define
   [gcd a b] to return the nonnegative greatest common divisor. Define
   [normalize n d] and [make n d] so every value has positive denominator,
   coprime numerator and denominator, and zero represented as [(0, 1)]. Raise
   [Invalid_argument "denominator"] when [d = 0].

   Test 2/4, 3/(-6), 0/5, (-2)/(-4), and denominator zero by temporarily
   inspecting the unsealed representation.
   Build and run before continuing. *)

(* Task 4 — Observe fractions.
   In [Fraction_impl], define [numerator], [denominator], [to_string], and
   [to_float]. Format as ["n/d"] with the sign only on [n].

   Test 2/4 as numerator 1, denominator 2, string ["1/2"], and float 0.5. Test
   3/(-6) as ["-1/2"] and zero as ["0/1"].
   Build and run before continuing. *)

(* Task 5 — Add fraction arithmetic.
   Define [add (a/b) (c/d)] as [(a*d + c*b)/(b*d)] and
   [mul (a/b) (c/d)] as [(a*c)/(b*d)], routing both through [normalize].

   Test 1/2 + (-1/2) = 0/1, 1/2 + 1/3 = 5/6, and 1/2 * 10/3 = 5/3.
   Build and run before continuing. *)

(* Task 6 — Compare and seal fractions.
   Define [compare (a/b) (c/d)] by comparing [a*d] with [c*b], without floats.
   State the possible integer-overflow limitation in a comment. Seal the finished
   implementation as [module Fraction : FRACTION = Fraction_impl].

   Test 1/2 against -1/2, equality of 2/4 and 1/2, and -3/4 against -1/2 using
   only the sealed module.
   Build and run before continuing. *)

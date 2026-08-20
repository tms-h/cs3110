(** E23 — Adversarial specifications and polynomial abstraction (90-120 min)

    Build: [opam exec -- dune build exercises/e23_specification_game.exe] Run:
    [opam exec -- dune exec exercises/e23_specification_game.exe] Reading:
    https://cs3110.github.io/textbook/chapters/correctness/specifications.html *)

(* Task 1 — Play the specification game.
   With a partner, take turns as specifier and devious implementer. If working
   alone, alternate roles in writing and do not revise a specification while in
   the implementer role. Complete at least two rounds using functions such as
   [num_vowels], [is_sorted], [sort], [max], [is_prime], [is_palindrome],
   [second_largest], or tree [depth].

   For each round:
   1. The specifier writes a type plus requires/returns clauses, without code.
   2. The implementer writes code that satisfies the literal words while
      violating the apparent intent, and supplies a revealing test.
   3. Record the exploited ambiguity, then refine the specification.
   4. Repeat until the same exploit no longer satisfies the contract; finally
      implement the intended behavior and test boundary partitions.

   Preserve the initial, attacked, and revised specifications in comments.
   Build and run before continuing. *)

(* Task 2 — Design a polynomial interface before implementing it.
   Start from only this required core:

   [module type POLY = sig]
   [  type t]
   [  val eval : int -> t -> int]
   [end]

   The abstraction represents immutable, dense, single-variable polynomials
   with integer coefficients. Invent operations that let a client create,
   combine, and query polynomials. Write complete specification comments for
   every operation. Where relevant to the design you choose, settle such issues
   as coefficient order, zero, trailing zeros, degree, equality, and exceptional
   behavior. Do not copy the fixed reference interface in the Extension below;
   the point of this task is to make and defend your own API choices.

   Before implementing anything, attack the interface as a devious implementer:
   identify at least three interpretations the current wording must rule out.
   Revise and freeze the interface, then inspect it.
   Build before continuing. *)

(* Task 3 — Implement your specification.
   Choose a representation suitable for dense polynomials and implement exactly
   the interface you froze. Document its abstraction function, representation
   invariant, and [rep_ok] if the RI is nontrivial. Derive black-box assertions
   only from the public specifications. Keep representation-specific assertions
   inside an implementation-local white-box test function.

   Include zero and constants in the test partitions. Also test every boundary
   created by your chosen operations: for example trailing-zero inputs if you
   accept coefficient sequences, unequal degrees and cancellation if you provide
   addition, and multiplication-specific cases if you provide multiplication.
   Build and run before continuing. *)

(* Task 4 — Review the abstraction boundary.
   Define a client function that accepts only a sealed [POLY] module. Run it on
   your implementation, then try to write a representation-dependent client and
   record the expected type error. Re-read each specification as a devious
   implementer; if a test relies on unstated behavior, fix the specification or
   the test rather than silently assuming it.
   Build and run before continuing. *)

(* Extension — Implement a shared reference interface two ways.
   For a concrete comparison after completing your own design, define a separate
   [REFERENCE_POLY] with exactly these operations:

   [zero : t]
   [of_coefficients : int list -> t]
   [coefficients : t -> int list]
   [eval : int -> t -> int]
   [add : t -> t -> t]
   [mul : t -> t -> t]
   [degree : t -> int option]
   [equal : t -> t -> bool]

   Specify ascending coefficient order and canonical [coefficients zero = [0]].
   Implement sealed [PolyList] with a list representation and Horner evaluation.
   Then implement a separate sealed [PolyArray] with an array representation;
   do not mutate or replace [PolyList]. Use one black-box test function and one
   first-class-module client against both. Keep each implementation's white-box
   tests inside that implementation so every earlier assertion remains valid. *)

(* Final task — Completion marker.
   Only after both specification-game records, the frozen [POLY] design, its
   implementation, and all required tests are complete, make the program print
   exactly [E23 passed] once. *)

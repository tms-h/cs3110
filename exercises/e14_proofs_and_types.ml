open! Core

(* E14 — Proofs, equational reasoning, and propositions as types

   These tasks keep the reasoning skills that make refactors and abstractions
   trustworthy, without turning them into three near-duplicate proof modules. *)

(* Task 1 — Prove a recursive program correct.
   State and prove by induction that [List.length (List.rev xs) =
   List.length xs]. Name the induction hypothesis and every list equation used;
   then encode representative checks to catch a mismatched statement. *)

(* Task 2 — Reason structurally about trees.
   For the BST from E10, prove that in-order traversal of a valid tree is sorted.
   Identify exactly where the ordering invariant is needed, and why induction
   on height alone would give a less useful hypothesis. *)

(* Task 3 — Strengthen a tail-recursive theorem.
   Implement [rev_append] and a tail-recursive [rev]. Discover and prove the
   accumulator lemma needed to show equivalence with the simple specification.
   Explain why the stronger statement makes the induction go through. *)

(* Task 4 — Test algebraic laws at an abstraction boundary.
   State identity and associativity laws for one combine operation from an
   earlier exercise. Distinguish the mathematical specification from finite
   Quickcheck evidence, and name assumptions such as integer overflow. *)

(* Task 5 — Read propositions as types.
   Implement values with types [('a * 'b) -> ('b * 'a)],
   [('a -> 'b) -> ('b -> 'c) -> 'a -> 'c], and
   [('a -> 'b) -> ('a -> 'c) -> 'a -> 'b * 'c]. Explain introduction and
   elimination for products/functions, then explain why no total value has
   type ['a] in ordinary OCaml without an effect, exception, or nontermination.

   After all checks pass, print exactly [E14 passed] as the final output line. *)

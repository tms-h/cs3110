(** E28 — Structural proofs and lemmas (90-125 min)

    Build: [opam exec -- dune build exercises/e28_structural_proofs.exe] Run:
    [opam exec -- dune exec exercises/e28_structural_proofs.exe] *)

(* Task 1 — Prove reverse through helper lemmas.
   Define recursive [rev xs] using [rev tail @ [head]]. In comments, prove in
   order: [xs @ [] = xs], [rev (xs @ ys) = rev ys @ rev xs], and
   [rev (rev xs) = xs], using each earlier lemma explicitly.

   Test all three equations on [] and on [1; 2; 3; 4].
   Build and run before continuing. *)

(* Task 2 — Reflect binary trees.
   Define ['a tree = Leaf | Node of 'a tree * 'a * 'a tree]. Define [size] as
   node count and [reflect] by recursively swapping left and right subtrees.

   Prove [size (reflect t) = size t] by structural induction. Test a leaf and a
   three-node tree with unequal subtree shapes.
   Build and run before continuing. *)

(* Task 3 — State the correct fold theorem.
   In comments, state sufficient associativity plus left- and right-identity
   assumptions for [List.fold_left op identity xs] to equal
   [List.fold_right op xs identity]. Do not assume commutativity.

   Test the theorem with string concatenation on [] and ["a"; "b"; "c"].
   Build and run before continuing. *)

(* Task 4 — Collect proposition atoms.
   Define [proposition] with [Atom of string], [Not], [And], [Or], and [Implies].
   Write its structural induction principle in comments. Define [atoms p] to
   return distinct atom names in first-occurrence, left-to-right traversal order.

   Test a single atom and [(p ∧ q) → (q ∨ ¬r)], expecting ["p"; "q"; "r"].
   Build and run before continuing. *)

(* Task 5 — Simplify propositions without new atoms.
   Define [simplify p] recursively. Eliminate double negation
   [Not (Not p) -> simplify p] and implication
   [Implies (p, q) -> Or (Not (simplify p), simplify q)]; preserve atoms and
   recursively simplify other constructors.

   Test both rewrites, then test every atom in [simplify p] occurs in [atoms p]
   for the proposition from Task 4.
   Build and run before continuing. *)

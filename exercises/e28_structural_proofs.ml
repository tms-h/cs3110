(** E28 — Structural proofs and supporting lemmas (90-125 min)

    Build: [opam exec -- dune build exercises/e28_structural_proofs.exe] Run:
    [opam exec -- dune exec exercises/e28_structural_proofs.exe] *)

(* Task 1 — Establish the append lemmas.
   Prove [xs @ [] = xs] for every list by structural induction on [xs]. Also
   state and prove append associativity in the orientation needed later:
   [(xs @ ys) @ zs = xs @ (ys @ zs)]. Do not cite associativity without making
   it an explicit available lemma in this standalone file.

   After both proofs, test them on empty and nonempty lists. Runtime examples do
   not replace either proof.
   Build and run before continuing. *)

(* Task 2 — Prove the reverse theorems in dependency order.
   Define the deliberately simple recursive reverse:
   [rev [] = []] and [rev (head :: tail) = rev tail @ [head]].

   First prove for all [xs] and [ys]:
   [rev (xs @ ys) = rev ys @ rev xs]. State which list is the induction variable
   and use both Task 1 lemmas explicitly. Then prove [rev (rev xs) = xs], citing
   the distribution theorem rather than reproving it.

   Add tests for distribution on [([], [1;2])], [([1;2], [])], and
   [([1;2], [3;4])], plus involution on empty and nonempty lists.
   Build and run before continuing. *)

(* Task 3 — Reflect binary trees.
   Define ['a tree = Leaf | Node of 'a tree * 'a * 'a tree], node-counting [size],
   and [reflect] by recursively swapping subtrees. Prove
   [size (reflect t) = size t] for every tree by structural induction. State both
   induction hypotheses in the node case and show where each is used.

   Test a leaf and a tree whose left and right shapes differ.
   Build and run before continuing. *)

(* Task 4 — Formulate and prove the noncommutative fold theorem.
   The familiar theorem assuming an associative and commutative operator does
   not explain why left and right folds with string concatenation agree. Discover
   a weaker theorem in which the operator is associative but need not commute.
   The source hint is to add the right condition on the initial accumulator.

   State every algebraic assumption precisely, formulate the theorem for an
   arbitrary list, and prove it. If the induction needs a generalized accumulator
   lemma, state and prove that lemma first. Only afterward test empty and
   nonempty string lists. A pair of string assertions is not a proof.
   Build and run before continuing. *)

(* Task 5 — State a structural induction principle for propositions.
   Define propositions with atomic names, negation, conjunction, disjunction,
   and implication. Write the complete induction principle: one base obligation
   for atoms and one constructor obligation for each recursive form, with an
   induction hypothesis for every recursive child. Then use the principle to
   outline a small proof of your choice about all propositions.
   Build before continuing. *)

(* Extension — Atom collection and semantics-preserving simplification.
   Define [atoms] to return distinct names in first-occurrence, left-to-right
   order. Define [simplify] to remove implication and double negation. Use a
   helper that simplifies a newly constructed negation, so simplifying
   [Implies (Not p, q)] cannot leave [Not (Not ...)] behind.

   Define an evaluator under a truth assignment. Prove by structural induction
   that simplification preserves evaluation and introduces no new atoms. Then
   add representative executable checks, including an implication whose
   antecedent is a negation. *)

(* Final task — Completion marker.
   Only after all required theorems, prerequisite lemmas, and executable checks
   are complete, make the program print exactly [E28 passed] once. *)

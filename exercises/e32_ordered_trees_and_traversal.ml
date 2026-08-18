(** E32 — Ordered trees and red-black invariants (100-140 min)

    Build: [opam exec -- dune build exercises/e32_ordered_trees_and_traversal.exe] Run:
    [opam exec -- dune exec exercises/e32_ordered_trees_and_traversal.exe] Reading:
    https://cs3110.github.io/textbook/chapters/ds/rb.html *)

(* Task 1 — Define a functorized BST set.
   Define module type [ORDERED] with type [t] and [compare]. Define functor
   [Make_bst_set (Ord : ORDERED)] with [elt = Ord.t], tree type [t], [empty],
   [mem], and persistent [add]. Equal elements are not duplicated; use only
   [Ord.compare].

   Instantiate a case-insensitive string set. Test empty membership, insertion,
   and that ["OCaml"] plus ["ocaml"] occupy one logical element.
   Example form: [module Make_tree (Ord : ORDERED) = struct type t = Empty | Node of t * Ord.t * t end]
   Build and run before continuing. *)

(* Task 2 — Enumerate set elements.
   In [Make_bst_set], define [elements set] as ascending inorder traversal in
   O(n) time, with one [::] per node and no [@].

   Test scrambled integer insertion yields [1; 2; 3; 4] and the case-insensitive
   set returns one representative for the duplicated word.
   Example form: [let rec collect_right tree acc = match tree with Empty -> acc | Node (_, x, right) -> collect_right right (x :: acc)]
   Build and run before continuing. *)

(* Task 3 — Define efficient tree traversals.
   Define ['a tree = Leaf | Node of 'a tree * 'a * 'a tree]. Define [preorder],
   [inorder], and [postorder] with accumulators, one [::] per node, and no [@].

   On the balanced tree containing 1 through 7 with root 4, test exact results
   [4;2;1;3;6;5;7], [1;2;3;4;5;6;7], and [1;3;2;5;7;6;4].
   Example form: [let rec node_count = function Leaf -> 0 | Node (left, _, right) -> 1 + node_count left + node_count right]
   Build and run before continuing. *)

(* Task 4 — Audit red-black trees.
   Define [color = Red | Black] and
   ['a rb_tree = RLeaf | RNode of color * left * value * right]. Define
   [audit_rb compare tree] to return [Ok black_height] when the root is black,
   keys satisfy strict BST order, no red node has a red child, and both subtrees
   have equal black height. Count black internal nodes; [RLeaf] has height 0.
   Return [Error message] for any violation.

   Test a black root with two red children returns [Ok 1], then separately test
   red root, red-red, unequal black height, and BST-order violations return Error.
   Example form: [match inspect child with Ok summary -> Ok (extend summary) | Error message -> Error message]
   Build and run before continuing. *)

(* Task 5 — Construct three valid colorings.
   Define [rb_height_2], [rb_height_3], and [rb_height_4] as colorings of the
   perfect BST containing 1 through 15. For height 2 color levels black-red-black-red;
   for height 3 use black-black-red-black; for height 4 make every level black.

   Test inorder values are 1 through 15 and [audit_rb Int.compare] returns the
   named black height for each tree.
   Example form: [let sample = RNode (Black, RNode (Red, RLeaf, 1, RLeaf), 2, RLeaf)]
   Build and run before continuing. *)

(* Task 6 — Audit a hand insertion.
   Hand-insert letters [D A T A S T R U C T U R E] with the textbook red-black
   insertion algorithm and define [inserted_letters_tree] as the resulting tree.

   Test [audit_rb Char.compare] succeeds and inorder traversal equals the sorted
   distinct letters. Explain why passing the audit does not prove which insertion
   history produced the tree.
   Example form: [let built = List.fold_left (fun tree item -> insert item tree) empty ['C'; 'O'; 'D'; 'E']]
   Build and run before continuing. *)

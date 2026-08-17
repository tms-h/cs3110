(** E32 — Ordered trees, efficient traversal, red-black auditing (40-50 min)

    OUTCOME

    Parameterize a BST set, write linear-time traversals, and audit red-black invariants
    independently of insertion code.

    STEP 1 — BUILD THE FUNCTORIZED BST SET

    - Implement [Make_bst_set] using only [Ord.compare].
    - Do not use polymorphic comparison.
    - Instantiate it with case-insensitive strings.
    - Insert differently cased versions of the same word and verify that the set does
      not retain duplicates.

    STEP 2 — DERIVE EFFICIENT TRAVERSALS

    - Before coding, write the meaning of the accumulator for preorder, inorder, and
      postorder.
    - Implement all three traversals with exactly one [::] per node and no [@].
    - Check the order on a three-node tree before using a larger example.
    - If a traversal is reversed, repair the accumulator derivation instead of adding a
      blind [List.rev].

    STEP 3 — CONSTRUCT TREES WITH DIFFERENT BLACK HEIGHTS

    - Draw the perfect BST containing 1 through 15.
    - Color it three ways to obtain valid black heights 2, 3, and 4.
    - Encode each coloring and pass it to [audit_rb].
    - If an audit fails, identify the first violated invariant before recoloring.

    STEP 4 — AUDIT A HAND INSERTION

    - Using the book algorithm, hand-insert the letters in [D A T A S T R U C T U R E].
    - Encode your final tree.
    - Check it with [audit_rb].
    - Independently check that its inorder traversal is sorted.

    STEP 5 — EXPLAIN THE LIMIT OF THE AUDIT

    - Give a short argument for why a tree that passes [audit_rb] need not have resulted
      from the insertion history in Step 4.

    FINISH

    Run: [opam exec -- dune exec exercises/e32_ordered_trees_and_traversal.exe]

    Reading fallback: https://cs3110.github.io/textbook/chapters/ds/rb.html

    Source coverage: functorized BST; efficient traversal; RB draw complete; RB draw
    insert. *)

module type ORDERED = sig
  type t

  val compare : t -> t -> int
end

module Make_bst_set (Ord : ORDERED) = struct
  type elt = Ord.t
  type t = Empty | Node of t * elt * t

  let empty = Empty
  let rec mem (_x : elt) (_t : t) : bool = failwith "TODO"
  let rec add (_x : elt) (_t : t) : t = failwith "TODO"
  let elements (_t : t) : elt list = failwith "TODO: linear inorder"
end

type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

let preorder (_t : 'a tree) : 'a list = failwith "TODO: no append"
let inorder (_t : 'a tree) : 'a list = failwith "TODO: no append"
let postorder (_t : 'a tree) : 'a list = failwith "TODO: no append"

type color = Red | Black
type 'a rb_tree = RLeaf | RNode of color * 'a rb_tree * 'a * 'a rb_tree

let audit_rb (_compare : 'a -> 'a -> int) (_t : 'a rb_tree) : (int, string) result =
  failwith "TODO: root black, no red-red, equal black height, BST order"

(* THREE COLORINGS: ...
   INSERTION RESULT: ... *)

let () =
  let t =
    Node
      ( Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf)),
        4,
        Node (Node (Leaf, 5, Leaf), 6, Node (Leaf, 7, Leaf)) )
  in
  assert (preorder t = [ 4; 2; 1; 3; 6; 5; 7 ]);
  assert (inorder t = [ 1; 2; 3; 4; 5; 6; 7 ]);
  assert (postorder t = [ 1; 3; 2; 5; 7; 6; 4 ]);
  let valid =
    RNode (Black, RNode (Red, RLeaf, 1, RLeaf), 2, RNode (Red, RLeaf, 3, RLeaf))
  in
  assert (audit_rb Int.compare valid = Ok 1);
  print_endline "E32 complete"

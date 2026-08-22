(** E32 — Ordered trees, generation, and red-black invariants (155-215 min)

    Build: [opam exec -- dune build exercises/e32_ordered_trees_and_traversal.exe] Run:
    [opam exec -- dune exec exercises/e32_ordered_trees_and_traversal.exe] Reading:
    https://cs3110.github.io/textbook/chapters/ds/rb.html *)

(* Task 1 — Define a comparison-parameterized BST core.
   Define module type [ORDERED] with type [t] and
   [compare : t -> t -> int]. State that [compare] must define a total order and
   that [compare a b = 0] is the set's notion of element equality. At top level, define
   [type 'a bst = BEmpty | BNode of 'a bst * 'a * 'a bst], [bst_empty],
   [bst_mem compare element tree], and persistent
   [bst_add compare element tree]. Equal elements are not duplicated; use only
   the supplied [compare]. Do not begin [Make_bst_set] yet, because Task 2 adds
   one more operation and an OCaml functor body cannot be reopened.

   Test the generic helpers directly with [Int.compare], including empty
   membership, persistent insertion, duplicate insertion, and both tree branches.
   Example form: [let rec contains compare item = function BEmpty -> false | BNode (...) -> ...]
   Build and run before continuing. *)

(* Task 2 — Add enumeration, then assemble the functor once.
   As an extension, define top-level [bst_elements tree] as ascending inorder
   traversal in O(n) time, with one [::] per node and no [@].

   Define module type [BST_SET] with abstract types [elt] and [t],
   [empty : t], [mem : elt -> t -> bool], [add : elt -> t -> t], and
   [elements : t -> elt list]. Now define
   [Make_bst_set (Ord : ORDERED) : BST_SET with type elt = Ord.t] exactly once.
   Inside its sealed body, use [type elt = Ord.t] and [type t = elt bst]. Each
   operation must delegate to the completed top-level helper; do not duplicate
   its algorithm in the functor. The result signature must keep [t] abstract so
   clients cannot construct [BEmpty] or [BNode]. Instantiate integer and
   case-insensitive string sets. Leave each argument module unsealed or ascribe
   it as [ORDERED with type t = int] or
   [ORDERED with type t = string], respectively; an opaque [: ORDERED]
   ascription would hide the literal key type from the client tests.

   Test scrambled integer insertion yields [1; 2; 3; 4] and the case-insensitive
   set treats ["OCaml"] and ["ocaml"] as one logical element and returns one
   representative.
   Accumulator contract: [[walk tree suffix]] must return the traversal of [tree]
   followed by [suffix]. Use that contract to decide the recursive-call order.
   Build and run before continuing. *)

(* Task 3 — Define efficient tree traversals.
   Define ['a tree = Leaf | Node of 'a tree * 'a * 'a tree]. Define [preorder],
   [inorder], and [postorder] with accumulators, one [::] per node, and no [@].

   On the balanced tree containing 1 through 7 with root 4, test exact results
   [4;2;1;3;6;5;7], [1;2;3;4;5;6;7], and [1;3;2;5;7;6;4].
   Example test form: [assert (inorder sample = expected_inorder)]
   Build and run before continuing. *)

(* Extension Task 4 — Audit red-black trees.
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
   First draw the perfect BST containing 1 through 15 three times, with every
   internal node's color shown. For each drawing, manually check root blackness,
   every red parent/child edge, and the black-node count on every root-to-leaf
   path. Record those arguments before encoding the drawings as OCaml values;
   passing [audit_rb] is a cross-check, not a replacement for the source drawing
   exercise.

   Define [rb_height_2], [rb_height_3], and [rb_height_4] as colorings of the
   perfect BST containing 1 through 15. Derive three different valid colorings
   yourself; do not begin from a supplied level-by-level coloring. Each tree must
   have the black height named by its binding.

   Test inorder values are 1 through 15 and [audit_rb Int.compare] returns the
   named black height for each tree.
   Example form: [let sample = RNode (Black, RNode (Red, RLeaf, 1, RLeaf), 2, RLeaf)]
   Build and run before continuing. *)

(* Task 6 — Audit a hand insertion.
   Hand-insert letters [D A T A S T R U C T U R E] with the textbook red-black
   insertion algorithm. Before coding the final tree, draw and preserve the
   colored tree after every input letter; when a repeated letter causes no
   change, explicitly record that unchanged state. Then define
   [inserted_letters_tree] as the resulting tree.

   Test [audit_rb Char.compare] succeeds and inorder traversal equals the sorted
   distinct letters. Explain why passing the audit does not prove which insertion
   history produced the tree.
   Example audit form: [match audit_rb Char.compare inserted_letters_tree with
   | Ok _ -> () | Error message -> failwith message]
   Build and run before continuing. *)

(* Task 7 — Supplemental practice: invert preorder and inorder traversals.
   Inspired by 99 Problems P68. Define
   [rebuild_pre_in : equal:('a -> 'a -> bool) -> 'a list -> 'a list ->
     ('a tree, string) result]. Use [equal] for every label comparison. For a
   successful input, both traversals contain the same distinct labels under that
   equality and the result's [preorder] and [inorder] exactly reproduce the inputs. Return
   [Error "duplicate label"] for a duplicate in either traversal,
   [Error "length mismatch"] for different lengths, and
   [Error "inconsistent traversals"] when no tree can have both orders.
   Validate lengths first, then duplicates, then consistency so mixed-invalid
   inputs have a deterministic error.

   Test the empty tree and reconstruct the Task 3 tree containing 1 through 7
   with [Int.equal].
   Cover all three errors, including equal-length traversals with different
   labels. Explain why distinct labels are necessary for a unique inverse and
   derive the worst-case cost of repeatedly splitting the inorder list.
   Example form: [match preorder with root :: rest -> split_at_root root inorder]
   Build and run before continuing. *)

(* Task 8 — Supplemental practice: enumerate completely balanced shapes.
   Inspired by 99 Problems P55. Define
   [completely_balanced : int -> (unit tree list, string) result]. Return
   [Error "negative node count"] for a negative input. For [n >= 0], enumerate
   every binary-tree shape with exactly [n] nodes in which the two child node
   counts at every node differ by at most one. Return each shape exactly once;
   [n = 0] has the one solution [Leaf].

   Define [node_count] and [is_completely_balanced] as independent checks. Test
   counts 0 and 1, and assert count 4 produces exactly four distinct valid
   shapes, each with four nodes. Do not test a large count: the output grows
   exponentially. Explain why an even number of remaining child nodes needs one
   size split while an odd number needs both left/right orientations.

   After every required construction, explanation, and assertion in E32 is
   present and passing, print the exact line ["E32 passed"] once, and not earlier.
   Example form: [let smaller = (n - 1) / 2 in let larger = n - 1 - smaller]
   Build and run before continuing. *)

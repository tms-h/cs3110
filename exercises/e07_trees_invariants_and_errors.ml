(** E07 — Trees, invariants, and errors (70-95 min)

    Build: [opam exec -- dune build exercises/e07_trees_invariants_and_errors.exe] Run:
    [opam exec -- dune exec exercises/e07_trees_invariants_and_errors.exe] *)

(* Task 1 — Define binary-tree depth.
   Define polymorphic type ['a tree] with [Leaf] and
   [Node of 'a tree * 'a * 'a tree]. Define [depth tree] with [depth Leaf = 0]
   and [depth (Node (l, _, r)) = 1 + max (depth l) (depth r)].

   Example form: [type 'a shrub = Tip | Fork of 'a shrub * 'a]
   Test a leaf, a one-node tree, and an unbalanced tree of depth 3.
   Build and run before continuing. *)

(* Task 2 — Compare tree shapes.
   Define [same_shape a b] to return true exactly when leaves and nodes occur in
   the same positions. The element types may differ and values are ignored.

   Test equal shapes with different values and types, and two trees that first
   differ below the root.
   Example form: [let rec same_outline a b = match a, b with Tip, Tip -> true | _ -> false]
   Build and run before continuing. *)

(* Task 3 — Report maximum through an exception and test it with OUnit.
   Define recursive [list_max_exn xs]. Return the greatest integer for a nonempty
   list and raise [Failure "empty"] for [].

   Use [OUnit2] to define and run a named [list_max_exn_tests] suite. The two
   textbook-required cases are: [assert_raises (Failure "empty")] for [] and an
   [assert_equal] check for the maximum of a nonempty list. Also cover a
   singleton and an all-negative list. Ordinary [assert] statements do not
   satisfy this task; the point is to practise the OUnit framework.
   Example form: [let first_exn = function [] -> failwith "missing" | x :: _ -> x]
   Build and run before continuing. *)

(* Task 4 — Consume the exception API.
   Define [list_max_string xs] by calling [list_max_exn]. Return the decimal
   string for a nonempty list and ["empty"] only when [Failure "empty"] is
   raised. Do not catch other exceptions.

   Test [] and [3; 9; 4].
   Example form: [try string_of_int (first_exn values) with Failure "missing" -> "none"]
   Build and run before continuing. *)

(* Task 5 — Check the global BST invariant.
   Treat each node value as a [(key, value)] pair. Define [is_bst tree] to return
   true exactly when every key in a left subtree is strictly smaller than the
   node key and every key in a right subtree is strictly greater. Use one
   traversal and polymorphic key comparison; duplicates are invalid.

   Test an empty tree, a valid three-node tree, a duplicate key, and a tree whose
   left subtree contains a key greater than the root.
   Example form:
   [let below upper key =
      match upper with None -> true | Some high -> key < high]
   Build and run before continuing. *)

(* Task 6 — Extension: locate a BST violation.
   Define [first_bst_violation tree] using propagated lower and upper bounds.
   Return [None] for a valid tree; otherwise return [Some key] for the first key
   encountered in a root-left-right traversal that violates a bound.

   Test the valid tree and deep violation from Task 5. After every required
   assertion and written explanation in E07 is present, print exactly
   [E07 passed].
   Example form: [let visit ~lower ~upper tree = inspect lower upper tree]
   Build and run before continuing. *)

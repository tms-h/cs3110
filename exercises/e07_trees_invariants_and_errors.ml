(** E07 — Trees, invariants, and error channels (40-50 min)

    OUTCOME

    - Recurse over tree shape and check a global invariant in one traversal.
    - Distinguish an exception-based API from one that returns ordinary data.

    STEP 1 — RECURSE OVER SHAPE

    - Implement [depth]. Check [Leaf], a chain, and a balanced tree.
    - Implement [same_shape]. Notice that the two element types need not agree.

    STEP 2 — EXERCISE THE ERROR CHANNEL

    - Implement [list_max_exn].
    - Test a normal result and the exact empty-list exception separately.
    - Implement [list_max_string] as a client of [list_max_exn].
    - Catch only the exception promised by that API.

    STEP 3 — PREDICT THE BST BUG

    - Draw a tree whose parent-child comparisons pass but whose global BST invariant
      fails.
    - Explain why a local check cannot be repaired with one more child comparison.

    STEP 4 — CHECK THE GLOBAL INVARIANT ONCE

    - Make a helper return [Empty], [Bounds (minimum, maximum)], or [Invalid].
    - Implement [is_bst] in O(n), visiting each node at most once.
    - Explain why a production API would receive a comparator explicitly.

    STEP 5 — TRANSFER AND FINISH

    - Implement [first_bst_violation] using propagated lower and upper bounds.
    - Run [opam exec -- dune exec exercises/e07_trees_invariants_and_errors.exe].

    Source coverage: depth; shape; list max exn; list max exn string; list max exn
    ounit; is_bst. *)

type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

let rec depth (_t : 'a tree) : int = failwith "TODO"
let rec same_shape (_a : 'a tree) (_b : 'b tree) : bool = failwith "TODO"
let rec list_max_exn (_xs : int list) : int = failwith "TODO"
let list_max_string (_xs : int list) : string = failwith "TODO: client of list_max_exn"

type 'k bounds = Empty | Bounds of 'k * 'k | Invalid

let is_bst (_t : ('k * 'v) tree) : bool = failwith "TODO: one traversal"

let first_bst_violation (_t : ('k * 'v) tree) : 'k option =
  failwith "TODO: transfer with lower/upper bounds"

let () =
  let t = Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf)) in
  assert (
    depth t = 2
    && same_shape t (Node (Node (Leaf, "x", Leaf), "y", Node (Leaf, "z", Leaf))));
  assert (list_max_exn [ -7; -3; -10 ] = -3);
  assert (
    try
      ignore (list_max_exn []);
      false
    with
    | Failure "empty" -> true
    | _ -> false);
  assert (list_max_string [] = "empty" && list_max_string [ 3; 9; 4 ] = "9");
  let good =
    Node (Node (Leaf, (1, "a"), Leaf), (2, "b"), Node (Leaf, (3, "c"), Leaf))
  in
  let bad =
    Node (Node (Leaf, (1, "a"), Node (Leaf, (4, "oops"), Leaf)), (3, "root"), Leaf)
  in
  assert (is_bst good && not (is_bst bad));
  assert (first_bst_violation good = None && first_bst_violation bad <> None);
  print_endline "E07 complete"

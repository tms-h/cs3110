(** E13 — Persistent BST maps (90-120 min)

    Build: [opam exec -- dune build exercises/e13_maps_and_bst_abstraction.exe] Run:
    [opam exec -- dune exec exercises/e13_maps_and_bst_abstraction.exe] Reading:
    https://ocaml.org/manual/5.3/api/Map.html Inspect:
    [opam exec -- ocamlc -i exercises/e13_maps_and_bst_abstraction.ml] *)

(* Task 1 — Inspect [Map.Make] and its ordered input.
   Define [Char_map = Map.Make (Char)]. Run the interface-inspection command.
   In comments, copy the inferred types of [Char_map.empty], [Char_map.add], and
   [Char_map.remove], then explain each type in plain English.

   Also inspect [Map.OrderedType] and [Char]. Explain why [Char] is a valid input
   to [Map.Make]: identify its key type and comparison function.
   Example form: [module Word_map = Map.Make (String)]
   Build and run before continuing. *)

(* Task 2 — Use a character map and investigate [bindings].
   Define [radio] by adding A→Alpha, E→Echo, S→Sierra, and V→Victor.
   Test finding E, then remove A and use [Char_map.mem] to show that A is absent
   from the new map but still present in [radio]. Also test that
   [List.map fst (Char_map.bindings radio)] equals ['A'; 'E'; 'S'; 'V'].

   Then build these three maps and assert that [Char_map.bindings] returns the
   same association list for all of them:

   1. add x→0, then y→1;
   2. add y→1, then x→0;
   3. add x→2 and y→1, remove x, then add x→0.

   In a comment, explain why insertion history does not determine the order of
   [bindings].
   Example form: [Char_map.(empty |> add 'x' 0 |> add 'y' 1 |> bindings)]
   Build and run before continuing. *)

(* Task 3 — Define ordered-map interfaces.
   Define module type [ORDERED] with type [t] and [compare : t -> t -> int].
   State that [compare] must define a total order and that a zero result is the
   map's notion of key equality.
   Define module type [MAP] with types [key] and ['v t], plus [empty], [add],
   [find_opt], [remove], and [bindings] with these types:

   - [empty : 'v t]
   - [add : key -> 'v -> 'v t -> 'v t]
   - [find_opt : key -> 'v t -> 'v option]
   - [remove : key -> 'v t -> 'v t]
   - [bindings : 'v t -> (key * 'v) list]

   Run interface inspection and verify that values remain polymorphic.
   Example form: [module type LOOKUP = sig type key type 'a t val find : key -> 'a t -> 'a option end]
   Build and run before continuing. *)

(* Task 4 — Define a generic BST representation and insertion.
   At top level, define [('key, 'value) bst] with [Empty] and
   [Node of left * key * value * right]. All left keys must compare below the
   node key, all right keys above it, and duplicate keys replace their value.

   Define [bst_add compare key value tree]. Test with [Int.compare] by inserting
   keys 2, 1, and 3, then replacing the value at key 2. These top-level helpers
   keep every task compilable; the functor is assembled only after all required
   operations exist.
   Example form: [let ordering = Int.compare candidate node_key]
   Build and run before continuing. *)

(* Task 5 — Look up keys.
   Define [bst_find_opt compare key tree] by following exactly one
   comparator-directed search path.
   Return [Some value] for a matching key and [None] when absent.

   Test keys 1, 2, 3, and absent key 4 in the tree from Task 4. Do not use
   polymorphic equality on keys; the supplied comparison function determines
   equality and direction.
   Example form: [let direction = compare target node_key]
   Build and run before continuing. *)

(* Task 6 — Enumerate bindings.
   Define [bst_bindings tree] to return ascending key-value pairs in O(n) time
   without repeated [@]. Test that the Task 4 tree yields
   [(1, "a"); (2, "B"); (3, "c")].
   Example form:
   [let rec count = function
      | Empty -> 0
      | Node (left, _, _, right) -> 1 + count left + count right]
   Build and run before continuing. *)

(* Task 7 — Remove keys persistently.
   Define [bst_remove compare key tree]. Removing an absent key leaves equivalent
   bindings.
   Handle leaf, one-child, and two-child nodes by factoring predecessor or
   successor extraction. Do not mutate the old tree.

   Test each node case, removal of root 2, absent key 9, and that the original
   tree still has all three bindings.
   Example form: [let replace_left tree new_left = match tree with Empty -> Empty | Node (_, k, v, r) -> Node (new_left, k, v, r)]
   Build and run before continuing. *)

(* Task 8 — Assemble and seal [Make_bst_map].
   Now define the complete functor [Make_bst_map (K : ORDERED)] with result type
   [MAP with type key = K.t]. Inside it, make ['value t] an alias for
   [(K.t, 'value) bst] and reuse [bst_add], [bst_find_opt], [bst_bindings], and
   [bst_remove] with [K.compare]. Define [empty] as [Empty].

   Instantiate [Int_map = Make_bst_map (Int)]; the standard [Int] module keeps
   the equation [Int.t = int] visible to literal-key client tests. Repeat the
   insertion, replacement, lookup, bindings,
   and removal assertions through the sealed map interface. The result ascription
   appears here, after every value required by [MAP] exists.
   Example form: [module Make_set (K : ORDERED) = struct type elt = K.t end]
   Build and run before continuing. *)

(* Task 9 — Extension: analyze unbalanced height.
   Build one map by inserting integers 1 through 1,000 in ascending order. Test
   that keys 1 and 1,000 are findable. State its height and worst-case operation
   cost, then compare them with the balanced implementation promised by
   [Stdlib.Map].
   After every required assertion and written explanation in E13 is present,
   print exactly [E13 passed].
   Example form: [let keys = List.init 20 (fun i -> i + 1)]
   Build and run before continuing. *)

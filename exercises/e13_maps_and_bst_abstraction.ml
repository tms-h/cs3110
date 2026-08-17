(** E13 — Persistent BST maps (90-120 min)

    Build: [opam exec -- dune build exercises/e13_maps_and_bst_abstraction.exe] Run:
    [opam exec -- dune exec exercises/e13_maps_and_bst_abstraction.exe] Reading:
    https://ocaml.org/manual/5.4/api/Map.html *)

(* Task 1 — Use [Map.Make].
   Define [Char_map = Map.Make (Char)]. Define [radio] by adding
   A→Alpha, E→Echo, S→Sierra, and V→Victor.

   Test finding E, removing A without changing [radio], and that
   [List.map fst (Char_map.bindings radio)] equals ['A'; 'E'; 'S'; 'V'].
   Build and run before continuing. *)

(* Task 2 — Define ordered-map interfaces.
   Define module type [ORDERED] with type [t] and [compare : t -> t -> int].
   Define module type [MAP] with types [key] and ['v t], plus [empty], [add],
   [find_opt], [remove], and [bindings] with these types:

   - [empty : 'v t]
   - [add : key -> 'v -> 'v t -> 'v t]
   - [find_opt : key -> 'v t -> 'v option]
   - [remove : key -> 'v t -> 'v t]
   - [bindings : 'v t -> (key * 'v) list]

   Run interface inspection and verify that values remain polymorphic.
   Build and run before continuing. *)

(* Task 3 — Define [Make_bst_map] and insertion.
   Define functor [Make_bst_map (K : ORDERED)] returning [MAP] with
   [type key = K.t]. Use [Empty] or
   [Node of left * key * value * right]. All left keys must compare below the
   node key, all right keys above it, and duplicate keys replace their value.

   Define [empty] and [add]. Instantiate [Int_map]. Test insertion of keys 2, 1,
   and 3, then replacement of key 2.
   Build and run before continuing. *)

(* Task 4 — Look up keys.
   Define [find_opt key map] by following one comparator-directed search path.
   Return [Some value] for a matching key and [None] when absent.

   Test keys 1, 2, 3, and absent key 4 in the map from Task 3.
   Build and run before continuing. *)

(* Task 5 — Enumerate bindings.
   Define [bindings map] to return ascending key-value pairs in O(n) time without
   repeated [@]. Test the Task 3 map equals
   [(1, "a"); (2, "B"); (3, "c")].
   Build and run before continuing. *)

(* Task 6 — Remove keys persistently.
   Define [remove key map]. Removing an absent key leaves equivalent bindings.
   Handle leaf, one-child, and two-child nodes by factoring predecessor or
   successor extraction. Do not mutate the old map.

   Test each node case, removal of root 2, absent key 9, and that the original
   map still has all three bindings.
   Build and run before continuing. *)

(* Task 7 — Analyze unbalanced height.
   Build one map by inserting integers 1 through 1,000 in ascending order. Test
   that keys 1 and 1,000 are findable. State its height and worst-case operation
   cost, then compare them with the balanced implementation promised by
   [Stdlib.Map].
   Build and run before continuing. *)

(** E13 — Map abstraction over a BST (40-50 min)

    OUTCOME

    - Parameterize ordering instead of relying on polymorphic comparison.
    - Implement and analyze a persistent BST map.

    STEP 1 — ORIENT WITH THE STANDARD LIBRARY

    - Open https://ocaml.org/manual/5.4/api/Map.html.
    - Explain why [Char] satisfies [Map.OrderedType].
    - Predict [Char_map.bindings radio] before running it.
    - Try different insertion histories and check that binding order is unchanged.

    STEP 2 — WRITE THE REPRESENTATION INVARIANT

    - Every left key compares below its node key.
    - Every right key compares above its node key.
    - No key occurs twice; [add] replaces the existing value.

    STEP 3 — IMPLEMENT THE SEARCH PATH

    - Implement [add] and [find_opt] using only [K.compare].
    - Test replacement as well as insertion and absence.

    STEP 4 — TRAVERSE AND DELETE

    - Implement [bindings] in O(n) without repeated [@].
    - Factor predecessor or successor extraction out of [remove].
    - Test leaf, one-child, two-child, and root deletion.

    STEP 5 — COMPARE AND FINISH

    - Compare your worst case with Stdlib.Map's documented balanced tree.
    - Run [opam exec -- dune exec exercises/e13_maps_and_bst_abstraction.exe].

    Source coverage: binary search tree map; make char map; char ordered; use char map;
    bindings. *)

module Char_map = Map.Make (Char)

let radio =
  Char_map.empty |> Char_map.add 'A' "Alpha" |> Char_map.add 'E' "Echo"
  |> Char_map.add 'S' "Sierra" |> Char_map.add 'V' "Victor"

module type ORDERED = sig
  type t

  val compare : t -> t -> int
end

module type MAP = sig
  type key
  type 'v t

  val empty : 'v t
  val add : key -> 'v -> 'v t -> 'v t
  val find_opt : key -> 'v t -> 'v option
  val remove : key -> 'v t -> 'v t
  val bindings : 'v t -> (key * 'v) list
end

module Make_bst_map (K : ORDERED) : MAP with type key = K.t = struct
  type key = K.t
  type 'v tree = Empty | Node of 'v tree * key * 'v * 'v tree
  type 'v t = 'v tree

  let empty = Empty
  let rec add (_key : key) (_value : 'v) (_map : 'v t) : 'v t = failwith "TODO"
  let rec find_opt (_key : key) (_map : 'v t) : 'v option = failwith "TODO"
  let remove (_key : key) (_map : 'v t) : 'v t = failwith "TODO"
  let bindings (_map : 'v t) : (key * 'v) list = failwith "TODO: O(n)"
end

module Int_map = Make_bst_map (Int)

let () =
  assert (Char_map.find 'E' radio = "Echo");
  assert (not (Char_map.mem 'A' (Char_map.remove 'A' radio)));
  assert (List.map fst (Char_map.bindings radio) = [ 'A'; 'E'; 'S'; 'V' ]);
  let m =
    Int_map.empty |> Int_map.add 2 "b" |> Int_map.add 1 "a" |> Int_map.add 3 "c"
    |> Int_map.add 2 "B"
  in
  assert (Int_map.find_opt 2 m = Some "B");
  assert (Int_map.bindings m = [ (1, "a"); (2, "B"); (3, "c") ]);
  assert (Int_map.bindings (Int_map.remove 2 m) = [ (1, "a"); (3, "c") ]);
  print_endline "E13 complete"

(** E31 — Linear probing under deletion and resizing (45-50 min)

    OUTCOME

    Implement an imperative hash table whose correctness survives collisions, deletion,
    replacement, and resizing.

    RULES YOUR IMPLEMENTATION MUST PRESERVE

    - Probe forward from [hash key mod capacity], wrapping at most once.
    - [Vacant] terminates an unsuccessful lookup; [Tombstone] does not.
    - Replacement updates an existing binding in place.
    - A new insertion remembers the first tombstone but keeps probing to rule out an
      existing key.
    - Grow when [(live + tombstones) / capacity > 1/2].
    - Shrink when [live / capacity < 1/8], but never below the initial capacity.
    - Rehash only live bindings; rehashing clears all tombstones.

    STEP 1 — STATE THE REPRESENTATION INVARIANT

    - Fill in [REPRESENTATION INVARIANT].
    - Include bounds connecting [live] and [tombstones] to the array.
    - Include uniqueness of keys and the required shape of each key's probe path.

    STEP 2 — TRACE THE FAILURE-PRONE CASE BY HAND

    - With the constant hash below, insert keys 1 and 2, remove 1, then find 2.
    - Predict every slot examined by the final lookup.
    - Explain why stopping at a tombstone would be incorrect.

    STEP 3 — IMPLEMENT ONE BOUNDED PROBE

    - Implement [create].
    - Implement [locate] as the single probe routine shared by lookup, replacement, and
      removal.
    - Ensure it cannot loop forever when there is no vacant slot.
    - Run the minimal trace from Step 2 before implementing resizing.

    STEP 4 — ADD MUTATION AND RESIZING

    - Implement [find_opt], then [replace], then [remove].
    - Implement [rehash] and both resize boundaries.
    - After each operation, check the invariant and the counter updates on paper.

    STEP 5 — TEST AGAINST A MODEL

    - Generate 10,000 deterministic random replace/remove/find operations.
    - Apply each operation to this table and to [Stdlib.Hashtbl].
    - Use [Colliding_int] so every key begins on the same probe path.
    - On the first mismatch, print the shortest useful operation prefix and debug that
      trace before rerunning the full test.

    FINISH

    Run: [opam exec -- dune exec exercises/e31_linear_probing.exe]

    Source coverage: linear probing. *)

module type HASHED = sig
  type t

  val equal : t -> t -> bool
  val hash : t -> int
end

module Make (K : HASHED) = struct
  type key = K.t
  type 'v slot = Vacant | Tombstone | Binding of key * 'v

  type 'v t = {
    mutable slots : 'v slot array;
    mutable live : int;
    mutable tombstones : int;
    initial_capacity : int;
  }

  let create (_capacity : int) : 'v t = failwith "TODO"
  let length t = t.live

  let locate (_table : 'v t) (_key : key) : [ `Found of int | `Insert_at of int | `Full ]
      =
    failwith "TODO: bounded, tombstone-aware probe"

  let rehash (_table : 'v t) (_capacity : int) : unit = failwith "TODO"
  let find_opt (_table : 'v t) (_key : key) : 'v option = failwith "TODO"
  let replace (_table : 'v t) (_key : key) (_value : 'v) : unit = failwith "TODO"
  let remove (_table : 'v t) (_key : key) : unit = failwith "TODO"
  let stats t = (Array.length t.slots, t.live, t.tombstones)
end

module Colliding_int = struct
  type t = int

  let equal = Int.equal
  let hash _ = 0
end

module T = Make (Colliding_int)

(* REPRESENTATION INVARIANT: ... *)

let () =
  let t = T.create 4 in
  T.replace t 1 "one";
  T.replace t 2 "two";
  T.remove t 1;
  assert (T.find_opt t 2 = Some "two");
  assert (T.find_opt t 1 = None);
  T.replace t 2 "TWO";
  assert (T.length t = 1 && T.find_opt t 2 = Some "TWO");
  for i = 3 to 100 do
    T.replace t i (string_of_int i)
  done;
  for i = 3 to 90 do
    T.remove t i
  done;
  let capacity, live, tombstones = T.stats t in
  assert (capacity >= 4 && live = 11 && tombstones < capacity);
  print_endline "E31 complete"

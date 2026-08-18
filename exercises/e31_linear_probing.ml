(** E31 — Linear probing with deletion (105-145 min)

    Build: [opam exec -- dune build exercises/e31_linear_probing.exe] Run:
    [opam exec -- dune exec exercises/e31_linear_probing.exe] *)

(* Task 1 — Define the representation.
   Define module type [HASHED] with type [t], [equal], and [hash]. Begin functor
   [Make (K : HASHED)]. Inside it define [key = K.t], slots [Vacant], [Tombstone],
   and [Binding of key * value], plus table fields [slots], [live], [tombstones],
   and [initial_capacity].

   Define [create capacity], rejecting [capacity <= 0] with
   [Invalid_argument "capacity"], and [length table = table.live]. Test capacity
   4, zero counters, length zero, and invalid capacity.
   Example form: [type 'a slot = Empty | Deleted | Entry of string * 'a]
   Build and run before continuing. *)

(* Task 2 — Define one bounded probe.
   Define [locate table key] returning [`Found index], [`Insert_at index], or
   [`Full]. Probe from the nonnegative remainder of [K.hash key] by capacity,
   wrapping at most once. [Vacant] ends the search. [Tombstone] does not; remember
   the first tombstone while continuing to rule out an existing key.

   Define a constant-hash integer module and instantiate [T]. Manually place a
   binding after a tombstone and test [locate] finds it. Fill every slot and test
   termination with [`Full] or a remembered tombstone.
   Example form: [let index = (start + offset) mod Array.length slots]
   Build and run before continuing. *)

(* Task 3 — Implement lookup and replacement.
   Define [find_opt table key] from [locate]. Define [replace table key value] to
   update an existing binding in place or insert a new one, adjusting [live] and
   [tombstones] exactly once. Ignore resizing for this task.

   Test two colliding keys, absent lookup, replacement without length growth,
   and insertion into a tombstone.
   Example form: [match probe storage label with `Present i -> storage.slots.(i) <- Entry (label, payload) | `Available i -> place_at i]
   Build and run before continuing. *)

(* Task 4 — Implement removal.
   Define [remove table key]. Replace a found binding by [Tombstone], decrement
   [live], and increment [tombstones]. Removing an absent key changes nothing.

   Insert keys 1 and 2 with the constant hash, remove 1, and test key 2 remains
   findable while key 1 is absent. Test all three counters with [stats table].
   Example form: [match probe storage label with `Present i -> slots.(i) <- Deleted | _ -> ()]
   Build and run before continuing. *)

(* Task 5 — Rehash and resize.
   Define [rehash table capacity] to allocate fresh vacant slots and reinsert only
   live bindings, clearing tombstones. Grow after insertion when
   [(live + tombstones) / capacity > 1/2]. Shrink after removal when
   [live / capacity < 1/8], never below [initial_capacity].

   Insert keys 1 through 100, remove 1 through 90, and test remaining bindings,
   capacity at least the initial capacity, live count 10, and tombstones fewer
   than capacity.
   Example form: [Array.iter (function Entry (label, payload) -> visit label payload | Empty | Deleted -> ()) slots]
   Build and run before continuing. *)

(* Task 6 — Compare with a model.
   Define operation variant [Replace of int * int], [Remove of int], and
   [Find of int]. Define [check_operations operations] to apply each operation to
   [T] and [Stdlib.Hashtbl], returning the first mismatching prefix or [None].

   Generate 10,000 deterministic operations with seed 3110 and keys 0 through
   99. Assert the checker returns [None].
   Example form: [type action = Put of string * int | Drop of string | Get of string]
   Build and run before continuing. *)

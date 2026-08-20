(** E31 — Linear probing with deletion (115-160 min)

    Build: [opam exec -- dune build exercises/e31_linear_probing.exe] Run:
    [opam exec -- dune exec exercises/e31_linear_probing.exe] *)

(* Task 1 — Define a representation independent of any functor.
   Define module type [HASHED] with [type t],
   [equal : t -> t -> bool], and [hash : t -> int]. State its essential law:
   [equal a b] implies [hash a = hash b]. Also state that [equal] must be an
   equivalence relation; probing is not correct for a module that violates
   these requirements. At top level, define
   [type ('key, 'value) slot = Vacant | Tombstone |
   Binding of 'key * 'value] and [type ('key, 'value) table]. The table's [slots],
   [live], and [tombstones] fields must be mutable; [initial_capacity] must be
   immutable. Do not begin [Make] yet: later tasks need to define more operations,
   and an OCaml functor body cannot be reopened.

   Define [create capacity], rejecting [capacity <= 0] with
   [Invalid_argument "capacity"], and [length table = table.live]. Test capacity
   4, zero counters, length zero, and invalid capacity.
   Example form: [type 'a slot = Empty | Deleted | Entry of string * 'a]
   Build and run before continuing. *)

(* Task 2 — Define one bounded probe.
   Define top-level [locate ~equal ~hash table key] returning [`Found index],
   [`Insert_at index], or [`Full]. Probe from the nonnegative remainder of
   [hash key] by capacity, wrapping at most once. Use [equal] for keys. [Vacant]
   ends the search. [Tombstone] does not; remember the first tombstone while
   continuing to rule out an existing key.

   Compute the start safely as [let r = hash key mod capacity in
   if r < 0 then r + capacity else r]; do not use [abs], which fails on [min_int].

   Define [Constant_int_key : HASHED with type t = int] but do not instantiate
   the final functor yet. Preserve that type equation so later clients can pass
   integer keys through the sealed table API.
   Manually place a binding after a tombstone and test [locate] with
   [Constant_int_key.equal] and [Constant_int_key.hash]. Fill every slot and test
   termination with [`Full] or a remembered tombstone.
   Example form: [let index = (start + offset) mod Array.length slots]
   Build and run before continuing. *)

(* Task 3 — Implement lookup and replacement.
   Define top-level [find_opt ~equal ~hash table key] from [locate]. Define
   [replace_raw ~equal ~hash table key value] to update an existing binding in
   place or insert a new one, adjusting [live] and [tombstones] exactly once.
   [replace_raw] deliberately performs no resizing; Task 5 will wrap it.

   Test two colliding keys, absent lookup, replacement without length growth,
   and insertion into a tombstone.
   Example form: [match probe storage label with `Present i -> storage.slots.(i) <- Entry (label, payload) | `Available i -> place_at i]
   Build and run before continuing. *)

(* Task 4 — Implement removal.
   Define top-level [remove_raw ~equal ~hash table key]. Replace a found binding
   by [Tombstone], decrement [live], and increment [tombstones]. Removing an
   absent key changes nothing. [remove_raw] deliberately performs no resizing.

   Define [table_stats] as a record type with exactly [capacity], [live], and
   [tombstones], then define [stats] to return it. Insert keys 1 and 2 with the
   constant hash, remove 1, and test key
   2 remains findable while key 1 is absent. Test all three [stats] fields.
   Example form: [match probe storage label with `Present i -> slots.(i) <- Deleted | _ -> ()]
   Build and run before continuing. *)

(* Task 5 — Rehash and resize.
   Define top-level [rehash ~equal ~hash table capacity] to allocate fresh vacant
   slots, reinsert only live bindings with [replace_raw], clear tombstones, and
   mutate the existing table to use those slots while preserving
   [initial_capacity]. Define [replace_resizing] to call [replace_raw], then grow
   to [2 * capacity] when [2 * (live + tombstones) > capacity]. In a corresponding
   [remove_resizing] wrapper around [remove_raw], shrink to
   [max initial_capacity (capacity / 2)] when [8 * live < capacity] and the table
   is above its initial capacity. Perform at most one resize per public operation.
   These cross-multiplied integer tests implement the textbook's strict 1/2 and
   1/8 load thresholds; do not write [1/2] or [1/8] as OCaml integer expressions.

   Define module type [TABLE] with [type key], abstract [type 'a t], and exactly:
   [create : int -> 'a t], [length : 'a t -> int],
   [find_opt : 'a t -> key -> 'a option],
   [replace : 'a t -> key -> 'a -> unit], [remove : 'a t -> key -> unit], and
   [stats : 'a t -> table_stats].

   Only now define [Make (K : HASHED) : TABLE with type key = K.t] once. Inside
   the sealed body use [type key = K.t] and
   [type 'a t = (key, 'a) table], then implement the public operations solely as
   wrappers around the completed top-level helpers with [K.equal] and [K.hash].
   The result signature must hide slots and mutable counters from clients.
   Instantiate [T = Make (Constant_int_key)]. Do not duplicate algorithms inside
   the functor.

   Insert keys 1 through 100, remove 1 through 90, and test remaining bindings,
   capacity at least the initial capacity, live count 10, and tombstones fewer
   than capacity. Add focused boundary tests showing that exactly 1/2 does not
   grow, just above 1/2 does, and just below 1/8 shrinks when permitted.
   Example wrapper form: [let find_opt table key = find_opt ~equal:K.equal ~hash:K.hash table key]
   Build and run before continuing. *)

(* Extension Task 6 — Compare with a model.
   Define operation variant [Replace of int * int], [Remove of int], and
   [Find of int]. Define a [mismatch] record containing the zero-based [step], the
   [operation], [expected_value], [actual_value], [expected_length], and
   [actual_length]. Define [check_operations operations] to apply each operation
   to [T] and [Stdlib.Hashtbl], returning the first [mismatch] or [None]. Compare
   the affected lookup and both lengths after every operation.

   Generate 10,000 deterministic operations with [Random.State.make [|3110|]].
   For each operation draw its tag with [Random.State.int state 3], then its key
   with [Random.State.int state 100]; draw a value with
   [Random.State.int state 10_000] only for [Replace]. Assert the checker returns
   [None].
   Example form: [type action = Put of string * int | Drop of string | Get of string]
   After every required invariant explanation and assertion in E31 is present and
   passing, print the exact line ["E31 passed"] once, and not earlier.
   Build and run before continuing. *)

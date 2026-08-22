open! Core

(* E10 — Persistent data structures and functors

   The goal is to implement enough structure to understand invariants and cost
   models, then use Jane Street's production collections instead of repeatedly
   rebuilding them. *)

(* Task 1 — Derive an amortized queue.
   Implement a persistent two-list queue with [enqueue], [peek], and [dequeue].
   State its representation invariant and explain why a sequence of operations
   is amortized O(1), including the worst-case reversal. *)

(* Task 2 — Build and inspect a search tree.
   Implement insertion, lookup, and in-order traversal for an immutable BST.
   Write an invariant checker with explicit lower and upper bounds. Demonstrate
   both a valid tree and a tree that violates the ordering invariant. *)

(* Task 3 — Understand balanced trees without another full implementation.
   For a supplied red-black insertion trace, check the color, black-height,
   and ordering invariants after each rotation/recoloring step. Explain how
   those invariants bound height and therefore lookup and update cost. *)

(* Task 4 — Use comparator-driven Map and Set.
   Define [Symbol.T] with [type t = string] and deriving for [compare], [sexp],
   and [hash], then include [Comparable.Make (T)]. Build [Symbol.Map] and
   [Symbol.Set] clients and test replacement, ordering, and deduplication. *)

(* Task 5 — Factor one reusable index.
   Specify an [Index] module type with abstract [key] and ['a t]. Implement
   [Make_index (Key : Comparator.S)] using Core [Map]. Instantiate it for
   [Symbol] and run the same representation-independent client on the result. *)

(* Task 6 — Compare representations.
   Make a table of lookup, insertion, deletion, traversal order, persistence,
   and space costs for the queue, unbalanced BST, balanced [Map], and [Set].
   Give one workload where each is the right choice and one where it is not.

   After all checks pass, print exactly [E10 passed] as the final output line. *)

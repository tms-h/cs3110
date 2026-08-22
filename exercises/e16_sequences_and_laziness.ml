open! Core

(* E16 — Sequences, laziness, and productivity

   This preserves infinite-data reasoning and forcing behavior in one module,
   instead of separating streams, numerical examples, and laziness drills. *)

(* Task 1 — Define a productive sequence.
   Define ['a seq = unit -> 'a node] with [Nil | Cons of 'a * 'a seq].
   Implement [of_list], [map], and [take]. Explain why the thunk placement lets
   consumers request one element at a time. *)

(* Task 2 — Build infinite producers safely.
   Implement [from], [iterate], [filter], and [nth]. Test finite observations of
   infinite inputs. State the productivity condition for [filter] and give an
   input/predicate pair for which asking for the next element diverges. *)

(* Task 3 — Preserve fairness.
   Implement [interleave] so two infinite sequences both contribute. Compare it
   with append, then enumerate pairs of natural numbers diagonally without
   starving either coordinate. *)

(* Task 4 — Control memoization with [Lazy.t].
   Construct a lazy computation with a visible effect and force it twice.
   Predict the effect count and result identity. Contrast memoized laziness
   with a sequence thunk that can recompute whenever called. *)

(* Task 5 — Write one useful numerical stream.
   Produce primes using incremental trial division or a sieve-like stream and
   verify a finite prefix. Separate the mathematical idea from performance
   claims; identify retained data and the cost of producing the nth result. *)

(* Task 6 — Diagnose space leaks.
   Demonstrate how retaining the head of a memoized stream can retain its
   forced tail. Rewrite the consumer so processed prefixes become collectible,
   and explain the forcing boundary in terms of ownership.

   After all checks pass, print exactly [E16 passed] as the final output line. *)

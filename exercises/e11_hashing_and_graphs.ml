open! Core

(* E11 — Hashing and graph algorithms

   This keeps the interview-relevant algorithms while avoiding three separate
   hash-table implementations and repeated graph representations. *)

(* Task 1 — Respect the equality/hash contract.
   Define a case-insensitive identifier module with [compare], [equal], [hash],
   and [sexp]. Show that values considered equal have the same hash. Explain the
   bug caused when equality and hashing disagree. *)

(* Task 2 — Use a production hash table.
   Count identifiers with [Hashtbl], expose deterministic sorted bindings, and
   state the table invariant. Measure bucket statistics at increasing sizes and
   relate collisions and load factor to expected O(1) operations. *)

(* Task 3 — Implement bounded linear probing once.
   Complete a small fixed-capacity table with insertion and lookup. Every probe
   must terminate after at most the array length. Add deletion using tombstones
   (or justify rehashing a cluster), and test a full table plus wraparound. *)

(* Task 4 — Convert graph representations.
   Define a directed graph as an adjacency map and convert an edge list into it.
   Preserve isolated vertices, reject or normalize duplicate edges explicitly,
   and state the representation invariant and construction complexity. *)

(* Task 5 — Implement DFS and BFS deliberately.
   Implement iterative DFS and BFS with explicit visited sets. Return traversal
   order and shortest unweighted distances from a source. Test cycles,
   disconnected vertices, self-loops, and a missing source. *)

(* Task 6 — Derive graph properties.
   Use the traversals to compute connected components for an undirected graph
   and to detect whether it is bipartite. Give O(V + E) arguments and add an
   odd-cycle counterexample that reports a useful witness.

   After all checks pass, print exactly [E11 passed] as the final output line. *)

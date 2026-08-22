(** E42 — Supplemental graph representations and search (150-205 min)

    Recommended placement: immediately after E32, before the sequence labs. Build:
    [opam exec -- dune build exercises/e42_graph_search.exe] Run:
    [opam exec -- dune exec exercises/e42_graph_search.exe] *)

(* Task 1 — Normalize an undirected graph and traverse it.
   Inspired by 99 Problems P80 and P87. Define [IntMap = Map.Make (Int)] and
   [IntSet = Set.Make (Int)], then represent a graph as
   [type graph = IntSet.t IntMap.t]. Every vertex must be a map key and its set
   contains exactly its neighbours.

   Define
   [graph_of_edges : vertices:int list -> (int * int) list ->
     (graph, string * int) result]. The graph is undirected: store both
   directions. Deduplicate repeated vertices, repeated edges, and reversed
   edges; add edge endpoints even when they are absent from [vertices], while
   retaining explicitly listed isolated vertices. Reject a self-loop with
   [Error ("self-loop", vertex)]. Define [vertices] and [neighbors] to return
   ascending lists; [neighbors graph vertex] returns [] when the vertex is
   absent.

   Define [dfs graph start] with an immutable visited set. Visit neighbours in
   ascending order and return discovery order; return [] when [start] is absent.
   Test normalization, both directions of every edge, a cycle, a disconnected
   component, an isolated vertex, an absent start, and self-loop rejection.
   State why tree traversal needs no visited set but graph traversal does.
   Example form: [IntMap.update vertex (fun adjacent -> ...) graph]
   Build and run before continuing. *)

(* Task 2 — Enumerate every simple path.
   Inspired by 99 Problems P81. Define
   [all_simple_paths graph ~src ~dst]. A path contains both endpoints and may
   not repeat a vertex. If either endpoint is absent, return []; when
   [src = dst] and the vertex exists, return [[[src]]]. Explore neighbours in
   ascending order, so the result order is deterministic.

   On the graph with edges
   [[(1,2); (1,3); (2,3); (2,4); (3,4)]], assert the paths from 1 to 4 are
   exactly
   [[[1;2;3;4]; [1;2;4]; [1;3;2;4]; [1;3;4]]]. Also test equal endpoints,
   missing endpoints, and termination on a cycle. Explain why this search needs
   a visited set local to the current path: a single global set would discard
   valid alternatives reached through a different prefix.
   Example form: [List.map (fun suffix -> current :: suffix) child_paths]
   Build and run before continuing. *)

(* Task 3 — Split a graph into connected components.
   Inspired by 99 Problems P88. Define [connected_components graph] by
   repeatedly starting a traversal at the least unassigned vertex. Sort each
   component increasingly and order components by their least element. Include
   isolated vertices as singleton components.

   Test [] for an empty graph. Then test exact components for a graph with two
   nontrivial components and one isolate. Assert flattening the result contains
   every vertex exactly once. Explain how repeatedly composing a one-start DFS
   solves a different problem from Task 1 without duplicating its traversal.
   Build and run before continuing. *)

(* Task 4 — Two-colour every component.
   Inspired by 99 Problems P89. Define
   [bipartition : graph -> ((IntSet.t * IntSet.t), int * int) result]. Colour
   every disconnected component with a breadth-first FIFO frontier, choosing
   its least vertex for the first set and visiting neighbours in ascending order.
   Return [Ok (left, right)] only when the sets partition all vertices and every
   edge crosses between them. Isolated vertices belong to [left]. On an
   odd-cycle conflict, return the first conflicting edge encountered under the
   stated breadth-first order, with its smaller endpoint first.

   Test empty and edgeless graphs, an even cycle, a triangle returning
   [Error (2,3)], and a disconnected graph that fails because just one component
   is odd. For every successful test, independently check vertex coverage,
   disjointness, and the crossing-edge property.

   After every required explanation and assertion in E42 is present and
   passing, print exactly ["E42 passed"] once, and not earlier.
   Example form: [IntMap.add neighbor opposite_colour colors]
   Build and run before continuing. *)

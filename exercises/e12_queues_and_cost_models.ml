(** E12 — Queues, worklists, and amortized cost (135-185 min)

    Build: [opam exec -- dune build exercises/e12_queues_and_cost_models.exe] Run:
    [opam exec -- dune exec exercises/e12_queues_and_cost_models.exe] *)

(* Task 1 — Extension: define the queue interface.
   Define module type [QUEUE] with abstract type ['a t], [empty : 'a t],
   [is_empty : 'a t -> bool], [enqueue : 'a -> 'a t -> 'a t], and
   [dequeue : 'a t -> ('a * 'a t) option]. A queue is FIFO; dequeue returns
   [None] exactly for empty.

   Define [empty_is_empty (module Q : QUEUE)] to return
   [Q.is_empty Q.empty], exercising first-class module syntax. Its runtime
   tests begin after concrete queue modules exist. Here [(module Q : QUEUE)]
   unpacks a module value so an ordinary function can receive a queue
   implementation at runtime; it is a labelled extension, not a prerequisite
   for the source timing exercise.
   Example form: [let initial_size (module C : COLLECTION) = C.size C.empty]
   Build and run before continuing. *)

(* Task 2 — Extension: implement a one-list queue.
   Define [List_queue : QUEUE] with a list stored in dequeue order. [enqueue x q]
   appends [x]; [dequeue] removes the head.

   Test [is_empty empty], enqueue 1 then 2 then 3, and check three dequeues return
   1, 2, and 3 followed by [None].
   Example form: [module Stack = struct type 'a t = 'a list let empty = [] end]
   Build and run before continuing. *)

(* Task 3 — Extension: implement a batched queue.
   Define [Batched_queue : QUEUE] with representation [(front, back)], where
   [front] is in dequeue order and [back] is in reverse enqueue order. Define
   [normalize] so an empty [front] reverses [back] once; the representation
   invariant requires an empty [front] to imply an empty [back].

   Implement all four queue operations. Repeat the FIFO test from Task 2 and add
   an enqueue after one dequeue.
   Example form: [let rebalance = function [], saved -> (List.rev saved, []) | state -> state]
   Build and run before continuing. *)

(* Task 4 — Extension: write a representation-independent client.
   Define functor [Exercise (Q : QUEUE)]. Inside it, define [fill n] to enqueue
   integers 0 through [n - 1], returning [Q.empty] when [n <= 0]. Define
   [drain q] to dequeue until empty and return values in FIFO order.

   Define [L = Exercise (List_queue)] and [B = Exercise (Batched_queue)]. Test
   [L.drain (L.fill 5)] and [B.drain (B.fill 5)] both equal [0; 1; 2; 3; 4].
   Example form: [module Use (C : COLLECTION) = struct let singleton x = C.add x C.empty end]
   Build and run before continuing. *)

(* Task 5 — Measure queue construction.
   Define [time f x] with [Unix.gettimeofday], returning [(f x, elapsed_seconds)].
   For each queue module, measure construction at exponentially increasing sizes:
   10, 100, 1,000, and so on. Record the first size with a noticeable delay and,
   only if it is safe to continue, the first size taking about ten seconds. Stop
   before a run that is likely to be disruptive.

   Use [drain] to check equal FIFO results at sizes that complete promptly. Never
   assert elapsed times; machine load makes timing nondeterministic.

   Record the measurements in a comment. Do not leave a long benchmark call at
   top level: normal [dune exec] must finish promptly. Keep a short smoke run
   guarded by a small size, or keep only the [time] helper and recorded results.
   Example form: [let started = Unix.gettimeofday () in let result = work input in (result, Unix.gettimeofday () -. started)]
   Build and run before continuing. *)

(* Task 6 — State operation costs.
   Record worst-case costs for every [List_queue] and [Batched_queue] operation,
   plus amortized costs for the batched queue. Derive these four source claims
   explicitly: [List_queue.enqueue] is O(n) because [@] traverses the stored
   list, so constructing a queue with n enqueues is O(n^2);
   [Batched_queue.enqueue] is O(1), so n enqueues are O(n). Then explain why a
   reversal costing O(n) still gives amortized O(1) dequeue: each element can be
   moved from [back] to [front] at most once before it is removed.

   Retain the runtime equality tests from Task 5.
   Example form: [(* stack push: worst-case O(1); stack pop: worst-case O(1). *)]
   Build and run before continuing. *)

(* Task 7 — Supplemental practice: build a Huffman tree with a priority worklist.
   Inspired by 99 Problems P50. Define
   [type 'a huffman = HLeaf of 'a * int | HNode of int * 'a huffman * 'a huffman]
   and [weight]. Define
   [huffman_tree : equal:('a -> 'a -> bool) -> ('a * int) list ->
     ('a huffman, string) result]. Use [equal] to reject duplicate symbols; also
   reject an empty table and nonpositive frequencies. Otherwise keep a stable
   worklist ordered by weight, repeatedly remove the two lightest trees, combine
   them with the first as the left child, and reinsert the result after existing
   trees of equal weight. The tie rule makes the construction deterministic.

   Define [huffman_codes : 'a huffman -> ('a * string) list], assigning 0 to a
   left edge and 1 to a right edge; a one-symbol tree receives code ["0"]. Also
   define [weighted_path_length] as the sum of each frequency times its emitted
   code length, and a check that no emitted code is a prefix of another. Test the
   table
   [[('a',45); ('b',13); ('c',12); ('d',16); ('e',9); ('f',5)]] has total
   weight 100, weighted path length 224, and prefix-free codes. Cover one symbol
   and every rejection case.

   Derive the construction cost for a sorted-list worklist with [k] symbols,
   then contrast it with a binary-heap worklist. After every required assertion
   and written explanation in E12 is present, print exactly [E12 passed].
   Example form: [let combined = HNode (weight left + weight right, left, right)]
   Build and run before continuing. *)

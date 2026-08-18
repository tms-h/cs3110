(** E12 — Queues and amortized cost (90-125 min)

    Build: [opam exec -- dune build exercises/e12_queues_and_cost_models.exe] Run:
    [opam exec -- dune exec exercises/e12_queues_and_cost_models.exe] *)

(* Task 1 — Define the queue interface.
   Define module type [QUEUE] with abstract type ['a t], [empty : 'a t],
   [is_empty : 'a t -> bool], [enqueue : 'a -> 'a t -> 'a t], and
   [dequeue : 'a t -> ('a * 'a t) option]. A queue is FIFO; dequeue returns
   [None] exactly for empty.

   Define [empty_is_empty (module Q : QUEUE)] to return
   [Q.is_empty Q.empty], exercising first-class signature syntax. Its runtime
   tests begin after concrete queue modules exist.
   Example form: [let initial_size (module C : COLLECTION) = C.size C.empty]
   Build and run before continuing. *)

(* Task 2 — Implement a one-list queue.
   Define [List_queue : QUEUE] with a list stored in dequeue order. [enqueue x q]
   appends [x]; [dequeue] removes the head.

   Test [is_empty empty], enqueue 1 then 2 then 3, and check three dequeues return
   1, 2, and 3 followed by [None].
   Example form: [module Stack = struct type 'a t = 'a list let empty = [] end]
   Build and run before continuing. *)

(* Task 3 — Implement a batched queue.
   Define [Batched_queue : QUEUE] with representation [(front, back)], where
   [front] is in dequeue order and [back] is in reverse enqueue order. Define
   [normalize] so an empty [front] reverses [back] once; the representation
   invariant requires an empty [front] to imply an empty [back].

   Implement all four queue operations. Repeat the FIFO test from Task 2 and add
   an enqueue after one dequeue.
   Example form: [let rebalance = function [], saved -> (List.rev saved, []) | state -> state]
   Build and run before continuing. *)

(* Task 4 — Write a representation-independent client.
   Define functor [Exercise (Q : QUEUE)]. Inside it, define [fill n] to enqueue
   integers 0 through [n - 1], returning [Q.empty] when [n <= 0]. Define
   [drain q] to dequeue until empty and return values in FIFO order.

   Define [L = Exercise (List_queue)] and [B = Exercise (Batched_queue)]. Test
   [L.drain (L.fill 5)] and [B.drain (B.fill 5)] both equal [0; 1; 2; 3; 4].
   Example form: [module Use (C : COLLECTION) = struct let singleton x = C.add x C.empty end]
   Build and run before continuing. *)

(* Task 5 — Measure queue construction.
   Define [time f x] with [Unix.gettimeofday], returning [(f x, elapsed_seconds)].
   Measure filling and draining 1,000, 10,000, and 100,000 elements for both
   queue modules, stopping if a run becomes disruptive. Assert only that both
   modules produce equal drained lists; print rather than assert elapsed times.

   Record the measurements in a comment.
   Example form: [let started = Unix.gettimeofday () in let result = work input in (result, Unix.gettimeofday () -. started)]
   Build and run before continuing. *)

(* Task 6 — State operation costs.
   Record worst-case costs for every [List_queue] and [Batched_queue] operation,
   plus amortized costs for the batched queue. Explain why one reversal costing
   O(n) still gives amortized O(1) dequeue.

   Retain the runtime equality tests from Task 5.
   Example form: [(* stack push: worst-case O(1); stack pop: worst-case O(1). *)]
   Build and run before continuing. *)

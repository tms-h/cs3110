(** E12 — Queues and cost models (35-50 min)

    OUTCOME

    - Implement two representations behind one queue signature.
    - Connect measured behavior to worst-case and amortized analysis.

    STEP 1 — IMPLEMENT THE SIMPLE REPRESENTATION

    - Read the [QUEUE] signature and tests first.
    - Implement [List_queue] as one list in dequeue order.
    - You may use append in [enqueue].
    - Record the cost of one enqueue and of n consecutive enqueues.

    STEP 2 — WRITE THE BATCHED INVARIANT

    - Represent the queue as [(front, back)].
    - Store [back] in reverse enqueue order.
    - Require that an empty [front] implies an empty [back].
    - Implement [normalize] before the public operations.

    STEP 3 — ADAPT THROUGH THE INTERFACE

    - Implement [Exercise.drain] using only [QUEUE] operations.
    - Do not inspect either representation.
    - Confirm the same code works for [L] and [B].

    STEP 4 — MEASURE CAREFULLY

    - Use [fill] and [time] at increasing powers of ten.
    - Stop before a run becomes disruptive.
    - Record results in [TIMING TABLE]. Treat them as evidence, not proof.

    STEP 5 — EXPLAIN AND FINISH

    - State worst-case and amortized costs for each batched operation.
    - Explain why reversal does not make every dequeue linear on average.
    - Run [opam exec -- dune exec exercises/e12_queues_and_cost_models.exe].

    Source coverage: big list queue; big batched queue; queue efficiency. *)

module type QUEUE = sig
  type 'a t

  val empty : 'a t
  val is_empty : 'a t -> bool
  val enqueue : 'a -> 'a t -> 'a t
  val dequeue : 'a t -> ('a * 'a t) option
end

module List_queue : QUEUE = struct
  type 'a t = 'a list

  let empty = []
  let is_empty (_q : 'a t) = failwith "TODO"
  let enqueue (_x : 'a) (_q : 'a t) : 'a t = failwith "TODO"
  let dequeue (_q : 'a t) : ('a * 'a t) option = failwith "TODO"
end

module Batched_queue : QUEUE = struct
  type 'a t = 'a list * 'a list

  let empty = ([], [])
  let normalize (_q : 'a t) : 'a t = failwith "TODO: restore RI"
  let is_empty (_q : 'a t) = failwith "TODO"
  let enqueue (_x : 'a) (_q : 'a t) : 'a t = failwith "TODO"
  let dequeue (_q : 'a t) : ('a * 'a t) option = failwith "TODO"
end

module Exercise (Q : QUEUE) = struct
  let fill n =
    let rec loop i q = if i = n then q else loop (i + 1) (Q.enqueue i q) in
    loop 0 Q.empty

  let drain (_q : 'a Q.t) : 'a list = failwith "TODO: API only"
end

module L = Exercise (List_queue)
module B = Exercise (Batched_queue)

let time f x =
  let started = Unix.gettimeofday () in
  let result = f x in
  (result, Unix.gettimeofday () -. started)

(* TIMING TABLE:
   n       List_queue       Batched_queue

   COST EXPLANATION: ... *)

let () =
  assert (L.drain (L.fill 5) = [ 0; 1; 2; 3; 4 ]);
  assert (B.drain (B.fill 5) = [ 0; 1; 2; 3; 4 ]);
  print_endline "E12 complete"

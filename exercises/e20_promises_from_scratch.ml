(** E20 — Promises from scratch (40-50 min)

    OUTCOME

    - Implement a one-assignment state machine with callbacks.
    - Reason about registration and resolution order precisely.

    STEP 1 — STATE THE PROMISE INVARIANT

    - A pending promise owns callbacks in registration order.
    - A resolved promise owns exactly one immutable value.
    - A resolver succeeds once. Choose and document the second-call error.

    STEP 2 — IMPLEMENT CREATION AND RESOLUTION

    - Implement [create], [return], [upon], and [resolve] in that order.
    - Test callbacks registered before resolution.
    - Test a callback registered after resolution; it must run immediately.

    STEP 3 — CHAIN PROMISES

    - Implement [bind].
    - Preserve registration order while forwarding the result promise.
    - Draw the state transition if a callback returns an already resolved promise.

    STEP 4 — DERIVE MAP TWICE

    - Implement [map_via_bind] using only [bind] and [return].
    - Implement [map_direct] without calling [bind].
    - Explain why the two are observationally equivalent here.

    STEP 5 — PREDICT THE TEST TRACE

    - Write the expected trace before running the file.
    - If it differs, draw state after every [create], [upon], and [resolve].

    STEP 6 — TRANSFER AND FINISH

    - Implement [both]. Output order follows arguments, not resolution order.
    - Explain how resolution order can still affect callback timing.
    - Run [opam exec -- dune exec exercises/e20_promises_from_scratch.exe].

    Reading fallback: https://cs3110.github.io/textbook/chapters/ds/promises.html

    Source coverage: promise and resolve; map via bind; map anew. *)

module Promise : sig
  type 'a t
  type 'a resolver

  val create : unit -> 'a t * 'a resolver
  val return : 'a -> 'a t
  val resolve : 'a resolver -> 'a -> unit
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val map_via_bind : 'a t -> ('a -> 'b) -> 'b t
  val map_direct : 'a t -> ('a -> 'b) -> 'b t
  val upon : 'a t -> ('a -> unit) -> unit
  val both : 'a t -> 'b t -> ('a * 'b) t
end = struct
  type 'a state = Pending of ('a -> unit) list | Resolved of 'a
  type 'a t = 'a state ref
  type 'a resolver = 'a state ref

  let create () : 'a t * 'a resolver = failwith "TODO"
  let return (_x : 'a) : 'a t = failwith "TODO"
  let resolve (_r : 'a resolver) (_x : 'a) : unit = failwith "TODO"
  let upon (_p : 'a t) (_f : 'a -> unit) : unit = failwith "TODO"
  let bind (_p : 'a t) (_f : 'a -> 'b t) : 'b t = failwith "TODO"

  let map_via_bind (_p : 'a t) (_f : 'a -> 'b) : 'b t =
    failwith "TODO: use bind and return"

  let map_direct (_p : 'a t) (_f : 'a -> 'b) : 'b t = failwith "TODO: do not call bind"
  let both (_a : 'a t) (_b : 'b t) : ('a * 'b) t = failwith "TODO: transfer"
end

let () =
  let trace = ref [] in
  let p, r = Promise.create () in
  let doubled = Promise.map_direct p (fun x -> x * 2) in
  Promise.upon p (fun x -> trace := ("p=" ^ string_of_int x) :: !trace);
  Promise.upon doubled (fun x -> trace := ("d=" ^ string_of_int x) :: !trace);
  assert (!trace = []);
  Promise.resolve r 21;
  Promise.upon p (fun _ -> trace := "late" :: !trace);
  assert (List.rev !trace = [ "p=21"; "d=42"; "late" ]);
  let a, ra = Promise.create () and b, rb = Promise.create () in
  let pair = Promise.both a b in
  let seen = ref None in
  Promise.upon pair (fun value -> seen := Some value);
  Promise.resolve rb "right";
  assert (!seen = None);
  Promise.resolve ra "left";
  assert (!seen = Some ("left", "right"));
  print_endline "E20 complete"

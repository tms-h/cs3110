(** E20 — Promises from scratch (90-125 min)

    Build: [opam exec -- dune build exercises/e20_promises_from_scratch.exe] Run:
    [opam exec -- dune exec exercises/e20_promises_from_scratch.exe] Reading:
    https://cs3110.github.io/textbook/chapters/ds/promises.html *)

(* Task 1 — Define promise state and creation.
   Begin module [Promise]. Define ['a state] as either pending callbacks or one
   resolved value. Define abstract-by-convention types ['a t] and ['a resolver]
   using references to the same state. Define [create ()] to return a fresh
   pending promise and its resolver.

   Before sealing the module, inspect both returned references and test each
   contains [Pending []].
   Example form: [type 'a status = Waiting of ('a -> unit) list | Ready of 'a]
   Build and run before continuing. *)

(* Task 2 — Register callbacks.
   Complete [upon promise callback]. For a pending promise, save callbacks in
   registration order without invoking them. For a resolved promise, invoke the
   callback immediately exactly once.

   Register two callbacks that append distinct strings to a trace and test the
   trace remains empty while pending.
   Example form: [match !cell with Waiting _ -> remember callback | Ready value -> notify callback value]
   Build and run before continuing. *)

(* Task 3 — Resolve once.
   Define [resolve resolver value]. Change pending state to resolved, then invoke
   every saved callback once in registration order. A second resolve must raise
   [Invalid_argument "resolve"] and must not invoke callbacks again.

   Test callback order with two registrations, an immediate late registration,
   and the second-resolution exception.
   Example form: [List.iter (fun callback -> callback value) callbacks]
   Build and run before continuing. *)

(* Task 4 — Return and bind.
   Define [return value] as an already resolved promise. Define
   [bind promise f] to return a new promise resolved with the eventual value of
   [f value]. It must work when either input or returned promise is already
   resolved.

   Test binding [return 3] through a function returning [return 4]. Then bind a
   pending promise through a pending returned promise and test each resolution
   step separately with a trace.
   Example form: [on_ready first (fun value -> on_ready (next value) (finish destination))]
   Build and run before continuing. *)

(* Task 5 — Define map twice.
   Define [map_via_bind promise f] using only [bind] and [return]. Define
   [map_direct promise f] without calling [bind]. Both must resolve to [f value]
   exactly once and preserve callback timing.

   Test both maps on an already resolved promise and on a pending promise that
   later resolves to 21, producing 42.
   Example form: [let transformed source f = chain source (fun value -> pure (f value))]
   Build and run before continuing. *)

(* Task 6 — Combine two promises.
   Define [both a b] to resolve only after both inputs resolve, with pair
   [(value_of_a, value_of_b)] regardless of resolution order.

   Test resolving b before a leaves the result pending, then produces
   [("left", "right")] after a resolves. Repeat with a before b.
   Example form: [let left = ref None and right = ref None]
   Build and run before continuing. *)

(* Task 7 — Seal the promise API.
   Add a signature to [Promise] exposing abstract ['a t] and ['a resolver] plus
   [create], [return], [resolve], [bind], [map_via_bind], [map_direct], [upon],
   and [both] with their inferred types. Keep all earlier tests outside the
   module and verify they still compile without representation access.
   Example form: [module Hidden : API = struct (* implementation *) end]
   Build and run before continuing. *)

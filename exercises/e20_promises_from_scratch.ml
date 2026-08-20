(** E20 — Promises from scratch (90-125 min)

    Build: [opam exec -- dune build exercises/e20_promises_from_scratch.exe] Run:
    [opam exec -- dune exec exercises/e20_promises_from_scratch.exe] Reading:
    https://cs3110.github.io/textbook/chapters/ds/promises.html *)

(* Incremental staging rule.
   Tasks 1-6 define representation types and [_rep] helper functions at top
   level. Do not open a module and try to add definitions after [end]; OCaml
   modules are not reopenable. Task 7 assembles [Promise_impl] exactly once from
   the completed helpers, then seals the public module. *)

(* Task 1 — Define the shared representation and creation helper.
   At top level, define ['a promise_state] as pending callbacks or one resolved
   value. Define ['a promise_rep] and ['a resolver_rep] as references to that
   state, and [create_rep ()] as a fresh pending pair.

   Write white-box tests directly against these representation helpers. Assert
   that both handles refer to the same pending state. Keep those tests when the
   public module is assembled later.
   Build and run before continuing. *)

(* Task 2 — Register callbacks.
   Define top-level [upon_rep promise callback]. Pending callbacks are saved
   without being invoked; a callback registered on a resolved promise runs
   immediately exactly once. Preserve registration order. For this exercise,
   callbacks are required not to raise; record that precondition.

   Register two callbacks that append distinct values to a trace and assert the
   trace remains empty while pending.
   Build and run before continuing. *)

(* Task 3 — Resolve once.
   Define top-level [resolve_rep resolver value]. First transition the shared
   state to resolved, then invoke every saved callback once in registration
   order. A second resolution raises [Invalid_argument "resolve"] and invokes
   nothing.

   Test callback order, a callback registered after resolution, and the exact
   second-resolution exception.
   Build and run before continuing. *)

(* Task 4 — Define return and bind helpers.
   Define [return_rep value] as an already-resolved representation. Define
   [bind_rep promise f] to return a new representation that resolves with the
   eventual value of [f value]. It must handle every combination of pending and
   already-resolved source/result promises.

   Test an immediate chain and a chain whose source and returned promise resolve
   in separate later steps. Check the trace after every transition.
   Build and run before continuing. *)

(* Task 5 — Promise and resolve client on the completed core.
   Perform the textbook client exercise with the [_rep] core: create an integer
   promise/resolver pair, bind a function that prints the integer and records it
   in a trace, then resolve the promise. Assert the trace is empty before
   resolution and contains the integer only afterward. The printing side effect
   must also occur only after resolution.
   Build and run before continuing. *)

(* Task 6 — Define map helpers two ways.
   Define [map_via_bind_rep promise f] using only [bind_rep] and [return_rep].
   Separately define [map_direct_rep promise f] without calling [bind_rep]. Both
   apply [f] exactly once and preserve pending-versus-resolved timing.

   Test both maps with immediate and delayed promises, including a counter that
   proves [f] is called once.
   Build and run before continuing. *)

(* Extension — Combine two representations.
   Define top-level [both_rep a b], resolving only after both inputs and
   preserving pair order regardless of resolution order. Test both orders and
   already-resolved inputs. It need not be part of the required public API. *)

(* Task 7 — Assemble once, then seal.
   Define module type [PROMISE] exposing abstract ['a t] and ['a resolver] plus
   [create], [return], [resolve], [bind], both map functions, and [upon]. Now and
   only now define [Promise_impl] once: alias its internal types to the top-level
   representation types and bind each public operation to its [_rep] helper.
   Then define [module Promise : PROMISE = Promise_impl].

   Leave every representation assertion targeting the top-level helpers. Re-run
   the Task 5 client and all other black-box tests through [Promise], where direct
   state or reference access must fail to type-check. Do not delete an earlier
   assertion merely to make sealing compile.
   Build and run before continuing. *)

(* Final task — Completion marker.
   Only after every required white-box and black-box assertion passes, make the
   completed program print exactly [E20 passed] once. *)

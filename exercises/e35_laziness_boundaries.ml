(** E35 — Laziness and memoization (80-110 min)

    Build: [opam exec -- dune build exercises/e35_laziness_boundaries.exe] Run:
    [opam exec -- dune exec exercises/e35_laziness_boundaries.exe] *)

(* Task 1 — Delay the whole sequence node.
   Define ['a sequence = Cons of (unit -> 'a * 'a sequence)]. Define [head] and
   [tail] by invoking the stored thunk. Define [naturals_from n] and [map f s].
   This representation delays both the first value and tail but does not memoize.

   Test natural 10, the next value 11, and mapped value 22. Use a counter to test
   calling [head] twice invokes the same thunk twice.
   Build and run before continuing. *)

(* Task 2 — Observe [Lazy.t] memoization.
   Define [lazy_hello : unit Lazy.t] whose body increments a counter and prints
   ["hello"]. Force the same value twice. Test the counter equals 1 and both
   forces return unit.

   Explain why this differs from a plain [unit -> unit] thunk.
   Build and run before continuing. *)

(* Task 3 — Define lazy conjunction.
   Define [(&&&) left right] for [bool Lazy.t]. Force [left] first. If false,
   return false without forcing [right]; otherwise return [Lazy.force right].

   Use a counter in [right]. Test false-left leaves the counter zero, true-left
   forces it once, and the returned Boolean matches ordinary conjunction.
   Build and run before continuing. *)

(* Task 4 — Define memoizing lazy sequences.
   Define mutually recursive types ['a lazy_sequence = 'a lazy_node Lazy.t] and
   ['a lazy_node = LCons of 'a * 'a lazy_sequence]. Define [lazy_map f s] so
   constructing it forces nothing and each output node is memoized.

   Instrument an input node and mapping function. Test construction does no work,
   one force does the work once, and forcing that result node again changes no
   counters.
   Build and run before continuing. *)

(* Task 5 — Filter a memoizing sequence.
   Define [lazy_filter predicate sequence] to search for the next matching node
   only when the output is forced. The output node and skipped search must be
   memoized by [Lazy.t].

   Test the first three even naturals, construction without forcing, and repeated
   forcing of one result node without repeated predicate calls.
   Build and run before continuing. *)

(* Task 6 — Zip with precise forcing.
   Define [lazy_zip a b] so forcing one output node forces one node from each
   input and returns their value pair plus a delayed zip of both tails.

   Use separate counters. Test construction forces neither input, one output
   force increments both once, and a repeated force increments neither again.
   Build and run before continuing. *)

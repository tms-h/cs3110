open! Core
open! Async

(* E17 — Async, Deferred, and Pipe

   This teaches the target Jane Street concurrency model directly while still
   preserving dependency, sequencing, streaming, and monadic-error reasoning. *)

(* Task 1 — Predict Deferred dependencies.
   Create two determined deferred values and one short [Clock.after]. Predict
   output order for [let%bind], [Deferred.both], and an unobserved deferred.
   Explain dependency ordering without claiming each deferred owns a thread. *)

(* Task 2 — Sequence a list intentionally.
   Implement [map_sequential] with a function returning ['b Deferred.t]. Show
   that effects occur in input order. Then run the parallel form once and state
   which dependencies make either choice correct. *)

(* Task 3 — Stream through a Pipe.
   Produce integers [1] through [n] into a pipe and consume them into a sum
   without materializing a list. Await writer pushback and close the writer on
   every normal path. *)

(* Task 4 — Preserve errors through async code.
   Consume strings from a pipe, parse each as an integer, and stop at the first
   invalid line with its one-based line number in an [Or_error]. Relate
   [Deferred.bind] and [Or_error.bind] to the same sequencing shape. *)

(* Task 5 — Run and shut down deterministically.
   Build [main : unit -> unit Deferred.t] for successful and failing paths.
   Start the scheduler once, print exactly [E17 passed] only after all checks
   finish, then shut down cleanly. *)

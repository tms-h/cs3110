open! Core
open! Async

(* E20 — Command and I/O integration

   The final file combines types, sexp boundaries, Async streams, validation,
   deterministic output, and operational errors in one small command. *)

(* Task 1 — Define the input boundary.
   Define a timestamped integer observation and derive [sexp]. Write a validator
   returning [Or_error.t] for nonnegative timestamps. Keep wire parsing distinct
   from validation. *)

(* Task 2 — Stream a file.
   Open a file with Async, consume its lines without loading the whole file,
   parse and validate each observation, and return count, minimum, maximum, and
   sum. Include line numbers in errors and close resources on every path. *)

(* Task 3 — Expose a Command.
   Build a [Command.async_or_error] command with required [-input FILE]. On
   success print one deterministic s-expression summary. Let the command
   boundary report expected errors rather than calling [failwith]. *)

(* Task 4 — Verify the executable boundary.
   Test empty, valid, malformed-sexpression, and invalid-timestamp files. Check
   exit status as well as output. Keep argument parsing and I/O in this file.

   Finish with [let () = Command_unix.run command]. *)

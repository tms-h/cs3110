(** E21 — Lwt scheduling and cleanup (90-125 min)

    Build: [opam exec -- dune build exercises/e21_lwt_scheduling.exe] Run:
    [opam exec -- dune exec exercises/e21_lwt_scheduling.exe] Reading:
    https://ocsigen.org/lwt/latest/api/Lwt and https://ocsigen.org/lwt/latest/api/Lwt_io
*)

(* Task 1 — Delay an asynchronous log.
   Open [Lwt.Infix]. Define [delay seconds = Lwt_unix.sleep seconds]. Define
   [delay_then_log seconds log] to wait asynchronously and then call
   [log "done"]. It must not call [Unix.sleep] or otherwise block the OS thread.

   Run a 0.001-second call with [Lwt_main.run] and test a captured trace changes
   from [] to ["done"].
   Build and run before continuing. *)

(* Task 2 — Run delays sequentially.
   Define [sequential log] to await 0.01 seconds then log ["10ms"], await 0.03
   seconds then log ["30ms"], and await 0.06 seconds then log ["60ms"]. Return a
   promise that resolves after the third log.

   Test the exact log order. Measure and print elapsed time, but do not assert a
   timing threshold.
   Build and run before continuing. *)

(* Task 3 — Join concurrent delays.
   Define [joined log] by starting the same three labelled delays before awaiting
   [Lwt.join]. Its result resolves only after all three complete.

   Test the exact completion order ["10ms"; "30ms"; "60ms"]. Measure and print
   elapsed time, and explain why it is near the longest delay rather than their
   sum. Do not assert elapsed time.
   Build and run before continuing. *)

(* Task 4 — Observe discarded promises.
   Define [discarded log] to start the same three promises and immediately return
   [Lwt.return_unit] without joining them. Run it in a fresh [Lwt_main.run] and
   test the trace is still empty when the main promise resolves.

   Add a comment explaining when constructing an Lwt promise starts work.
   Build and run before continuing. *)

(* Task 5 — Copy lines until EOF.
   Define recursive [copy_lines input consume]. Read with [Lwt_io.read_line], pass
   every line to [consume] in order, treat [End_of_file] as successful completion,
   and preserve every other exception as a failed promise.

   Use [Lwt_io.pipe] to write ["alpha"] and ["beta"], close the output, and test
   the consumer saw both lines. Use a consumer that fails with [Failure "stop"]
   and test that exact failure escapes.
   Build and run before continuing. *)

(* Task 6 — Monitor a file with scoped cleanup.
   Define [monitor_file path consume] to open [path] for input, call [copy_lines],
   and close the channel on success, failure, or cancellation using
   [Lwt_io.with_file] or [Lwt.finalize].

   Create a temporary two-line file, test both lines are consumed, then test a
   failing consumer preserves its exception. Remove the temporary file afterward.
   Build and run before continuing. *)

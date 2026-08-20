(** E21 — Lwt promises, scheduling, and monitoring (90-125 min)

    Build: [opam exec -- dune build exercises/e21_lwt_scheduling.exe] Run:
    [opam exec -- dune exec exercises/e21_lwt_scheduling.exe] Reading:
    https://ocsigen.org/lwt/latest/api/Lwt and
    https://ocsigen.org/lwt/latest/api/Lwt_io *)

(* Task 1 — Create and resolve an Lwt promise.
   Open [Lwt.Infix]. Use [Lwt.wait ()] to create an integer promise and wakener.
   Bind an Lwt I/O action that writes the integer to an [Lwt_io.pipe]. Before
   waking the promise, assert the bound promise is sleeping and no line has been
   produced. Wake it with 3110, run the bound promise, close the output channel,
   and assert that the input channel yields ["3110"]. Use [Lwt.wakeup] exactly
   once; do not substitute the custom Promise module from E20.
   Build and run before continuing. *)

(* Task 2 — Delay an asynchronous action.
   Define [delay seconds = Lwt_unix.sleep seconds]. Define
   [delay_then_log : float -> (string -> unit) -> unit Lwt.t] to wait
   asynchronously, call [log "done"], and resolve. It must not call [Unix.sleep]
   or block the OS thread.

   Run a 0.001-second call and assert a captured trace changes from [] to
   ["done"].
   Build and run before continuing. *)

(* Task 3 — Predict sequential scheduling.
   Define [sequential : (string -> unit) -> unit Lwt.t] to wait 0.01 seconds and
   call [log "10ms"], then wait 0.03 and call [log "30ms"], then wait 0.06 and
   call [log "60ms"], and finally call [log "all done"]. Before running it,
   record the exact output order and expected approximate total time. Then run it,
   assert the trace is ["10ms"; "30ms"; "60ms"; "all done"], and compare the
   observation with the prediction. Print elapsed time but do not assert a
   fragile timing threshold.
   Build and run before continuing. *)

(* Task 4 — Predict unawaited work while the loop stays alive.
   Define [discarded : (string -> unit) -> unit Lwt.t] by evaluating three
   delayed logging promises for 0.01, 0.03, and 0.06 seconds, deliberately not
   joining them, then immediately calling [log "all done"] and resolving its own
   result.

   Before running it, predict the trace both when [discarded] resolves and after
   0.08 seconds. Run [discarded] together with a separate 0.08-second keeper
   promise so the event loop remains alive. Assert the trace is ["all done"] when
   [discarded] resolves and later becomes
   ["all done"; "10ms"; "30ms"; "60ms"]. Explain precisely that
   evaluating these [Lwt_unix.sleep] expressions schedules timers; merely
   ignoring their returned promises does not cancel them.
   Build and run before continuing. *)

(* Task 5 — Predict joined work.
   Define [joined : (string -> unit) -> unit Lwt.t] by starting the same three
   delayed log operations before awaiting [Lwt.join]. Call [log "all done"] only
   after the join resolves. Record a prediction, run it, assert the trace is
   ["10ms"; "30ms"; "60ms"; "all done"], and explain why completion is near the
   longest individual delay rather than the sum.
   Build and run before continuing. *)

(* Task 6 — Monitor lines until EOF.
   Define recursive
   [copy_lines : Lwt_io.input_channel -> (string -> unit Lwt.t) -> unit Lwt.t].
   Read with [Lwt_io.read_line], pass each line to [consume] in order, treat only
   [End_of_file] as successful completion, and preserve every other exception as
   a failed promise.

   Define
   [monitor_file : string -> (string -> unit Lwt.t) -> unit Lwt.t] to open the
   path for input and call [copy_lines], closing the channel on success, failure,
   or cancellation. Test ordered lines with [Lwt_io.pipe] and test that
   [Failure "stop"] escapes.

   Finally perform the textbook streaming experiment: in another terminal run
   [mkfifo log] and [cat > log], monitor the FIFO named [log], and record that
   each entered line is consumed before EOF rather than buffered until closing.
   Remove the FIFO after the experiment.
   Build and run before continuing. *)

(* Extension — Scoped file cleanup.
   Use [Lwt_io.with_file] or [Lwt.finalize] with a temporary regular file. Test
   success, consumer failure, and cancellation, and ensure the channel and file
   are cleaned up on every path. *)

(* Final task — Completion marker.
   Only after every prediction, observation, assertion, and cleanup check is
   complete, make the program print exactly [E21 passed] once. *)

(** E21 — Lwt scheduling and clean shutdown (40-50 min)

    OUTCOME

    - Predict when Lwt work starts and when a returned promise completes.
    - Handle asynchronous EOF, failure, and cleanup at the correct boundary.

    STEP 1 — COMPLETE ONE ASYNCHRONOUS CHAIN

    - Read https://ocsigen.org/lwt/latest/api/Lwt.
    - Implement [delay_then_log] with bind.
    - Do not block the OS thread.

    STEP 2 — PREDICT THREE TIMELINES

    - Fill [TIMING PREDICTIONS] before implementing the timing functions.
    - Predict event order and duration for sequential 10/30/60 ms sleeps.
    - Predict starting three promises and returning without joining them.
    - Predict starting the same promises and awaiting [Lwt.join].

    STEP 3 — IMPLEMENT AND MEASURE

    - Implement [sequential] and [joined].
    - Preserve labels in completion order.
    - Measure wall time and reconcile each result with your prediction.
    - Explain why constructing an Lwt promise can start work before it is awaited.

    STEP 4 — HANDLE STREAM TERMINATION

    - Read https://ocsigen.org/lwt/latest/api/Lwt_io.
    - Implement [copy_lines]. Treat [End_of_file] as successful completion.
    - Preserve every other exception as a failed promise.
    - Do not catch broadly and discard diagnostics.

    STEP 5 — CLEAN UP AND FINISH

    - Implement [monitor_file] with cleanup on success, failure, and cancellation.
    - Use [Lwt.finalize] or an equivalent scoped helper.
    - Run [opam exec -- dune exec exercises/e21_lwt_scheduling.exe].

    Source coverage: promise and resolve lwt; timing challenge 1-4; file monitor. *)

open Lwt.Infix

let delay seconds = Lwt_unix.sleep seconds

let delay_then_log (_seconds : float) (_log : string -> unit Lwt.t) : unit Lwt.t =
  failwith "TODO"

let sequential (_log : string -> unit Lwt.t) : unit Lwt.t =
  failwith "TODO: 0.01 then 0.03 then 0.06"

let joined (_log : string -> unit Lwt.t) : unit Lwt.t =
  failwith "TODO: start all, Lwt.join"

let rec copy_lines (_input : Lwt_io.input_channel) (_consume : string -> unit Lwt.t) :
    unit Lwt.t =
  failwith "TODO: clean End_of_file only"

let monitor_file (_path : string) (_consume : string -> unit Lwt.t) : unit Lwt.t =
  failwith "TODO: Lwt_io.with_file or Lwt.finalize"

(* TIMING PREDICTIONS:
   sequential =
   discarded  =
   joined     =
   EXPLANATION: ... *)

let test_copy_lines () =
  let input, output = Lwt_io.pipe () in
  let seen = ref [] in
  let writer =
    Lwt_list.iter_s (Lwt_io.write_line output) [ "alpha"; "beta" ] >>= fun () ->
    Lwt_io.close output
  in
  let reader =
    copy_lines input (fun line ->
        seen := line :: !seen;
        Lwt.return_unit)
  in
  Lwt.join [ writer; reader ] >|= fun () ->
  assert (List.rev !seen = [ "alpha"; "beta" ])

let () =
  Lwt_main.run (test_copy_lines ());
  print_endline "E21 complete"

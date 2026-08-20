(** E16 — Compilation-unit interface boundaries (80-110 min)

    The four exact staged libraries are under [exercises/e16_interface_stages].
    Build a stage with, for example:
    [opam exec -- dune build exercises/e16_interface_stages/stage1_no_mli]
    Explore it with:
    [opam exec -- dune utop exercises/e16_interface_stages/stage1_no_mli] *)

(* Task 1 — Observe an implementation with no interface.
   Open [stage1_no_mli/date.ml]. Before starting utop, predict every name and
   representation detail that the inferred interface exposes. Then load that
   stage, [open Date], create a date, access its [day] field directly, call
   [get_day], and call [to_string]. Record the actual inferred interface and
   explain any mismatch with your prediction.

   This is a compilation-unit experiment: do not replace it with a nested
   module in this file. Build the stage before continuing. *)

(* Task 2 — Add a concrete [.mli].
   Compare [stage2_concrete_mli/date.mli] with the implementation. Predict which
   of the Task 1 phrases will change, then repeat every phrase in that stage's
   utop. The record representation is deliberately still public. Explain why a
   concrete interface can restrict names without abstracting the type.
   Build the stage before continuing. *)

(* Task 3 — Abstract the representation.
   In [stage3_abstract_mli], the first interface declaration is [type date].
   Before loading it, predict the types or errors produced by every Task 1
   phrase. Repeat them in utop and explain why construction through [make_date]
   still works while direct record-field access does not.

   Also explain why clients cannot determine from this interface whether a date
   is stored as a record, tuple, or ordinal integer. Build before continuing. *)

(* Task 4 — Install a top-level printer.
   Load [stage4_printer] in utop and issue exactly:
   [#install_printer Date.format;;]
   Re-run the construction phrase from Task 3. Record the response before and
   after printer installation and explain why the abstract value is now shown
   helpfully without exposing its representation.
   Build the stage before continuing. *)

(* Extension — Representation-independent validation.
   In this exercise file, define a separate [SAFE_DATE] signature with abstract
   [t], validated construction, observers, [to_string], and [format]. Implement
   it first with a record and then with an ordinal day from 1 through 365. Use
   one client-test function against both sealed implementations. Keep all
   representation-specific tests inside their implementation modules so that
   sealing cannot invalidate earlier tests. *)

(* Final task — Completion marker.
   Only after all four staged observations and explanations are recorded and
   every required assertion passes, define
   [let e16_stage_observations_complete = true]. This explicit declaration is
   an honest sign-off on work that cannot be unit-tested from this file; do not
   add it before completing the four experiments. Then make this completed
   program print exactly [E16 passed] once. *)

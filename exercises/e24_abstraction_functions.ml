(** E24 — Abstraction functions and representation invariants (85-115 min)

    Build: [opam exec -- dune build exercises/e24_abstraction_functions.exe] Run:
    [opam exec -- dune exec exercises/e24_abstraction_functions.exe] *)

(* Incremental staging rule.
   Define representation types and [_rep] helpers at top level while they are
   still under white-box test. Assemble each implementation module exactly once,
   after all its helpers exist, then seal a separate public module. OCaml modules
   cannot be reopened after [end]. *)

(* Task 1 — Specify interval arithmetic.
   Before choosing a representation, define module type [INTERVAL] with abstract
   [t] and at least [make], [bounds], [add], [mul], [to_string], and [format].
   Specify closed intervals, argument/result order, and every exceptional case.
   For this lab, endpoints must be finite non-NaN floats; [make] raises
   [Invalid_argument "interval"] otherwise and orders valid endpoints.

   State what each arithmetic operation means mathematically and write at least
   one boundary example per operation. Do not implement yet.
   Build before continuing. *)

(* Task 2 — Write the interval AF and RI before the code.
   At top level, define [interval_rep = { lo : float; hi : float }]. In comments,
   write an abstraction function from a valid record to the mathematical set of
   reals it represents. State the RI: both endpoints are finite and [lo <= hi].

   Define [interval_rep_ok] to return its argument when the RI holds and raise
   [Invalid_argument "interval"] otherwise. Define [interval_make_rep] so every
   result passes the check. Write direct invalid-record tests now and keep them
   as white-box tests after public sealing.
   Build and run before continuing. *)

(* Task 3 — Complete helpers, assemble once, and seal intervals.
   Define top-level helpers for the remaining [INTERVAL] operations. Addition of
   [[a,b]] and [[c,d]] is [[a+c,b+d]]. Multiplication uses the minimum and maximum
   of the four endpoint products. Route results through [interval_rep_ok] so
   overflow to infinity or NaN is rejected. Define string and formatter helpers
   consistently.

   After every helper exists, define [Interval_impl] exactly once by aliasing
   [type t = interval_rep] and binding its operations to the helpers. Then define
   [module Interval : INTERVAL = Interval_impl]. Write black-box tests for
   reversed construction, endpoints, mixed-sign multiplication, two negative
   intervals, zero, rendering, and invalid/nonfinite inputs. Keep all Task 2
   white-box tests unchanged and passing.
   Build and run before continuing. *)

(* Task 4 — Install the interval printer.
   Load the completed module in utop and issue
   [#install_printer Interval.format;;]
   Record how the same interval value is displayed before and after installation
   and explain why the representation remains abstract.
   Build and run before continuing. *)

(* Task 5 — Specify function maps and their abstraction function.
   Define module type [FUNCTION_MAP] with abstract [('k,'v) t] and:
   [empty : ('k,'v) t], [mem : 'k -> ('k,'v) t -> bool],
   [find : 'k -> ('k,'v) t -> 'v],
   [add : 'k -> 'v -> ('k,'v) t -> ('k,'v) t], and
   [remove : 'k -> ('k,'v) t -> ('k,'v) t].

   [find] raises [Not_found] exactly when a key is absent. Use structural
   equality [(=)] for keys and document that limitation. At top level define
   [('k,'v) function_map_rep = 'k -> 'v]. Write the AF: a representation
   function binds [k] to [v] exactly when applying it to [k] returns [v]; raising
   [Not_found] represents absence. Explain why no separate finite RI is needed.
   Build before continuing. *)

(* Task 6 — Complete helpers, assemble once, and seal function maps.
   Define top-level [_rep] helpers for all five operations. Test empty lookup and
   membership, two bindings, shadowing, present and absent removal, and
   persistence of every older representation.

   After all helpers and white-box tests exist, define [Function_map_impl] once
   by aliasing its type to [function_map_rep] and binding the operations. Seal it
   as [Function_map : FUNCTION_MAP] and rerun the behavioral tests through the
   public module. Explain why [bindings] cannot enumerate an arbitrary
   function-backed map.
   Build and run before continuing. *)

(* Extension — Option-valued maps and generalized update.
   Define a separate implementation represented by ['k -> 'v option], where
   absence is data rather than [Not_found]. Add [update] and compare its AF and
   client ergonomics with the source representation. Do not replace the required
   [Function_map] implementation. *)

(* Extension — Interval queries.
   Add [contains] to a separate extended interval signature and implement it by
   reusing the public bounds contract, without exposing the record. *)

(* Final task — Completion marker.
   Only after both AFs, the interval RI, printer observation, and all required
   white-box and black-box assertions are complete, make the program print
   exactly [E24 passed] once. *)

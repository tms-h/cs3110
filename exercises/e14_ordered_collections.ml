(** E14 — Ordered maps and sets (80-110 min)

    Build: [opam exec -- dune build exercises/e14_ordered_collections.exe] Run:
    [opam exec -- dune exec exercises/e14_ordered_collections.exe] Reading:
    https://ocaml.org/manual/5.3/api/Map.S.html and
    https://ocaml.org/manual/5.3/api/Set.S.html *)

(* Task 1 — Order dates.
   Define record [date] with [month : int] and [day : int]. Define module
   [Date_order] with [type t = date] and chronological [compare], comparing month
   before day. Equal dates compare as zero. Match the source contract: do not
   validate dates here; behavior for invalid month/day combinations is
   deliberately unspecified.

   Define [Date_map = Map.Make (Date_order)]. Test January 1 before March 14,
   March 14 after January 1, and equality.
   Example form: [module Score_order = struct type t = int let compare = Int.compare end]
   Build and run before continuing. *)

(* Task 2 — Create and print a calendar.
   Define [calendar = string Date_map.t]. Add March 14→Pi and January 1→New year
   in that order. Define [print_calendar calendar] with [Date_map.iter]. It must
   print entries in chronological order as one [month/day: event] line each and
   print nothing for an empty calendar.

   Call it on the two-event calendar and verify that January 1 prints first.
   Example form:
   [Date_map.iter
      (fun date event ->
        Printf.printf "%d/%d: %s\n" date.month date.day event)
      calendar]
   Build and run before continuing. *)

(* Task 3 — Extension: render a calendar as data.
   Define [render_calendar calendar] to return the same lines as Task 2 in a
   string list. This pure form makes ordering easy to assert.

   Test [] for an empty map, then test the two-event calendar equals
   ["1/1: New year"; "3/14: Pi"].
   Example form:
   [Date_map.bindings entries
    |> List.map (fun (date, event) ->
         Printf.sprintf "%d/%d: %s" date.month date.day event)]
   Build and run before continuing. *)

(* Task 4 — Transform map values.
   Define [Char_map = Map.Make (Char)]. Define [is_for map] so each binding
   [c -> word] becomes [c -> "c is for word"] using a Map operation rather than
   converting to a list.

   Test a→apple and z→zebra, and test an empty map.
   Example form: [let label_keys map = Char_map.mapi (fun key value -> String.make 1 key ^ value) map]
   Build and run before continuing. *)

(* Task 5 — Find the next date.
   Define [first_after calendar date] to return the event at the least key
   strictly greater than [date]. Let [Not_found] escape when no later event
   exists, as specified by the textbook exercise.

   Extension: define [first_after_opt calendar date] with the safer return type
   [string option], returning [None] when no later event exists. Use documented
   [Date_map] search operations; do not call [bindings] in either function.

   In the calendar from Task 2, test a date before January 1, January 1 itself,
   and March 14, including the exact exception from [first_after].
   Example form:
   [Date_map.find_first_opt
      (fun key -> Date_order.compare key cutoff > 0)
      calendar]
   Build and run before continuing. *)

(* Task 6 — Build an ASCII-case-insensitive set.
   Define module [Case_insensitive] with [type t = string] and [compare] based on
   [String.lowercase_ascii]. This handles ASCII letters; do not claim Unicode
   case folding. Define [Ci_set = Set.Make (Case_insensitive)].

   Test that ["grr"] and ["GRR"] are one element, while ["Argh"] is distinct;
   the cardinality must be 2.
   Example form: [module Length_set = Set.Make (Length_order)]
   Build and run before continuing. *)

(* Task 7 — Extension: merge calendars with conflicts.
   Define [merge_error = Conflict of date * string * string]. Define
   [merge_calendars a b] to return [Ok merged] when no date occurs in both maps.
   On the earliest shared date, return [Error (Conflict (date, event_a, event_b))].

   Test merging with an empty map, two disjoint one-event maps, and two maps that
   assign different events to January 1. Also test two shared dates so the
   earlier one is the reported conflict.

   A useful first step is a concrete merge that preserves collisions for later
   inspection instead of silently choosing one event:
   [Date_map.merge
      (fun _ left right ->
        match (left, right) with
        | None, None -> None
        | Some event, None | None, Some event -> Some (`One event)
        | Some a, Some b -> Some (`Both (a, b)))
      first second]
   After every required assertion and written explanation in E14 is present,
   print exactly [E14 passed].
   Build and run before continuing. *)

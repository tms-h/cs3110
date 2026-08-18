(** E14 — Ordered maps and sets (80-110 min)

    Build: [opam exec -- dune build exercises/e14_ordered_collections.exe] Run:
    [opam exec -- dune exec exercises/e14_ordered_collections.exe] Reading:
    https://ocaml.org/manual/5.4/api/Map.S.html and
    https://ocaml.org/manual/5.4/api/Set.S.html *)

(* Task 1 — Order dates.
   Define record [date] with [month : int] and [day : int]. Define module
   [Date_order] with [type t = date] and chronological [compare], comparing month
   before day. Equal dates compare as zero.

   Define [Date_map = Map.Make (Date_order)]. Test January 1 before March 14,
   March 14 after January 1, and equality.
   Example form: [module Score_order = struct type t = int let compare = Int.compare end]
   Build and run before continuing. *)

(* Task 2 — Render a calendar.
   Define [calendar = string Date_map.t]. Define [render_calendar calendar] to
   return entries in chronological order, formatted ["month/day: event"].

   Test [] for an empty map. Add March 14→Pi and January 1→New year in that order,
   then test the rendered list is ["1/1: New year"; "3/14: Pi"].
   Example form: [let render entries = Map.bindings entries |> List.map (fun (k, v) -> Printf.sprintf "%d=%s" k v)]
   Build and run before continuing. *)

(* Task 3 — Transform map values.
   Define [Char_map = Map.Make (Char)]. Define [annotate map] so each binding
   [c -> word] becomes [c -> "c is for word"] using a Map operation rather than
   converting to a list.

   Test a→apple and z→zebra, and test an empty map.
   Example form: [let lengths map = Word_map.map String.length map]
   Build and run before continuing. *)

(* Task 4 — Find the next date.
   Define [first_after calendar date] to return the event at the least key
   strictly greater than [date], or [None] if none exists. Use a documented Map
   operation; do not call [bindings].

   In the calendar from Task 2, test a date before January 1, January 1 itself,
   and March 14.
   Example form: [match Int_map.find_first_opt (fun key -> key > cutoff) map with None -> None | Some (_, value) -> Some value]
   Build and run before continuing. *)

(* Task 5 — Build a case-insensitive set.
   Define module [Case_insensitive] with [type t = string] and [compare] based on
   [String.lowercase_ascii]. Define [Ci_set = Set.Make (Case_insensitive)].

   Test that ["grr"] and ["GRR"] are one element, while ["Argh"] is distinct;
   the cardinality must be 2.
   Example form: [module Length_set = Set.Make (Length_order)]
   Build and run before continuing. *)

(* Task 6 — Merge calendars with conflicts.
   Define [merge_error = Conflict of date * string * string]. Define
   [merge_calendars a b] to return [Ok merged] when no date occurs in both maps.
   On the earliest shared date, return [Error (Conflict (date, event_a, event_b))].

   Test merging with an empty map, two disjoint one-event maps, and two maps that
   assign different events to January 1.
   Example form: [Map.merge (fun _ left right -> match left with Some _ -> left | None -> right) first second]
   Build and run before continuing. *)

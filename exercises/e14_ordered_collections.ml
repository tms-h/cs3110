(** E14 — Ordered collections and documentation reading (35-50 min)

    OUTCOME

    - Generate domain-specific maps and sets from comparator modules.
    - Discover operations from signatures instead of reimplementing them.

    STEP 1 — DEFINE DATE IDENTITY AND ORDER

    - Read the comparator law required by [Map.Make].
    - Implement total chronological [Date_order.compare].
    - Assume dates are valid; still test equality and both order directions.

    STEP 2 — BUILD AND RENDER A CALENDAR

    - Create several [Date_map] bindings in nonchronological insertion order.
    - Implement [render_calendar].
    - Check that the result order follows keys, not insertion history.

    STEP 3 — FIND THE MAP OPERATIONS

    - Use https://ocaml.org/manual/5.4/api/Map.S.html.
    - Find the operation that changes every value without changing keys.
    - Use it for [annotate]; do not write a fold.
    - Find the operation for the first key strictly after a supplied key.
    - Implement [first_after] without converting the map to a list.

    STEP 4 — DEFINE SET IDENTITY

    - Use https://ocaml.org/manual/5.4/api/Set.S.html.
    - Implement a case-insensitive string comparator.
    - Explain why clients must not depend on which spelling is retained.

    STEP 5 — TRANSFER AND FINISH

    - Implement [merge_calendars]. Report conflicts instead of overwriting.
    - Run [opam exec -- dune exec exercises/e14_ordered_collections.exe].

    Source coverage: date order; calendar; print calendar; is for; first after; sets. *)

type date = { month : int; day : int }

module Date_order = struct
  type t = date

  let compare (_a : t) (_b : t) : int = failwith "TODO"
end

module Date_map = Map.Make (Date_order)

type calendar = string Date_map.t

let render_calendar (_calendar : calendar) : string list = failwith "TODO"

module Char_map = Map.Make (Char)

let annotate (_m : string Char_map.t) : string Char_map.t =
  failwith "TODO: discover a Map.S function"

let first_after (_calendar : calendar) (_date : date) : string option =
  failwith "TODO: no bindings/list conversion"

module Case_insensitive = struct
  type t = string

  let compare (_a : t) (_b : t) : int = failwith "TODO"
end

module Ci_set = Set.Make (Case_insensitive)

type merge_error = Conflict of date * string * string

let merge_calendars (_a : calendar) (_b : calendar) : (calendar, merge_error) result =
  failwith "TODO: transfer"

let () =
  let jan1 = { month = 1; day = 1 } and mar14 = { month = 3; day = 14 } in
  let cal = Date_map.empty |> Date_map.add mar14 "Pi" |> Date_map.add jan1 "New year" in
  assert (render_calendar cal = [ "1/1: New year"; "3/14: Pi" ]);
  let words = Char_map.empty |> Char_map.add 'a' "apple" |> annotate in
  assert (Char_map.find 'a' words = "a is for apple");
  assert (first_after cal jan1 = Some "Pi" && first_after cal mar14 = None);
  assert (Ci_set.cardinal (Ci_set.of_list [ "grr"; "GRR"; "Argh" ]) = 2);
  assert (merge_calendars cal Date_map.empty = Ok cal);
  print_endline "E14 complete"

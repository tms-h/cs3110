(** E05 — Records, options, and comparison (30-45 min)

    OUTCOME

    - Model structured data explicitly and make absence visible in types.
    - Centralize comparison logic so selection functions cannot drift.

    STEP 1 — COMPLETE THE SMALL DATA APIS

    - Implement [make_student] and [name].
    - Implement [safe_head] and [safe_tail] by matching.
    - Do not catch exceptions from [List.hd] or [List.tl].

    STEP 2 — SELECT WITHOUT LOSING THE EMPTY CASE

    - Implement [highest_impact].
    - Return the leftmost ticket when impacts tie.
    - Use the return type to force callers to handle an empty list.

    STEP 3 — DEFINE DATE ORDER ONCE

    - Implement lexicographic [is_before] for valid dates.
    - Do not approximate a date as a count of days.
    - Implement [earliest] using [is_before]; do not sort the whole list.
    - Record the time and auxiliary-space complexity.

    STEP 4 — BUILD A SHADOWING ENVIRONMENT

    - Read https://ocaml.org/manual/5.4/api/Option.html if needed.
    - Implement [lookup] so the newest binding is visible.
    - Preserve older bindings as history.
    - State the invariant a unique-key representation would need instead.

    FINISH

    - Run [opam exec -- dune exec exercises/e05_records_options_and_dates.exe].

    Source coverage: student; pokerecord; safe hd and tl; pokefun; date before; earliest
    date; assoc list. *)

type student = { first_name : string; last_name : string; gpa : float }

let make_student (_first : string) (_last : string) (_gpa : float) : student =
  failwith "TODO"

let name (_s : student) : string * string = failwith "TODO"

type priority = Low | Normal | High
type ticket = { title : string; impact : int; priority : priority }

let safe_head (_xs : 'a list) : 'a option = failwith "TODO"
let safe_tail (_xs : 'a list) : 'a list option = failwith "TODO"
let highest_impact (_tickets : ticket list) : ticket option = failwith "TODO"

type date = int * int * int

let is_before (_a : date) (_b : date) : bool = failwith "TODO"
let earliest (_dates : date list) : date option = failwith "TODO"
let insert key value bindings = (key, value) :: bindings
let rec lookup (_key : 'k) (_bindings : ('k * 'v) list) : 'v option = failwith "TODO"

let () =
  let ada = make_student "Ada" "Lovelace" 4.0 in
  assert (name ada = ("Ada", "Lovelace"));
  assert (safe_head [] = None && safe_tail [ 1 ] = Some []);
  let a = { title = "a"; impact = 7; priority = Low } in
  let b = { title = "b"; impact = 7; priority = High } in
  assert (highest_impact [ a; b ] = Some a);
  assert (is_before (2025, 12, 31) (2026, 1, 1));
  assert (earliest [ (2026, 3, 2); (2025, 12, 31); (2026, 1, 1) ] = Some (2025, 12, 31));
  let env = [] |> insert "x" 1 |> insert "y" 2 |> insert "x" 3 in
  assert (lookup "x" env = Some 3 && lookup "z" env = None);
  print_endline "E05 complete"

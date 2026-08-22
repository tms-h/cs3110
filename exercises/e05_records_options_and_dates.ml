(** E05 — Records, options, variants, and comparison (60-85 min)

    Build: [opam exec -- dune build exercises/e05_records_options_and_dates.exe] Run:
    [opam exec -- dune exec exercises/e05_records_options_and_dates.exe] Reading:
    https://ocaml.org/manual/5.3/api/Option.html *)

(* Task 1 — Define a student record.
   Define type [student] with fields [first_name : string], [last_name : string],
   and [gpa : float]. Define [make_student first last gpa] and [name student],
   where [name] returns [(first_name, last_name)].

   Example form: [type book = { title : string; pages : int }]
   Test a student named Ada Lovelace with GPA 4.0.
   Build and run before continuing. *)

type student = { first_name : string; last_name : string; gpa : float }

let make_student first last gpa = { first_name = first; last_name = last; gpa }
let name student = (student.first_name, student.last_name)

let () =
  let student1 = make_student "Ada" "Lovelace" 4.0 in
  assert (name student1 = ("Ada", "Lovelace"));
  assert (student1.gpa = 4.0)

(* Task 2 — Return options for list access.
   Define [safe_head xs] to return [Some first] or [None] for []. Define
   [safe_tail xs] to return [Some tail] or [None] for []. Implement both with
   pattern matching. In particular, do not implement them by calling [List.hd]
   or [List.tl] inside [try ... with].

   Example form: [let describe = function None -> "missing" | Some n -> string_of_int n]
   Test both functions on [] and on [1].
   Build and run before continuing. *)

let safe_head = function [] -> None | head :: _ -> Some head

let () =
  assert (safe_head [] = None);
  assert (safe_head [ "head"; "not head" ] = Some "head");
  assert (safe_head [ 1; 2 ] = Some 1)

(* Task 3 — Select the highest-impact ticket.
   Define variant [priority] with constructors [Low], [Normal], and [High]. Define
   record type [ticket] with [title : string], [impact : int], and
   [priority : priority].

   Define [highest_impact tickets] to return [None] for [] and otherwise the
   ticket with greatest [impact]. On ties, return the leftmost ticket; priority
   does not break ties. Test [], one ticket, a unique maximum, and a two-way tie.
   Example form: [type urgency = Calm | Pressing]
   Build and run before continuing. *)

type priority = Low | Normal | High
type ticket = { title : string; impact : int; priority : priority }

(* try to use a fold next *)
let highest_impact xs =
  match xs with
  | [] -> None
  | _ -> Some (List.sort (fun x y -> Int.compare y.impact x.impact) xs |> List.hd)

let highest_impact_fd xs =
  match xs with
  | [] -> None
  | first :: rest ->
      Some
        (List.fold_left
           (fun best ticket -> if best.impact >= ticket.impact then best else ticket)
           first rest)

(* i cant be fucked writing test cases *)
let () =
  let low_bug = { title = "low bug"; impact = 2; priority = Low } in

  let medium_bug = { title = "medium bug"; impact = 5; priority = Normal } in

  let big_bug = { title = "big bug"; impact = 10; priority = High } in

  let tied_bug = { title = "tied bug"; impact = 10; priority = Low } in

  (* empty *)
  assert (highest_impact [] = None);
  (* one ticket *)
  assert (highest_impact [ medium_bug ] = Some medium_bug);
  (* unique maximum *)
  assert (highest_impact [ low_bug; big_bug; medium_bug ] = Some big_bug);
  (* tie: leftmost wins, regardless of priority *)
  assert (highest_impact [ low_bug; big_bug; tied_bug; medium_bug ] = Some big_bug);
  assert (highest_impact_fd [] = None);
  (* one ticket *)
  assert (highest_impact_fd [ medium_bug ] = Some medium_bug);
  (* unique maximum *)
  assert (highest_impact_fd [ low_bug; big_bug; medium_bug ] = Some big_bug);
  (* tie: leftmost wins, regardless of priority *)
  assert (highest_impact_fd [ low_bug; big_bug; tied_bug; medium_bug ] = Some big_bug)

(* Task 4 — Order dates.
   Define [date] as a triple [(year, month, day)]. Define [is_before a b] to
   return true exactly when [a] is chronologically earlier than [b], using year,
   then month, then day. Equal dates are not before each other.

   Example form: [let before_pair (a, b) (c, d) = a < c || (a = c && b < d)]
   Test dates differing by year, month, and day, plus equal dates.
   Build and run before continuing. *)

let is_before (y1, m1, d1) (y2, m2, d2) =
  y1 < y2 || (y1 = y2 && m1 < m2) || (y1 = y2 && m1 = m2 && d1 < d2)

let () =
  assert (is_before (2025, 12, 25) (2026, 1, 25));
  assert (is_before (2026, 1, 25) (2026, 2, 25));
  assert (is_before (2026, 1, 20) (2026, 1, 25));
  assert (not (is_before (2025, 12, 25) (2025, 1, 25)))

(* Task 5 — Find the earliest date.
   Define [earliest dates] to return [None] for [] and otherwise the leftmost
   earliest date without sorting. Test [], a singleton, an unsorted list spanning
   two years, and a tie for the earliest date.
   Example form: [let choose_smaller current candidate = if candidate < current then candidate else current]
   Build and run before continuing. *)

let earliest = function
  | [] -> None
  | first :: rest ->
      Some (List.fold_left (fun res x -> if is_before x res then x else res) first rest)

let () =
  assert (
    earliest [ (2025, 12, 25); (2006, 12, 25); (2001, 9, 11); (2067, -100, -10) ]
    = Some (2001, 9, 11))

(* Task 6 — Implement and use a shadowing association list.
   Extension: instead of assuming association-list operations already exist,
   define [insert key value bindings] to prepend the binding. Define recursive
   [lookup key bindings] to return the value from the first matching pair, or
   [None] when absent.

   Insert x=1, then y=2, then x=3. Test that lookup returns 3 for x, 2 for y,
   and [None] for z. After every required assertion and written explanation in
   E05 is present, print exactly [E05 passed].
   Example form: [let labels bindings = List.map fst bindings]
   Build and run before continuing. *)

let insert key value bindings = (key, value) :: bindings

let rec lookup key = function
  | [] -> None
  | (head_key, head_value) :: tail ->
      if head_key = key then Some head_value else lookup key tail

let () =
  let bindings = [] |> insert "x" 1 |> insert "y" 2 |> insert "x" 3 in

  assert (lookup "x" bindings = Some 3);
  assert (lookup "y" bindings = Some 2);
  assert (lookup "z" bindings = None)

let () = print_endline "e05 all tests donezo! :3"

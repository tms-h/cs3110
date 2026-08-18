(** E05 — Records, options, and comparison (60-85 min)

    Build: [opam exec -- dune build exercises/e05_records_options_and_dates.exe] Run:
    [opam exec -- dune exec exercises/e05_records_options_and_dates.exe] Reading:
    https://ocaml.org/manual/5.4/api/Option.html *)

(* Task 1 — Define a student record.
   Define type [student] with fields [first_name : string], [last_name : string],
   and [gpa : float]. Define [make_student first last gpa] and [name student],
   where [name] returns [(first_name, last_name)].

   Example form: [type book = { title : string; pages : int }]
   Test a student named Ada Lovelace with GPA 4.0.
   Build and run before continuing. *)

(* Task 2 — Return options for list access.
   Define [safe_head xs] to return [Some first] or [None] for []. Define
   [safe_tail xs] to return [Some tail] or [None] for []. Do not catch exceptions
   from [List.hd] or [List.tl].

   Example form: [let describe = function None -> "missing" | Some n -> string_of_int n]
   Test both functions on [] and on [1].
   Build and run before continuing. *)

(* Task 3 — Select the highest-impact ticket.
   Define variant [priority] with constructors [Low], [Normal], and [High]. Define
   record type [ticket] with [title : string], [impact : int], and
   [priority : priority].

   Define [highest_impact tickets] to return [None] for [] and otherwise the
   ticket with greatest [impact]. On ties, return the leftmost ticket; priority
   does not break ties. Test [], one ticket, a unique maximum, and a two-way tie.
   Example form: [type urgency = Calm | Pressing]
   Build and run before continuing. *)

(* Task 4 — Order dates.
   Define [date] as a triple [(year, month, day)]. Define [is_before a b] to
   return true exactly when [a] is chronologically earlier than [b], using year,
   then month, then day. Equal dates are not before each other.

   Example form: [let before_pair (a, b) (c, d) = a < c || (a = c && b < d)]
   Test dates differing by year, month, and day, plus equal dates.
   Build and run before continuing. *)

(* Task 5 — Find the earliest date.
   Define [earliest dates] to return [None] for [] and otherwise the leftmost
   earliest date without sorting. Test [], a singleton, an unsorted list spanning
   two years, and a tie for the earliest date.
   Example form: [let choose_smaller current candidate = if candidate < current then candidate else current]
   Build and run before continuing. *)

(* Task 6 — Implement a shadowing association list.
   Define [insert key value bindings] to prepend the binding. Define recursive
   [lookup key bindings] to return the value from the first matching pair, or
   [None] when absent.

   Insert x=1, then y=2, then x=3. Test that lookup returns 3 for x, 2 for y,
   and [None] for z.
   Example form: [let labels bindings = List.map fst bindings]
   Build and run before continuing. *)

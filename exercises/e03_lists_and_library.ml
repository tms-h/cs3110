(** E03 — Lists, patterns, and the List module (60-85 min)

    Build: [opam exec -- dune build exercises/e03_lists_and_library.exe] Run:
    [opam exec -- dune exec exercises/e03_lists_and_library.exe] Reading:
    https://ocaml.org/manual/5.4/api/List.html *)

(* Task 1 — Construct lists.
   Define [one_to_five_a] as [1; 2; 3; 4; 5] with bracket syntax. Define
   [one_to_five_b] using only [::] and [[]]. Define [one_to_five_c] using [@]
   and the sublist [2; 3; 4]. Test that all three values are equal.
   Build and run before continuing. *)

(* Task 2 — Recurse over lists.
   Define recursive [product xs] with [product [] = 1] and
   [product (x :: xs) = x * product xs]. Define recursive [concat xs] with
   [concat [] = ""] and string concatenation in list order.

   Test [product []], [product [2; 3; 4]], [concat []], and
   [concat ["OC"; "aml"]].
   Build and run before continuing. *)

(* Task 3 — Match list shapes.
   Define [starts_with_bigred xs] to return true exactly when the first two
   elements are ["big"] and ["red"]. Define [length_is_two_or_four xs] to
   return true exactly for lengths 2 and 4. Define [first_two_equal xs] to return
   true exactly when at least two elements exist and the first two are equal.

   Test each true case and the nearest shorter false case. Also test
   [first_two_equal [1; 1; 2]] and [first_two_equal [1; 2; 1]].
   Build and run before continuing. *)

(* Task 4 — Select the fifth element safely.
   Define [fifth_or_zero xs] with [List.nth_opt]. Return the fifth element when
   it exists and zero otherwise. Test lists of lengths 4 and 5.
   Build and run before continuing. *)

(* Task 5 — Sort descending.
   Define [descending xs] with [List.sort]. Preserve duplicates and order values
   from greatest to least. Test [] and [2; 1; 3; 2].
   Build and run before continuing. *)

(* Task 6 — Use an exception-raising library operation.
   Define [last_exn xs] without pattern matching. Return the final element and
   let the chosen List operation's documented exception escape for []. Test a
   singleton, a longer list, and the exact empty-list exception.
   Build and run before continuing. *)

(* Task 7 — Search with a predicate.
   Define [any_zero xs] with one List-library call and no explicit recursion.
   Return true exactly when an element equals zero. Test [], [1; 0; 2], and
   [1; 2; 3].
   Build and run before continuing. *)

(** E09 — Folds and pipelines (95-130 min)

    Build: [opam exec -- dune build exercises/e09_folds_pipelines_and_refactors.exe]
    Run: [opam exec -- dune exec exercises/e09_folds_pipelines_and_refactors.exe]
    Reading: https://ocaml.org/manual/5.3/api/List.html *)

(* Task 1 — Multiply with both folds.
   Define [product_left xs] with [List.fold_left] and [product_right xs] with
   [List.fold_right]. Both return the floating-point product and use 1.0 for [].

   Test [] and [2.0; 3.0; 4.0] with both functions.
   Example form: [let sum_left xs = List.fold_left ( + ) 0 xs]
   Build and run before continuing. *)

(* Task 2 — Make both products terse.
   Define [product_left_terse] in one line by partially applying [List.fold_left];
   do not explicitly name the input list and do not use [fun].

   Define [product_right_terse xs] in one line with [List.fold_right], again
   without [fun]. Test that both terse functions agree with Task 1 on [] and
   [2.0; 3.0; 4.0].
   Example form: [let sum = List.fold_left ( + ) 0]
   Build and run before continuing. *)

(* Task 3 — Build a map-filter-fold pipeline.
   Define [sum_cube_odd n] for [n >= 0] as the sum of [x³] for odd integers
   [x] from 0 through [n] inclusive. Use List initialization, filter, map, and
   fold; define no recursive helper. Raise [Invalid_argument] for [n < 0].

   Define [sum_cube_odd_pipe n] with the same computation written using [|>].
   Test 0, 1, 5, and a negative input for both functions.
   Example form: [values |> List.filter is_ready |> List.map score |> List.fold_left ( + ) 0]
   Build and run before continuing. *)

(* Task 4 — Compare existence implementations.
   Define [exists_rec p xs] recursively with short-circuiting, [exists_fold p xs]
   with a fold, and [exists_lib p xs] with [List.exists]. All return true exactly
   when some element satisfies [p].

   Test empty, present, and absent cases for all three. In a comment, explain
   which implementations can return without applying [p] to the remaining
   elements after a match. Do not use references or other side effects for this
   comparison; mutability is introduced later.
   Example form: [let any_even xs = List.exists (fun n -> n mod 2 = 0) xs]
   Build and run before continuing. *)

(* Task 5 — Process debits in order.
   Define [balance_rec initial debits], [balance_left initial debits], and
   [balance_right initial debits]. Each must compute
   [initial - d1 - d2 - ... - dn] in list order, using recursion,
   [List.fold_left], and [List.fold_right] respectively.

   Test initial 100 with [] and with [10; 5; 12].
   Example form: [let sentence words = List.fold_left (fun text word -> text ^ " " ^ word) "" words]
   Build and run before continuing. *)

(* Task 6 — Choose map or filter.
   Define [long_strings xs] to keep strings whose length is greater than 3,
   preserving order. Define [increment_floats xs] to add 1.0 to every element.

   Test [long_strings ["one"; "three"; "seven"]], [], and
   [increment_floats [0.0; 2.5]].
   Example form: [let evens xs = List.filter (fun n -> n mod 2 = 0) xs]
   Build and run before continuing. *)

(* Task 7 — Join strings with a fold.
   Define [join sep xs] with [List.fold_left] or [List.fold_right]. Concatenate
   elements with exactly one [sep] between adjacent elements and none at either
   end. Return "" for [] and return the sole string unchanged for a singleton.

   Test [], a singleton, and [join "," ["hi"; "bye"]].
   Example form: [let combine_nonempty sep first rest = List.fold_left (fun text word -> text ^ sep ^ word) first rest]
   Build and run before continuing. *)

(* Task 8 — Extract unique keys.
   Define [unique_keys bindings] to return the distinct keys in ascending order,
   ignoring values. Use [List.sort_uniq].

   Test [] and [(2, "b"); (1, "x"); (2, "c")]. State the asymptotic time
   complexity in a comment.
   Example form: [let unique_words words = List.sort_uniq String.compare words]
   Build and run before continuing. *)

(* Task 9 — Supplemental practice: sort by length frequency.
   Inspired by 99 Problems P28. Define [length_sort xss] to sort sublists by
   increasing length while preserving their input order when lengths tie.
   Define [frequency_sort xss] to put sublists whose length occurs least often
   first. Break equal-frequency ties by shorter length, then preserve input
   order. Precompute each sublist's length and the length histogram; do not call
   [List.length] repeatedly from a sort comparator.

   Test [] and
   [[[1;2;3]; [4]; [5;6]; [7]; [8;9;10]]]. The exact [length_sort] result is
   [[[4]; [7]; [5;6]; [1;2;3]; [8;9;10]]]; the exact [frequency_sort] result is
   [[[5;6]; [4]; [7]; [1;2;3]; [8;9;10]]]. State the time complexity in terms
   of the outer-list length and total number of elements.

   After every required assertion and written explanation in E09 is present,
   print exactly [E09 passed].
   Example form: [List.stable_sort (fun (_, a) (_, b) -> Int.compare a b) tagged]
   Build and run before continuing. *)

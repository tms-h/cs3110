(** E09 — Folds and pipelines (70-100 min)

    Build: [opam exec -- dune build exercises/e09_folds_pipelines_and_refactors.exe]
    Run: [opam exec -- dune exec exercises/e09_folds_pipelines_and_refactors.exe]
    Reading: https://ocaml.org/manual/5.4/api/List.html *)

(* Task 1 — Multiply with both folds.
   Define [product_left xs] with [List.fold_left] and [product_right xs] with
   [List.fold_right]. Both return the floating-point product and use 1.0 for [].

   Test [] and [2.0; 3.0; 4.0] with both functions.
   Example form: [let sum_left xs = List.fold_left ( + ) 0 xs]
   Build and run before continuing. *)

(* Task 2 — Build a map-filter-fold pipeline.
   Define [sum_cube_odd n] for [n >= 0] as the sum of [x³] for odd integers
   [x] from 0 through [n] inclusive. Use List initialization, filter, map, and
   fold; define no recursive helper. Raise [Invalid_argument] for [n < 0].

   Define [sum_cube_odd_pipe n] with the same computation written using [|>].
   Test 0, 1, 5, and a negative input for both functions.
   Example form: [values |> List.filter is_ready |> List.map score |> List.fold_left ( + ) 0]
   Build and run before continuing. *)

(* Task 3 — Compare existence implementations.
   Define [exists_rec p xs] recursively with short-circuiting, [exists_fold p xs]
   with a fold, and [exists_lib p xs] with [List.exists]. All return true exactly
   when some element satisfies [p].

   Test empty, present, and absent cases for all three. Then use a predicate that
   increments a reference to test how many elements each version examines when
   the first element matches.
   Example form: [let seen = ref 0 in List.exists (fun x -> incr seen; x = target) values]
   Build and run before continuing. *)

(* Task 4 — Process debits in order.
   Define [balance_rec initial debits], [balance_left initial debits], and
   [balance_right initial debits]. Each must compute
   [initial - d1 - d2 - ... - dn] in list order, using recursion,
   [List.fold_left], and [List.fold_right] respectively.

   Test initial 100 with [] and with [10; 5; 12].
   Example form: [let sentence words = List.fold_left (fun text word -> text ^ " " ^ word) "" words]
   Build and run before continuing. *)

(* Task 5 — Choose map or filter.
   Define [long_strings xs] to keep strings whose length is greater than 3,
   preserving order. Define [increment_floats xs] to add 1.0 to every element.

   Test [long_strings ["one"; "three"; "seven"]], [], and
   [increment_floats [0.0; 2.5]].
   Example form: [let evens xs = List.filter (fun n -> n mod 2 = 0) xs]
   Build and run before continuing. *)

(* Task 6 — Join strings.
   Define [join sep xs] to concatenate elements with exactly one [sep] between
   adjacent elements and none at either end. Return "" for [].

   Test [], a singleton, and [join "," ["hi"; "bye"]].
   Example form: [let combine sep left right = left ^ sep ^ right]
   Build and run before continuing. *)

(* Task 7 — Extract unique keys.
   Define [unique_keys bindings] to return the distinct keys in ascending order,
   ignoring values. Use [List.sort_uniq].

   Test [] and [(2, "b"); (1, "x"); (2, "c")]. State the asymptotic time
   complexity in a comment.
   Example form: [let unique_words words = List.sort_uniq String.compare words]
   Build and run before continuing. *)

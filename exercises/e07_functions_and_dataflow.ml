(* E07 — Functions and data flow

   Five tasks replace the old composition, fold, and matrix block. The goal is
   to become fluent with higher-order control flow once, then move on. *)

(* Task 1 — Predict types before running.
   Write the types of [( |> )], [(@@)], [List.map], [List.filter],
   [List.fold_left], and [List.fold_right]. For each operator, give one small
   expression showing its evaluation order. Confirm in utop only afterward. *)

(* Task 2 — Fuse map and filter deliberately.
   Implement [filter_map : ('a -> 'b option) -> 'a list -> 'b list] without
   calling [List.filter_map]. Preserve input order. Test empty input, all
   rejected, all accepted, and a mixture. State its time and stack costs. *)

(* Task 3 — Build one readable pipeline.
   Implement [sum_positive_squares : int list -> int] by composing library
   operations with [|>]. Negative values and zero are ignored. Then write the
   equivalent single fold and say which version communicates the intent more
   clearly; do not claim that fewer traversals are automatically faster. *)

(* Task 4 — Make fold direction observable.
   Use both folds to join the strings ["a"; "b"; "c"] with ["/"] without a
   leading or trailing separator. Record why subtraction and string building
   make left-versus-right association observable. *)

(* Task 5 — Refactor instead of repeating.
   Choose one completed list function from E03 or E04. Write a library-based
   version here, test it against the original on representative inputs, and
   compare clarity, allocation, tail position, and asymptotic cost. Do not
   rewrite every earlier function.

   After all checks pass, print exactly [E07 passed] as the final output line. *)

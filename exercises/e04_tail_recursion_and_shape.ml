(** E04 — Tail recursion and list shape (75-105 min)

    Build: [opam exec -- dune build exercises/e04_tail_recursion_and_shape.exe] Run:
    [opam exec -- dune exec exercises/e04_tail_recursion_and_shape.exe] *)

(* Task 1 — Define [take] and [drop].
   Define recursive [take n xs] to return the first [n] elements, or all of [xs]
   when it is shorter. Define recursive [drop n xs] to remove the first [n]
   elements, or return [] when [xs] is shorter. Both functions must raise
   [Invalid_argument] when [n < 0].

   Example form: [let rec repeat n x = if n = 0 then [] else x :: repeat (n - 1) x]
   Test negative, zero, shorter, exact-length, and longer counts.
   Build and run before continuing. *)

(* Task 2 — Make [take] and [drop] tail-recursive.
   Define [take_tr n xs] and [drop_tr n xs] with the same contracts as Task 1.
   Write each accumulator invariant in a comment.

   Test equality with [take] and [drop] on representative inputs, then test both
   tail-recursive functions on a list of one million integers.
   Example form: [let rec loop acc = function [] -> List.rev acc | x :: xs -> loop (x :: acc) xs]
   Build and run before continuing. *)

(* Task 3 — Recognize unimodal lists.
   Define [is_unimodal xs] to return true exactly when the list is first
   nondecreasing and then nonincreasing. Either phase may be empty, and equal
   adjacent values are allowed. Use one traversal and constant auxiliary space.

   Test [], a rising list, a falling list, [1; 3; 3; 2], and [1; 3; 2; 4].
   Example form: [let rec walk phase previous rest = match phase, rest with _ -> true]
   Build and run before continuing. *)

(* Task 4 — Generate a powerset.
   Define [powerset xs] to return every sublist obtained by choosing or omitting
   each input element, with no duplicate recursive call for the tail. The result
   for [] is [[]].

   Test [] and [1; 2]. For [1; 2; 3], test that the result has length 8 and
   contains [] and [1; 2; 3]; do not require a particular subset order.
   Example form: [let with_head x tails = List.map (fun tail -> x :: tail) tails]
   Build and run before continuing. *)

(* Task 5 — Print with two traversal styles.
   Define [print_int_list xs] recursively and [print_int_list_iter xs] with
   [List.iter]. Each must print the integers in order, one per line, and print
   nothing for [].

   Factor [render_int x] to return the line text without a newline. Test
   [render_int 0] and [render_int (-3)], then call both printers on [1; 2].
   Example form: [let print_words words = List.iter print_endline words]
   Build and run before continuing. *)

(* Task 6 — Split into chunks.
   Define tail-recursive [chunks_of width xs]. Preserve element order, make each
   chunk length [width] except possibly the final chunk, return [] for [], and
   raise [Invalid_argument] when [width <= 0]. Do not call [take] or [drop].

   Test width 2 on [1; 2; 3; 4; 5], width larger than the list, [], and width 0.
   Example form: [let rec finish current groups = List.rev (List.rev current :: groups)]
   Build and run before continuing. *)

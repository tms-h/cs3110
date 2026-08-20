(** E08 — Higher-order functions and composition (55-75 min)

    Build: [opam exec -- dune build exercises/e08_function_composition.exe] Run:
    [opam exec -- dune exec exercises/e08_function_composition.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e08_function_composition.ml] *)

(* Task 1 — Define repeated application.
   Define [double x = 2 * x], [square x = x * x], and
   [twice f x = f (f x)]. Define [quad] as [twice double] and [fourth] as
   [twice square], without adding a final parameter.

   Annotate both [quad] and [fourth] with [int -> int]. Test [quad 3] and
   [fourth 2]. In a comment, explain why [quad] is a function even though its
   definition does not explicitly name the final integer argument.
   Example form: [let apply_once f x = f x]
   Build and run before continuing. *)

(* Task 2 — Investigate an application operator.
   Define [($) f x = f x]. Evaluate [(fun x -> x * x) $ 2 + 2]. Assert that it
   equals the correct one of [(fun x -> x * x) (2 + 2)] and
   [((fun x -> x * x) 2) + 2], and assert that those two explicit expressions
   have different results. Do not use [($)] after this task.
   Example form: [let ( @@? ) f x = f x]
   Build and run before continuing. *)

(* Task 3 — Investigate composition operators.
   First define [(@@) f g x = x |> g |> f], temporarily shadowing OCaml's usual
   [@@] operator. Before evaluating it, predict the result of
   [(String.length @@ string_of_int) 1], the same expression applied to 10, and
   the same expression applied to 100. Check the predictions, record the
   inferred type, and explain in a comment that the operator composes from right
   to left. Do not use this temporary [@@] definition after this task.

   Extension: define forward composition [(%>) f g x = g (f x)]. Annotate it
   with [('a -> 'b) -> ('b -> 'c) -> 'a -> 'c].

   Test composing integer increment with [string_of_int] on 9, and composing
   [String.length] with [double] on ["abc"].
   Example form: [let compose f g x = f (g x)]
   Build and run before continuing. *)

(* Task 4 — Repeat a function [n] times.
   Define [repeat f n x]. Return [x] when [n = 0], apply [f] exactly [n] times
   when [n > 0], and raise [Invalid_argument "repeat"] when [n < 0].

   Test counts 0 and 5 with doubling, and test the negative-count exception.
   Example form: [let call_if condition f x = if condition then f x else x]
   Build and run before continuing. *)

(* Task 5 — Uncurry library functions.
   Define [uncurried_append (xs, ys)], [uncurried_char_compare (a, b)], and
   [uncurried_max (a, b)] by adapting the corresponding curried functions.

   Test append on [([1; 2], [3])], character comparison on [('a', 'b')], and
   maximum on [(3, 9)] and [(9, 9)].
   Example form: [let uncurried_add (a, b) = ( + ) a b]
   Build and run before continuing. *)

(* Task 6 — Extension: partially apply sorting.
   Define [descending] by partially applying [List.sort] to an integer comparator
   that orders greater values first. Annotate [descending] with
   [int list -> int list]. Test [] and [2; 1; 3; 2].
   Example form: [let alphabetic = List.sort String.compare]
   Build and run before continuing. *)

(* Task 7 — Fuse maps.
   Define [map_fused f g xs] with exactly one [List.map], producing the same
   values as [List.map f (List.map g xs)].

   Test [map_fused string_of_int (( + ) 1) [1; 2; 3]] and compare it with the
   two-pass expression. Extension: add a comment stating that effects and
   exception timing can make the two implementations observably different.
   After every required assertion and written explanation in E08 is present,
   print exactly [E08 passed].
   Example form: [let squared xs = List.map (fun x -> x * x) xs]
   Build and run before continuing. *)

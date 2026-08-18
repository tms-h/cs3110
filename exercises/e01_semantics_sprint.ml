(** E01 — Basic expressions and functions (60-80 min)

    Build: [opam exec -- dune build exercises/e01_semantics_sprint.exe] Run:
    [opam exec -- dune exec exercises/e01_semantics_sprint.exe] Reading:
    https://ocaml.org/manual/5.4/expr.html *)

(* Task 1 — Predict expressions.
   Before compiling, record the type and result of each expression in comments:

   - [6 * 7] int = 42
   - [7.0 /. 2.0] float = 3.5
   - ["OC" ^ "aml"] string = "OCaml"
   - [if 3 < 5 then 10 else 20] int = 10
   - [(fun x -> x + 1) 4] int = 5

   Bind each result to a descriptive name and write an assertion for it.
   Example form: [(* 8 - 3 : int = 5 *)]
   Build and run before continuing. *)

let () = 
  assert(6 * 7 = 42)


(* Task 2 — Define integer functions.
   Define [double n].

   Define [sign n] to return [-1] when [n] is negative, [0] when [n] is zero,
   and [1] when [n] is positive.

   Example form: [let triple n = n * 3]
   Test [double] with zero and a negative number. Test all three cases of [sign].
   Build and run before continuing. *)

(* Task 3 — Use a polymorphic function.
   Define [identity x], then predict its inferred type in a comment.

   Example form: [let duplicate x = (x, x)]
   Call it with both an integer and a string, and assert both results.
   Build and run before continuing. *)

(* Task 4 — Calculate with floats.
   Define [approximately_equal a b] to return whether the absolute difference
   between two floats is less than [1e-9].

   Then define [cube x] using floating-point exponentiation,
   [circle_area radius] as [Float.pi * radius²], and [rms x y] as the square
   root of [(x² + y²) / 2].

   Example form: [let rectangle_area width height = width *. height]
   Test [cube 2.0], the area of a unit circle, and [rms 3.0 4.0]. Use
   [approximately_equal] wherever rounding could occur.
   Build and run before continuing. *)

(* Task 5 — Use labelled arguments and partial application.
   Define [divide ~numerator ~denominator] for floating-point division.

   Define [halve] by supplying only [denominator:2.0]. Annotate [halve] with the
   type [numerator:float -> float], then test it on [8.0].
   Example form: [let scale ~factor value = factor *. value]
   Build and run before continuing. *)

(* Task 6 — Define an infix operator.
   Define [( +/. )] to return the average [(a + b) / 2] of two floats.

   Test one average. Determine whether [2.0 +/. 4.0 +/. 8.0] groups to the left
   or right, then assert the unparenthesised expression equals the correct
   explicit grouping and differs from the other grouping.
   Example form: [let ( <+> ) a b = a + b]
   Build and run before continuing. *)

(* Task 7 — Compare equality operators.
   Construct two equal strings independently, with at least one created at
   runtime. Assert their structural equality with [(=)]. Evaluate and print
   their physical equality with [(==)], but do not assert its result.

   Add a comment explaining why [(==)] must not compare string contents. Print
   ["E01 passed"] after the checks.
   Example form: [Printf.printf "%b\n" (left == right)]
   Build and run before continuing. *)

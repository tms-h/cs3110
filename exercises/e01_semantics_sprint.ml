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

let check_int = assert (6 * 7 = 42)
let check_float = assert (7.0 /. 2.0 = 3.5)

let () =
  check_int;
  check_float

(* Task 2 — Define integer functions.
   Define [double n].

   Define [sign n] to return [-1] when [n] is negative, [0] when [n] is zero,
   and [1] when [n] is positive.

   Example form: [let triple n = n * 3]
   Test [double] with zero and a negative number. Test all three cases of [sign].
   Build and run before continuing. *)

let double n = 2 * n
let sign n = if n < 0 then -1 else if n = 0 then 0 else 1

let () =
  assert (double 6 = 12);
  assert (sign 5 = 1);
  assert (sign 0 = 0);
  assert (sign (-15) = -1);
  assert (sign (-15) |> double = -2)

(* Task 3 — Use a polymorphic function.
   Define [identity x], then predict its inferred type in a comment.

   Example form: [let duplicate x = (x, x)]
   Call it with both an integer and a string, and assert both results.
   Build and run before continuing. *)

let identity x = x
let dupe x = (x, x)

let () =
  assert (identity 5 = 5);
  assert (identity "hello" = "hello");
  assert (dupe 5 = (5, 5));
  assert (dupe "hello" = ("hello", "hello"))

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

let approx_equal a b = Float.abs (a -. b) <= 1e-9
let cube x = x ** 3.
let circle_area radius = Float.pi *. (radius ** 2.)

let () =
  assert (approx_equal 5. 5.000002 |> not);
  assert (approx_equal 5. 4.99999999999999);
  assert (approx_equal (cube 2.3) 12.167);
  assert (approx_equal (circle_area 3.) 28.274333882)

(* Task 5 — Use labelled arguments and partial application.
   Define [divide ~numerator ~denominator] for floating-point division.

   Define [halve] by supplying only [denominator:2.0]. Annotate [halve] with the
   type [numerator:float -> float], then test it on [8.0].
   Example form: [let scale ~factor value = factor *. value]
   Build and run before continuing. *)

let divide ~numerator ~denominator = numerator /. denominator
let halve : numerator:float -> float = divide ~denominator:2.0

let () =
  assert (approx_equal (divide ~numerator:5. ~denominator:7.) 0.7142857143);
  assert (approx_equal (halve ~numerator:7.5) 3.75)

(* Task 6 — Define an infix operator.
   Define [( +/. )] to return the average [(a + b) / 2] of two floats.

   Test one average. Determine whether [2.0 +/. 4.0 +/. 8.0] groups to the left
   or right, then assert the unparenthesised expression equals the correct
   explicit grouping and differs from the other grouping.
   Example form: [let ( <+> ) a b = a + b]
   Build and run before continuing. *)

let ( +/. ) a b = (a +. b) /. 2.
let ( =~ ) a b = approx_equal a b

let () =
  assert (1. +/. 11. =~ 6.);

  let no_parens = 1. +/. 6. +/. 11. in
  let left_parens = 1. +/. 6. +/. 11. in
  let right_parens = 1. +/. (6. +/. 11.) in
  assert (no_parens =~ left_parens);
  (* This is evaluated left -> right (postfix) *)
  assert (not (no_parens =~ right_parens));

  (* This is evaluated left -> right (postfix) *)
  assert (5.5 =~ 5.50000000000001)

(* Task 7 — Compare equality operators.
   Construct two equal strings independently, with at least one created at
   runtime. Assert their structural equality with [(=)]. Evaluate and print
   their physical equality with [(==)], but do not assert its result.

   Add a comment explaining why [(==)] must not compare string contents. Print
   ["E01 passed"] after the checks.
   Example form: [Printf.printf "%b\n" (left == right)]
   Build and run before continuing. *)

let s1 = "hello ocaml"
let s2 = Bytes.to_string (Bytes.of_string "hello ocaml")

let () =
  assert (s1 = s2);
  print_endline ("s1 == s2: " ^ string_of_bool (s1 == s2))

let () = print_endline "eo1 passed/done! :)"

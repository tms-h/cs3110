(** E02 — Recursive functions (65-90 min)

    Build: [opam exec -- dune build exercises/e02_recursion_under_pressure.exe] Run:
    [opam exec -- dune exec exercises/e02_recursion_under_pressure.exe] Reading:
    https://cs3110.github.io/textbook/chapters/basics/rec_functions.html *)

(* Task 1 — Validate dates.
   Define [days_in_month month] for lowercase English month names. Return
   [Some 31] for January, March, May, July, August, October, and December;
   [Some 30] for April, June, September, and November; [Some 28] for February;
   and [None] for any other string.

   Define [valid_date day month] to return true exactly when the month is known
   and [day] is between 1 and that month's length inclusive. Test January 31,
   February 29, day zero, and an unknown month.
   Example form: [let season name = match name with "June" -> Some `Winter | _ -> None]
   Build and run before continuing. *)

let days_in_month month = 
  match month with
  | "january" | "march" | "may" | "july"
  | "august" | "october" | "december" -> Some 31
  | "april" | "june" | "september" | "november" -> Some 30
  | "february" -> Some 28
  | _ -> None

let valid_date day month = 
  match days_in_month month with
  | Some max_day -> day >= 1 && day <= max_day
  | None -> false

let () =
  assert (days_in_month "march" = Some 31);
  assert (not (valid_date 100 "june"));
  assert (valid_date 29 "march");
  assert (not (valid_date 29 "february"))

(* Task 2 — Define Fibonacci directly.
   Define recursive [fib n] for [n >= 1] with [fib 1 = 1], [fib 2 = 1], and
   [fib n = fib (n - 1) + fib (n - 2)]. Raise [Invalid_argument "fib"] when
   [n < 1]. Test inputs 1, 2, 6, and 0.
   Example form: [let rec factorial n = if n = 0 then 1 else n * factorial (n - 1)]
   Build and run before continuing. *)

let rec fib n =
  if (n < 1) then invalid_arg "bad fib"
  else if (n <= 2) then 1
  else fib (n - 1) + fib (n - 2)


let () =
  assert (fib 10 = 55)

(* Task 3 — Define tail-recursive Fibonacci.
   Define [fib_fast n] with the same contract as [fib]. Use a tail-recursive
   helper whose two accumulators hold consecutive Fibonacci numbers. Write the
   accumulator invariant in a comment.

   Test [fib_fast 1], [fib_fast 10], the invalid input 0, and equality with
   [fib] for every input from 1 through 20.
   Example form: [let rec loop remaining acc = if remaining = 0 then acc else loop (remaining - 1) (acc + 2)]
   Build and run before continuing. *)

let fib_fast n =
  let rec loop remaining current next =
    if remaining = 0 then current
    else loop (remaining - 1) next (current + next)
  in
  if n < 0 then invalid_arg "fib: negative input"
  else loop n 0 1

let fact n = 
  let rec loop acc n =
    if n = 0 then acc
    else loop (acc * n) (n - 1)
  in
  if n < 0 then invalid_arg "negative fact"
  else loop 1 n

let () =
  assert (fib_fast 10 = 55);
  assert (fact 5 = 120)

(* Task 4 — Find integer overflow.
   Define [first_nonpositive_fib ()] to return the smallest [n >= 1] for which
   [fib_fast n <= 0] because machine-integer arithmetic has overflowed.

   Let [n] be the returned index. Test that [n > 2], [fib_fast n <= 0], and
   [fib_fast (n - 1) > 0]. Do not assert a platform-specific index.
   Example form: [let rec first_even n = if n mod 2 = 0 then n else first_even (n + 1)]
   Build and run before continuing. *)

let first_nonpositive_fib () =
  let rec loop n =
    if fib_fast n <= 0 then n
    else loop (n + 1)
  in
  loop 1

let () =
  let n = first_nonpositive_fib () in
  assert (n > 2);
  assert (fib_fast n <= 0);
  assert (fib_fast (n - 1) > 0)

(* Task 5 — Debug recursive state.
   Define [fib_buggy n] with a helper [loop remaining previous current] that
   starts at [loop n 0 1], returns [previous] when [remaining = 1], and otherwise
   recurs with [remaining - 1], [current], and [previous + current].

   Find the smallest positive input on which it differs from [fib]. Record the
   bad state transition in a comment. Define [fib_repaired n] independently and
   test the counterexample plus inputs 1 through 20.
   Example form: [let observed = flawed 4 in assert (observed <> reference 4)]
   Build and run before continuing. *)

let fib_buggy n =
  let rec loop remaining previous current =
    if remaining = 1 then previous
    else loop (remaining - 1) current (previous + current)
  in
  loop n 0 1

let first_fib_diff () = 
  let rec loop n =
    if (fib_buggy n <> fib_fast n) then n
    else loop (n+1)
  in
  loop 1

let fib_repaired n =
  let rec loop remaining previous current =
    if remaining = 1 then previous
    else loop (remaining - 1) current (previous + current)
  in
  loop n 1 1

let () =
  assert (fib_buggy 1 = 0);
  assert (fib_buggy 1 <> fib_fast 1);
  assert (first_fib_diff () = 1);

  for n = 1 to 20 do
    assert (fib_repaired n = fib n && fib n = fib_fast n)
  done

let () =
  print_endline "all tests passed :)"

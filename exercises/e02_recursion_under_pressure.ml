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
   Build and run before continuing. *)

(* Task 2 — Define Fibonacci directly.
   Define recursive [fib n] for [n >= 1] with [fib 1 = 1], [fib 2 = 1], and
   [fib n = fib (n - 1) + fib (n - 2)]. Raise [Invalid_argument "fib"] when
   [n < 1]. Test inputs 1, 2, 6, and 0.
   Build and run before continuing. *)

(* Task 3 — Define tail-recursive Fibonacci.
   Define [fib_fast n] with the same contract as [fib]. Use a tail-recursive
   helper whose two accumulators hold consecutive Fibonacci numbers. Write the
   accumulator invariant in a comment.

   Test [fib_fast 1], [fib_fast 10], the invalid input 0, and equality with
   [fib] for every input from 1 through 20.
   Build and run before continuing. *)

(* Task 4 — Find integer overflow.
   Define [first_nonpositive_fib ()] to return the smallest [n >= 1] for which
   [fib_fast n <= 0] because machine-integer arithmetic has overflowed.

   Let [n] be the returned index. Test that [n > 2], [fib_fast n <= 0], and
   [fib_fast (n - 1) > 0]. Do not assert a platform-specific index.
   Build and run before continuing. *)

(* Task 5 — Debug recursive state.
   Define [fib_buggy n] with a helper [loop remaining previous current] that
   starts at [loop n 0 1], returns [previous] when [remaining = 1], and otherwise
   recurs with [remaining - 1], [current], and [previous + current].

   Find the smallest positive input on which it differs from [fib]. Record the
   bad state transition in a comment. Define [fib_repaired n] independently and
   test the counterexample plus inputs 1 through 20.
   Build and run before continuing. *)

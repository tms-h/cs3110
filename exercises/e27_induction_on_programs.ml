(** E27 — Induction on recursive programs (90-125 min)

    Build: [opam exec -- dune build exercises/e27_induction_on_programs.exe] Run:
    [opam exec -- dune exec exercises/e27_induction_on_programs.exe] Reading:
    https://cs3110.github.io/textbook/chapters/correctness/proving_correctness.html *)

(* Task 1 — Define and prove exponent addition.
   Define recursive [pow x n] for [n >= 0] with [pow x 0 = 1] and
   [pow x n = x * pow x (n - 1)]. Raise [Invalid_argument "pow"] for [n < 0].

   In comments, prove [pow x (m+n) = pow x m * pow x n] by induction on [m].
   Test the equation for x from -3 through 3 and m,n from 0 through 8.
   Build and run before continuing. *)

(* Task 2 — Define iterative Fibonacci and its invariant.
   Define [fib_iter n] with [fib_iter 0 = 0], [fib_iter 1 = 1], and the usual
   Fibonacci recurrence. Raise [Invalid_argument "fib"] for [n < 0]. Use a
   tail-recursive helper and state a strengthened invariant relating both
   accumulators to consecutive Fibonacci numbers.

   Define a direct reference function and test equality for n from 0 through 30.
   Build and run before continuing. *)

(* Task 3 — Define exponentiation by squaring.
   Define [pow_square x n] for [n >= 0]. For even [n > 0], compute
   [pow_square x (n/2)] once and square it. For odd [n], compute
   [x * pow_square x (n-1)]. Raise [Invalid_argument "pow_square"] for negative n.

   Prove equivalence with [pow] by strong induction. Test x from -4 through 4
   and n from 0 through 12.
   Build and run before continuing. *)

(* Task 4 — Remove the exponent-one special case.
   Define [pow_square_short x n] with base case only [n = 0]; for positive n,
   use parity and division by 2 without a separate [n = 1] branch. Keep the same
   invalid-input behavior as [pow_square].

   Record why the proof still covers n=1. Test equality with [pow] over the same
   bounded range and test the negative exception.
   Build and run before continuing. *)

(* Task 5 — Induct over Peano naturals.
   Define [nat = Z | S of nat]. Define [plus a b] recursively on [a]. Define
   [mul a b] recursively on [a] with [mul Z b = Z] and
   [mul (S a) b = plus b (mul a b)].

   Prove [mul n Z = Z] by structural induction. Test 0*3, 2*3, and 3*0 using
   explicit Peano values.
   Build and run before continuing. *)

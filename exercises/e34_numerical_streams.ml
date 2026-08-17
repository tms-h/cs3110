(** E34 — Numerical streams and convergence (100-140 min)

    Build: [opam exec -- dune build exercises/e34_numerical_streams.exe] Run:
    [opam exec -- dune exec exercises/e34_numerical_streams.exe] *)

(* Task 1 — Define a minimal stream toolkit.
   Define ['a sequence = Cons of 'a * (unit -> 'a sequence)], [head], [tail],
   [naturals_from n], and [take n sequence], with [take] returning [] for
   [n <= 0].

   Test the first five naturals from 3 and test [take 0].
   Build and run before continuing. *)

(* Task 2 — Generate primes by sifting.
   Define [filter], then [sift prime sequence] to remove values divisible by
   [prime]. Define [primes] starting at 2: emit the current head, then sift its
   multiples from the remaining candidates recursively.

   Test the first ten primes are [2;3;5;7;11;13;17;19;23;29]. Explain how keeping
   references to old stream heads can retain already processed data.
   Build and run before continuing. *)

(* Task 3 — Generate naive exponential terms.
   Define [e_terms_naive x] whose zero-based term n is [x^n / n!], calculating
   numerator and factorial separately. Define [running_total sequence] whose
   term n is the sum of source terms 0 through n.

   Test the first five terms for x=1 are [1; 1; 1/2; 1/6; 1/24] approximately,
   and test the corresponding running totals.
   Build and run before continuing. *)

(* Task 4 — Stop on absolute convergence.
   Define [within_absolute epsilon sequence] to return the second of the first
   adjacent pair [a,b] satisfying [abs (a-b) < epsilon]. Raise
   [Invalid_argument "epsilon"] when [epsilon <= 0].

   Apply it to running totals of [e_terms_naive 1.0] with epsilon 1e-8 and test
   the result is within 1e-7 of [Float.exp 1.0]. Test invalid epsilon.
   Build and run before continuing. *)

(* Task 5 — Generate exponential terms recurrently.
   Define [e_terms_recurrent x] with first term 1.0 and recurrence
   [term_(n+1) = term_n * x / (n+1)]. Do not compute a power or factorial.

   Test its first ten terms approximately match [e_terms_naive] for x=2. Compare
   both running-total approximations for a large positive and negative x, and
   record one input where the naive intermediate values degrade.
   Build and run before continuing. *)

(* Task 6 — Define mixed closeness.
   Define [close_mixed ~epsilon a b] as
   [abs (a-b) <= epsilon * max 1.0 (max (abs a) (abs b))]. Return false when
   [epsilon < 0].

   Test equal values, values near zero, large nearby values, opposite signs, and
   negative epsilon.
   Build and run before continuing. *)

(* Task 7 — Bound exponential approximation.
   Define [convergence_error = Invalid_epsilon | Did_not_converge of float].
   Define [approximate_exp ~max_iterations ~epsilon x] using recurrent terms,
   running totals, and [close_mixed]. Return [Error Invalid_epsilon] when
   [epsilon <= 0]. Check at most [max_iterations] adjacent pairs; if none is
   close, return [Error (Did_not_converge last_total)].

   Test x=2, epsilon 1e-10, and 1,000 iterations succeeds within 1e-8 of
   [Float.exp 2.0]. Test invalid epsilon, and test zero iterations returns
   [Error (Did_not_converge 1.0)].
   Build and run before continuing. *)

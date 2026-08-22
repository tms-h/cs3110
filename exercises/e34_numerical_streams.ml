(** E34 — Numerical streams, arithmetic, and convergence (190-260 min)

    Build: [opam exec -- dune build exercises/e34_numerical_streams.exe] Run:
    [opam exec -- dune exec exercises/e34_numerical_streams.exe] *)

(* Review Task 1 — Define a minimal stream toolkit.
   Define ['a sequence = Cons of 'a * (unit -> 'a sequence)], [head], [tail],
   [naturals_from n], and [take n sequence], with [take] returning [] for
   [n <= 0].

   Test the first five naturals from 3 and test [take 0].
   Example form: [let rec repeat value = Cons (value, fun () -> repeat value)]
   Build and run before continuing. *)

(* Task 2 — Generate primes by sifting.
   Define [filter], then [sift prime sequence] to remove values divisible by
   [prime]. Define [primes] starting at 2: emit the current head, then sift its
   multiples from the remaining candidates recursively.

   Test the first ten primes are [2;3;5;7;11;13;17;19;23;29]. Explain how keeping
   references to old stream heads can retain already processed data.
   Example form: [let keep_not_multiple divisor value = value mod divisor <> 0]
   Build and run before continuing. *)

(* Task 3 — Generate naive exponential terms.
   Define [e_terms_naive x] whose zero-based term n is [x^n / n!], calculating
   numerator and factorial separately. Define [running_total sequence] whose
   term n is the sum of source terms 0 through n.

   Compute numerator and factorial in floating point. Test the first five terms
   for x=1 are approximately
   [1.0; 1.0; 0.5; 1.0 /. 6.0; 1.0 /. 24.0], and test the corresponding running
   totals.
   Example form: [let rec terms n = Cons (term_for n, fun () -> terms (n + 1))]
   Build and run before continuing. *)

(* Task 4 — Stop on absolute convergence.
   Define [within_absolute epsilon sequence] to return the second of the first
   adjacent pair [a,b] satisfying [abs (a-b) < epsilon]. Raise
   [Invalid_argument "epsilon"] when [epsilon <= 0].

   Apply it to running totals of [e_terms_naive 1.0] with epsilon 1e-8 and test
   the result is within 1e-7 of [Float.exp 1.0]. Test invalid epsilon.
   Also reproduce the textbook example: for the sequence beginning
   [1.0; 2.0; 2.5; 2.75; 2.875; 2.9375; 2.96875], epsilon 0.1 selects 2.9375.

   Define [approximate_exp_naive x epsilon] by composing [e_terms_naive],
   [running_total], and [within_absolute]. Test x=1 and record its error relative
   to [Float.exp 1.0]; this baseline is needed for the improvement below.
   Example form: [let close_pair tolerance a b = Float.abs (a -. b) < tolerance]
   Build and run before continuing. *)

(* Task 5 — Generate exponential terms recurrently.
   Define [e_terms_recurrent x] with first term 1.0 and recurrence
   [term_(n+1) = term_n * x / (n+1)]. Do not compute a power or factorial.

   Test its first ten terms approximately match [e_terms_naive] for x=2. For
   x=50 and x=-50, inspect the first 220 terms from each generator. Record the
   first non-finite term, if any, the largest absolute intermediate term, and the
   final absolute and relative errors of the running total against [Float.exp x].
   Explain one concrete way the separately computed power/factorial degrades.
   Example form: [let next = current *. ratio /. float_of_int (index + 1)]
   Build and run before continuing. *)

(* Extension Task 6 — Define robust mixed closeness.
   Define [close_mixed ~epsilon a b] as
   [abs (a-b) <= epsilon * max 1.0 (max (abs a) (abs b))]. Return false when
   [epsilon < 0].

   Test equal values, values near zero, large nearby values, opposite signs, and
   negative epsilon.
   Example form: [let tolerance scale epsilon = epsilon *. max 1.0 (Float.abs scale)]
   Build and run before continuing. *)

(* Extension Task 7 — Bound exponential approximation.
   Define
   [convergence_error = Invalid_epsilon | Invalid_iterations | Did_not_converge of float].
   Define [approximate_exp ~max_iterations ~epsilon x] using recurrent terms,
   running totals, and [close_mixed]. Return [Error Invalid_epsilon] when
   [epsilon <= 0] and [Error Invalid_iterations] when [max_iterations < 0]. Check
   at most [max_iterations] adjacent pairs; if none is close, return
   [Error (Did_not_converge last_total)].

   Test x=2, epsilon 1e-10, and 1,000 iterations succeeds within 1e-8 of
   [Float.exp 2.0]. Test invalid epsilon, and test zero iterations returns
   [Error (Did_not_converge 1.0)].
   Example form: [let rec countdown remaining = if remaining = 0 then Error `Stopped else countdown (remaining - 1)]
   Build and run before continuing. *)

(* Task 8 — Supplemental practice: factor with the prime stream.
   Inspired by 99 Problems P35-P36. Define
   [factorization : int -> ((int * int) list, string) result]. Return
   [Error "factorization requires a positive integer"] for [n <= 0] and [Ok []]
   for 1. For larger inputs, consume Task 2's prime stream and return ascending
   [(prime, multiplicity)] pairs. Stop when the next prime is greater than
   [remaining / prime], avoiding the overflow risk of [prime * prime], and append
   the remaining factor when it is greater than 1.

   Test 1, a prime, 315 yielding [[(3,2); (5,1); (7,1)]], and 1024 yielding
   [[(2,10)]]. Define an independent expansion helper and assert that multiplying
   the expanded factors reconstructs each positive test input.
   Example form: [let rec divide_out prime count remaining = ...]
   Build and run before continuing. *)

(* Task 9 — Supplemental practice: compare two totient computations.
   Inspired by 99 Problems P34 and P37-P38. For positive [n], Euler's totient is
   the number of integers [r] with [1 <= r < n] and [gcd r n = 1], with
   [phi 1 = 1]. Bring forward your completed E11 Euclidean [gcd] unchanged—it is
   standalone-file scaffolding here, not a new gcd exercise—then define
   [totient_naive : int -> int] from that definition. Raise
   [Invalid_argument "totient"] from both totient functions for [n <= 0].

   Define [totient_factored : int -> int] using Task 8 and the identity
   [phi n = n * product (p - 1) / p] over distinct prime divisors, arranging
   operations so every division is exact. Test 1, 10, 13, and 315, then assert
   both versions agree for every input 1 through 500. Derive their asymptotic
   costs and record a short optional timing observation without asserting a
   duration.
   Example form: [List.fold_left (fun value (prime, _) -> value / prime * (prime - 1)) n factors]
   Build and run before continuing. *)

(* Task 10 — Supplemental practice: find deterministic Goldbach pairs.
   Inspired by 99 Problems P40. Define
   [goldbach : int -> ((int * int), string) result]. Reject odd inputs and values
   at most 2 with [Error "Goldbach requires an even integer greater than 2"].
   Otherwise return the pair [(p, q)] with [p <= q], [p + q = n], and the
   smallest possible [p]. If exhaustive search finds none, return
   [Error "no Goldbach pair"]. Reuse one finite prefix of Task 2's prime stream;
   do not rebuild a sieve for every candidate.

   Define
   [goldbach_range : int -> int -> ((int * (int * int)) list, string) result].
   It returns [Ok []] when [low > high], ignores values outside [goldbach]'s
   domain, and propagates the first no-pair error instead of silently dropping
   it. Test [goldbach 4 = Ok (2,2)], [goldbach 28 = Ok (5,23)], and
   [goldbach 100 = Ok (3,97)]. Assert inputs 9 and 2 both return
   [Error "Goldbach requires an even integer greater than 2"], and assert range
   9 through 20 is
   [Ok [(10,(3,7)); (12,(5,7)); (14,(3,11)); (16,(3,13)); (18,(5,13));
        (20,(3,17))]].
   State why checking any finite range is evidence, not a proof of the conjecture.

   After every required measurement, explanation, and assertion in E34 is present
   and passing, print the exact line ["E34 passed"] once, and not earlier.
   Example form: [List.find_opt (fun prime -> is_prime (n - prime)) candidates]
   Build and run before continuing. *)

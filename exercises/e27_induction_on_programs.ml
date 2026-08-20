(** E27 — Induction on recursive programs (90-125 min)

    Build: [opam exec -- dune build exercises/e27_induction_on_programs.exe] Run:
    [opam exec -- dune exec exercises/e27_induction_on_programs.exe] Reading:
    https://cs3110.github.io/textbook/chapters/correctness/proving_correctness.html *)

(* Task 1 — Prove exponent addition.
   Define the source function
   [exp x n = if n = 0 then 1 else x * exp x (n - 1)]
   on natural-number exponents. Prove for all natural [m] and [n]:
   [exp x (m + n) = exp x m * exp x n], by induction on [m].

   State the induction hypothesis with all still-quantified variables, justify
   each unfolding and arithmetic step, and identify where associativity of
   multiplication is used. After the proof, add bounded sanity assertions; they
   supplement rather than replace it.
   Build and run before continuing. *)

(* Task 2 — Prove recursive and iterative Fibonacci equivalent.
   Define the textbook functions exactly on [n >= 1]:

   [fib 1 = 1]
   [fib 2 = 1]
   [fib n = fib (n - 2) + fib (n - 1)]

   [fibi 1 (prev,curr) = curr]
   [fibi n (prev,curr) = fibi (n - 1) (curr,prev + curr)]

   Prove [fib n = fibi n (0,1)] for every [n >= 1] by induction on [n]. The
   direct statement is not strong enough for a mechanical step: discover and
   state a strengthened claim for arbitrary consecutive accumulator values, then
   instantiate it at [(0,1)]. Do not substitute bounded equality tests for the
   proof. Add such tests only after the proof is complete.
   Build and run before continuing. *)

(* Task 3 — Prove exponentiation by repeated squaring.
   Define the source function exactly:

   [expsq x 0 = 1]
   [expsq x 1 = x]
   [expsq x n = (if n mod 2 = 0 then 1 else x)]
   [              * expsq (x * x) (n / 2)]

   Prove [expsq x n = exp x n] for all natural [n] by strong induction. Split
   the step into even and odd cases and state the arithmetic facts connecting
   [n], [n/2], and parity. Explain why the recursive exponent is smaller.
   Add bounded assertions only after the proof.
   Build and run before continuing. *)

(* Task 4 — Prove the simplified repeated-squaring function.
   Define [expsq_simplified] by removing only the [n = 1] branch from Task 3:

   [expsq_simplified x 0 = 1]
   [expsq_simplified x n = (if n mod 2 = 0 then 1 else x)]
   [                         * expsq_simplified (x * x) (n / 2)]

   Prove equivalence with [exp] by strong induction. Treat [n = 1] explicitly in
   the reasoning and explain why the simplified definition performs one extra
   recursive call there. Compare the two proofs before adding executable checks.
   Build and run before continuing. *)

(* Task 5 — Prove multiplication by zero for Peano naturals.
   Define [nat = Z | S of nat], [plus], and
   [mult Z b = Z], [mult (S k) b = plus b (mult k b)]. Prove
   [mult n Z = Z] for all [n] by structural induction on [n]. If the inductive
   step needs a fact about [plus], state and prove that lemma rather than
   skipping it. Add 0*3, 2*3, and 3*0 assertions afterward.
   Build and run before continuing. *)

(* Extension — Checked total wrappers.
   Define wrappers accepting OCaml [int] exponents, raising a documented
   exception for negatives and delegating nonnegative inputs to the proven
   functions. Keep exception behavior out of the mathematical proof statements. *)

(* Final task — Completion marker.
   Only after all five proofs, required lemmas, and sanity assertions are
   present, make the completed program print exactly [E27 passed] once. *)

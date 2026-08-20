(** E26 — QCheck-driven debugging (85-120 min)

    Required opam package: [qcheck]. The dedicated Dune stanza for this
    executable must link [qcheck].

    Build: [opam exec -- dune build exercises/e26_property_driven_debugging.exe]
    Run: [opam exec -- dune exec exercises/e26_property_driven_debugging.exe] *)

(* Task 1 — Test the textbook's buggy odd divisor with QCheck.
   Define this source function exactly, including the flawed upper-bound branch:

   [let odd_divisor x =]
   [  if x < 3 then 1 else]
   [    let rec search y =]
   [      if y >= x then y]
   [      else if x mod y = 0 then y]
   [      else search (y + 2)]
   [    in]
   [    search 3]

   Its stated precondition is [x >= 0]. Construct a QCheck arbitrary for small
   positive integers and test the claimed postcondition: the result is odd and
   divides the input. Run the property with the QCheck runner and record the
   reported seed, counterexample, and shrink result. In the final passing suite,
   retain this known-bug check with [QCheck.Test.make_neg] and rerun it from the
   recorded seed so success is reproducible.

   Then search upward deterministically only to answer the source question:
   assert that the smallest positive failing input is 4. Explain exactly which
   branch returns a non-divisor.
   Build and run before continuing. *)

(* Task 2 — Test the textbook's buggy average with an oracle.
   Define [avg] with the source's tail-recursive pair scan: a final singleton is
   counted normally; an unequal adjacent pair contributes both values and count
   2; an equal adjacent pair incorrectly contributes one copy and count 1.

   Define an obviously correct [avg_reference] using a sum fold and list length.
   Both functions require a nonempty integer list. Build a QCheck arbitrary for
   nonempty, bounded integer lists, include a useful printer and shrinker, and
   test approximate equality between [avg] and the oracle. Run enough cases to
   expose the bug and record the minimized counterexample. The property must call
   the independent reference implementation; do not repeat the optimized scan.
   Record the failing seed too. Retain the known-bug property with
   [QCheck.Test.make_neg] and its recorded seed so the final executable treats
   finding that counterexample as reproducible expected success. Use [run_tests]
   and assert its return code is zero; [run_tests_main] exits before a completion
   marker could run.
   Build and run before continuing. *)

(* Extension — Repair odd divisors.
   Define a corrected [least_odd_divisor] for positive integers. Return the least
   odd divisor at least 3, or 1 when none exists. State how odd primes, even
   powers of two, and invalid inputs behave. Test examples and a QCheck property
   that verifies divisibility and minimality without multiplying candidates in
   a way that can overflow. *)

(* Extension — Repair and stress average.
   Define [avg_repaired] with the same contract as [avg_reference]. Check the
   minimized QCheck counterexample, then run a deterministic stress comparison.
   If you also implement manual deletion shrinking, consider only nonempty
   deletions, restart at index 0 after each successful deletion, and stop only
   when no single deletion preserves failure. *)

(* Final task — Completion marker.
   Only after both source bugs have failing QCheck properties, recorded minimized
   counterexamples, and correct explanations, make the program print exactly
   [E26 passed] once. *)

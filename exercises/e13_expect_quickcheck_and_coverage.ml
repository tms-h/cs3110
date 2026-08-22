open! Core

(* E13 — Expect tests, Quickcheck, and coverage

   This is an inline-test library. It teaches the Jane Street testing workflow
   while retaining generators, shrinking, adversarial cases, and coverage
   reasoning from the longer testing block. *)

(* Task 1 — Define a testable contract.
   Implement [normalize_counts : (string * int) list -> (string * int) list].
   Merge duplicate keys by summing, drop nonpositive totals, and return keys in
   ascending order. State the contract and complexity before implementation. *)

(* Task 2 — Write readable examples.
   Add [let%expect_test] cases covering duplicates, cancellation, a negative
   total, and deterministic ordering. Start with one wrong expectation, inspect
   the [.corrected] diff, and accept it only after checking the contract. *)

(* Task 3 — Generate and shrink structured inputs.
   Use [Quickcheck.Generator] for small keys and bounded deltas. Check that
   output keys are unique and sorted, counts are positive, normalization is
   idempotent, and permuting input does not change the result. *)

(* Task 4 — Audit behavioral coverage.
   Enumerate the semantic branches in [normalize_counts], then match every
   branch to an example or property. Add adversarial cases for empty input,
   integer boundaries appropriate to your generator, and many duplicate keys.
   Treat line coverage as evidence, not as a correctness proof. *)

(* Task 5 — Preserve a regression.
   Add the smallest focused expect test for a shrunk counterexample, or for the
   hardest boundary if no failure occurred. Explain why that example belongs
   beside the general property.

   When complete, define [let e13_complete = true]. *)

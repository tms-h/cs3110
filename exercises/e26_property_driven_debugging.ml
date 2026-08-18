(** E26 — Property-driven debugging (85-120 min)

    Build: [opam exec -- dune build exercises/e26_property_driven_debugging.exe] Run:
    [opam exec -- dune exec exercises/e26_property_driven_debugging.exe] *)

(* Task 1 — Reproduce a factor bug.
   Define [least_odd_factor_buggy n] exactly as follows: return 1 for [n <= 2];
   otherwise search candidates 3, 5, 7, ...; return [candidate] when
   [candidate * candidate >= n], return it when it divides [n], and otherwise
   continue.

   For [n >= 1], the intended result is the least odd divisor at least 3, or 1
   when no such divisor exists. Define [smallest_bad_factor_input ()] by exhaustive
   search. Test that it returns 4 and that the buggy result for 4 violates the
   intended contract.
   Example form: [let rec first_failure n = if implementation n <> oracle n then n else first_failure (n + 1)]
   Build and run before continuing. *)

(* Task 2 — Repair least odd factor.
   Define [least_odd_factor n] with the intended contract from Task 1 and raise
   [Invalid_argument "factor"] for [n < 1]. Stop with 1 only after proving no
   candidate up to the square root divides [n].

   Test 1, 2, 3, 4, 9, 25, and 49. For every n from 1 through 500, test the result
   is 1 or an odd divisor, and no smaller odd integer at least 3 divides n.
   Example form: [let valid_divisor n candidate = n mod candidate = 0]
   Build and run before continuing. *)

(* Task 3 — Define a mean oracle.
   Define [mean_reference xs] as floating-point sum divided by length, using a
   fold and [List.length]. Raise [Invalid_argument "mean"] for []. Define
   [close a b] as absolute difference less than [1e-12].

   Test [1], [-2; 0; 2], [1; 2; 3; 4], and [].
   Example form: [let range values = List.fold_left max min_int values - List.fold_left min max_int values]
   Build and run before continuing. *)

(* Task 4 — Reproduce and shrink a mean bug.
   Define [mean_fast_buggy xs] with a tail-recursive pair scan. For equal adjacent
   [a] and [b], add only [a] and increase count by 1; otherwise add both and
   increase count by 2; handle a final singleton normally.

   Define [smallest_bad_mean_input ()] by enumerating nonempty lists in increasing
   length and lexicographic element order over -2 through 2. After the first
   disagreement, repeatedly delete the leftmost element whose removal preserves
   disagreement. Test the returned list disagrees with [mean_reference] and no
   single-element deletion still disagrees.
   Example form: [let still_fails sample = not (close (candidate sample) (oracle sample))]
   Build and run before continuing. *)

(* Task 5 — Repair and stress the mean.
   Define [mean_repaired xs] with the same contract as [mean_reference]. Test the
   minimized counterexample from Task 4. Then generate 10,000 deterministic
   nonempty lists of length 1 through 20 and values -100 through 100; assert the
   repaired result is [close] to the oracle for every list.
   Example form: [for trial = 1 to 500 do let sample = generate state in assert (candidate sample = oracle sample) done]
   Build and run before continuing. *)

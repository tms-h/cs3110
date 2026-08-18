(** E25 — Testing from contracts (95-130 min)

    Build: [opam exec -- dune build exercises/e25_testing_from_contracts.exe] Run:
    [opam exec -- dune exec exercises/e25_testing_from_contracts.exe] *)

(* Task 1 — Define a list-backed set.
   Define module [List_set] with ['a t = 'a list], [empty = []], [mem], [add],
   [remove], and [elements]. The representation contains no duplicates. [add]
   leaves an existing element unchanged; [remove] removes the element if present;
   [elements] returns the representation order.

   Test empty membership, first insertion, repeated insertion, absent removal,
   present removal, and an add-remove-add sequence.
   Example form: [module Bag = struct type 'a t = 'a list let empty = [] end]
   Build and run before continuing. *)

(* Task 2 — Package black-box tests.
   Define [black_box_tests ()] to run assertions derived only from the Task 1
   contract. Include partitions for empty/nonempty, present/absent, duplicate
   insertion, repeated removal, and at least two operation sequences.

   Call [black_box_tests ()] at program startup.
   Example form: [let contract_tests () = let value = Api.create () in assert (Api.size value = 0)]
   Build and run before continuing. *)

(* Task 3 — Add glass-box tests.
   Define [glass_box_tests ()] after reading your implementation. Add one runtime
   assertion for every pattern or conditional branch in [mem], [add], and
   [remove]. In a comment, identify one branch test that adds coverage without
   adding new contractual behavior.

   Call both test functions.
   Example form: [let branch_tests () = assert (classify 0 = `Zero); assert (classify 1 = `Positive)]
   Build and run before continuing. *)

(* Task 4 — Generate bounded random lists.
   Define [bounded_list state] using only the supplied [Random.State.t]. Choose a
   length uniformly from 5 through 10 inclusive and each integer uniformly from
   0 through 100 inclusive.

   With seed [3110], generate 100 lists. For each, assert the length and every
   element are within those bounds. Recreate the seed and test the same sequence
   of lists is generated again.
   Example form: [let length = 2 + Random.State.int state 4 in List.init length (fun _ -> Random.State.int state 10)]
   Build and run before continuing. *)

(* Task 5 — Find property counterexamples.
   Define [find_counterexample state trials property]. Generate up to [trials]
   bounded lists and return the first list for which [property] is false, or
   [None] if every trial passes. Return [None] when [trials <= 0].

   Test an always-true property, an always-false property, zero trials, and the
   property “contains an even integer” for 100 trials with seed 3110. If a
   counterexample is found, assert it really contains no even integer.
   Example form: [let rec gather count = if count = 0 then [] else generate () :: gather (count - 1)]
   Build and run before continuing. *)

(* Task 6 — Compare operation traces with a model.
   Define variant [operation] with [Add of int], [Remove of int], and
   [Mem of int]. Define [check_trace operations] to apply each operation to
   [List_set] and [Set.Make (Int)], checking membership for keys 0 through 20
   after every step and returning the first failing prefix or [None].

   Generate 10,000 deterministic operations with seed 3110 and keys 0 through
   20. Assert [check_trace] returns [None].
   Example form: [type command = Insert of string | Delete of string | Contains of string]
   Build and run before continuing. *)

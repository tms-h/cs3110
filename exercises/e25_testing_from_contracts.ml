(** E25 — OUnit, Bisect, and QCheck from contracts (95-130 min)

    Required opam packages: [ounit2], [bisect_ppx], and [qcheck]. The dedicated
    Dune stanza for this executable links [ounit2] and [qcheck] and declares the
    [bisect_ppx] instrumentation backend.

    Build: [opam exec -- dune build exercises/e25_testing_from_contracts.exe] Run:
    [opam exec -- dune exec exercises/e25_testing_from_contracts.exe] *)

(* Task 1 — Recreate the two textbook set implementations.
   Define module type [SET] with abstract ['a t], [empty], [mem], [add], and
   [elements]. Its contract is mathematical set behavior: adding an existing
   member changes no observable membership, and [elements] contains each member
   exactly once; its order is unspecified.

   Define [ListSet] with a list representation that permits duplicate stored
   values: [add] is constant-time cons and [elements] sorts and deduplicates.
   Define [UniqListSet] with an RI forbidding duplicates: [add] checks membership
   and [elements] can return the representation. Seal both as [SET]. These are
   the implementations the source testing exercises assume.
   Build and run before continuing. *)

(* Task 2 — Write OUnit black-box tests.
   Using [OUnit2], write a suite for [ListSet] derived only from [SET]'s public
   specifications. Cover empty/nonempty, member/nonmember, first and duplicate
   addition, at least two operation sequences, and [elements]. Do not inspect or
   assert the hidden representation; compare element lists extensionally rather
   than assuming an order.

   Immediately before the test declarations, add this exact structure-item
   attribute line: [@@@coverage off]. This keeps Bisect focused on
   the Task 1 implementations instead of counting the OUnit/QCheck harness as
   code under test. Do not place the attribute before [ListSet] or [UniqListSet].

   Run the suite with an OUnit runner and preserve the full test output.
   Build and run before continuing. *)

(* Task 3 — Measure glass-box coverage with Bisect.
   Read both implementations. Add focused tests for every conditional and
   pattern branch in [ListSet] and [UniqListSet], including duplicate and
   nonduplicate insertion paths. Collect and inspect real coverage with:

   [mkdir -p _coverage/e25-run-1]
   [BISECT_FILE=_coverage/e25-run-1/bisect opam exec -- dune exec --instrument-with bisect_ppx --force exercises/e25_testing_from_contracts.exe]
   [opam exec -- bisect-ppx-report summary --coverage-path _coverage/e25-run-1]
   [opam exec -- bisect-ppx-report html --coverage-path _coverage/e25-run-1 -o _coverage/e25-run-1/html]

   Record the measured percentage and any uncovered points, then open
   [_coverage/e25-run-1/html/index.html] and inspect the highlighted branches. Do not claim
   coverage from inspection alone. Aim as close to 100% as reachable without
   adding meaningless tests. Use a fresh run directory when repeating a run
   so stale counts cannot be mistaken for the latest result (for example,
   change [e25-run-1] to [e25-run-2]).

   In comments, distinguish a branch test that adds structural coverage from a
   black-box test that adds new contractual behavior.
   Build and run before continuing. *)

(* Task 4 — Generate bounded lists with QCheck.
   Use [QCheck.Gen.generate1] to generate one integer list whose length is 5
   through 10 inclusive and whose elements are 0 through 100 inclusive. Use
   [QCheck.Gen.generate] to generate exactly three such lists. Assert all bounds.

   Then use [QCheck.make] to construct an [int list QCheck.arbitrary] with the
   same bounds. Supply a readable printer so failures show the generated list.
   Build and run before continuing. *)

(* Task 5 — Run a QCheck property.
   Lift the property “an integer is even” to “this list contains at least one
   even integer.” First define a regular [QCheck.Test.t] over the bounded
   arbitrary and run 100 cases. As the source notes, a single run might happen to
   pass; repeat with reported seeds until a run fails. Record its seed and
   counterexample, and explain why the property is not universally true even
   though many individual samples pass.

   Then keep the discovery in the completed passing suite with
   [QCheck.Test.make_neg], which succeeds only when QCheck finds a counterexample.
   Reuse the recorded failing seed through the runner's [~rand] argument so this
   required check is reproducible rather than flaky. Use [run_tests], assert its
   return code is zero, and continue to the completion marker; [run_tests_main]
   exits before later code can run.

   Do not replace the QCheck test with a hand-written [Random.State] loop.
   Build and run before continuing. *)

(* Extension — Deterministic model-based traces.
   Define a separate extended set API with [remove]. Generate a deterministic
   trace of add/remove/membership commands and compare it after every step with
   [Set.Make (Int)]. This supplements rather than replaces OUnit, Bisect, or
   QCheck. The final executable must exit successfully before printing its
   completion marker. *)

(* Final task — Completion marker.
   Only after the OUnit suite passes, a Bisect summary is recorded, and the
   QCheck generator/property tasks are complete, make the program print exactly
   [E25 passed] once. *)

(** E41 — Programs as proofs (25-40 min)

    OUTCOME

    Use the Curry-Howard correspondence to synthesize programs from types, then read
    evaluation as proof simplification.

    CORRESPONDENCE USED IN THIS LAB

    - true = [unit]
    - false = [empty]
    - conjunction = pair
    - disjunction = [either]
    - implication = function

    STEP 1 — TRANSLATE BEFORE PROGRAMMING

    - Translate [true -> p] into an OCaml type.
    - Translate [p /\ (q /\ r)].
    - Translate [(p \/ q) \/ r].
    - Translate [false -> p].
    - Record the four answers in [TYPE TRANSLATIONS] before writing proof terms.

    STEP 2 — SYNTHESIZE COMMUTATIVITY PROOFS

    - Implement commutativity of conjunction by following the pair type.
    - Implement commutativity of disjunction by following the [either] type.
    - Use no exceptions, mutation, [Obj], or nontermination.

    STEP 3 — SIMPLIFY A PROOF BY EVALUATION

    - Predict the inferred type of [noisy].
    - Write its complete small-step evaluation.
    - From the final value, derive the simplest extensionally equivalent implementation.
    - Confirm that the simplified term has the predicted type.

    STEP 4 — TRANSFER FROM TYPES TO PROGRAMS

    - Implement distribution of conjunction over disjunction.
    - Implement implication composition.
    - For each function, read the type as a specification before writing the body.

    STEP 5 — REASON ABOUT FALSEHOOD

    - Explain why a test cannot construct a value of type [empty].
    - Implement the total function [empty -> 'a].
    - Explain why its totality does not require fabricating an ['a].

    FINISH

    Run: [opam exec -- dune exec exercises/e41_programs_as_proofs.exe]

    Reading: https://cs3110.github.io/textbook/chapters/adv/curry-howard.html

    Source coverage: propositions as types; programs as proofs; evaluation as
    simplification. *)

type empty = |
type ('a, 'b) either = Left of 'a | Right of 'b

(* TYPE TRANSLATIONS:
   1.
   2.
   3.
   4.
*)

let from_false (_impossible : empty) : 'a = failwith "TODO: exhaustive empty match"
let and_commute (_pair : 'a * 'b) : 'b * 'a = failwith "TODO"
let or_commute (_choice : ('a, 'b) either) : ('b, 'a) either = failwith "TODO"
let noisy x = snd ((fun y -> (y, y)) (fst x))
let simplified (_x : 'a * 'b) : 'a = failwith "TODO"

let distribute (_input : 'a * ('b, 'c) either) : ('a * 'b, 'a * 'c) either =
  failwith "TODO"

let compose_implications (_f : 'a -> 'b) (_g : 'b -> 'c) : 'a -> 'c = failwith "TODO"

(* EVALUATION OF [noisy (1,2)]: ...
   WHY FALSE ELIMINATION IS TOTAL: ... *)

let () =
  assert (and_commute (1, "q") = ("q", 1));
  assert (or_commute (Left 3) = Right 3);
  assert (noisy (1, 2) = simplified (1, 2));
  assert (distribute (1, Left "x") = Left (1, "x"));
  assert (compose_implications (( + ) 1) string_of_int 9 = "10");
  print_endline "E41 complete"

(** E41 — Programs as proofs (50-70 min)

    Build: [opam exec -- dune build exercises/e41_programs_as_proofs.exe] Run:
    [opam exec -- dune exec exercises/e41_programs_as_proofs.exe] Reading:
    https://cs3110.github.io/textbook/chapters/adv/curry-howard.html *)

(* Task 1 — Define proposition encodings.
   Define empty variant [empty] with no constructors. Define
   [('a, 'b) either = Left of 'a | Right of 'b]. Use [unit] for true, [empty] for
   false, pairs for conjunction, [either] for disjunction, and functions for
   implication.

   In comments, translate [true -> p], [p /\ (q /\ r)], [(p \/ q) \/ r], and
   [false -> p] into OCaml types. Define [conjunction_example] as one value of the
   nested conjunction, and [left_example] plus [right_example] as values choosing
   the two outer disjunction branches. Assert their runtime contents.
   Example form: [type ('a, 'b) choice = This of 'a | That of 'b]
   Build and run before continuing. *)

(* Task 2 — Prove commutativity by programming.
   Define [and_commute : 'a * 'b -> 'b * 'a] by swapping a pair. Define
   [or_commute : ('a, 'b) either -> ('b, 'a) either] by swapping Left and Right.
   Use no exceptions, mutation, [Obj], or nontermination.

   Test one pair and both disjunction constructors.
   Example test form: [assert (and_commute (1, "x") = ("x", 1))]
   Build and run before continuing. *)

(* Task 3 — Simplify a proof term by evaluation.
   Define [noisy x = snd ((fun y -> (y, y)) (fst x))]. Predict its inferred type
   in a comment, then annotate it with [('a * 'b) -> 'a]. Write the complete
   small-step evaluation of [noisy (1, 2)] in comments.

   Define [simplified : 'a * 'b -> 'a] with the extensionally equivalent body.
   Test both functions on integer/string and string/Boolean pairs.
   Example form: [let describe : int * string -> string = fun (_, text) -> text]
   Build and run before continuing. *)

(* Extension Task 4 — Distribute conjunction over disjunction.
   Define
   [distribute : 'a * ('b, 'c) either -> ('a * 'b, 'a * 'c) either]. Preserve the
   shared ['a] and the input branch.

   Test [(1, Left "x")] and [(1, Right true)].
   Example test form: [assert (distribute (1, Left "x") = Left (1, "x"))]
   Build and run before continuing. *)

(* Extension Task 5 — Compose implications.
   Define [compose_implications : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c]. Apply
   the first implication before the second.

   Test integer increment followed by [string_of_int] on 9, and [String.length]
   followed by an evenness predicate on ["OCaml"].
   Example test form: [assert (compose_implications succ string_of_int 9 = "10")]
   Build and run before continuing. *)

(* Extension Task 6 — Eliminate falsehood.
   Define [from_false : empty -> 'a] with a refutation case such as
   [function _ -> .]. It has no value-producing branch. Annotate it exactly with
   that type. Explain why no runtime assertion can call it and why totality does
   not require constructing an ['a].

   Retain a runtime assertion for [and_commute] so this task still runs executable
   checks without fabricating [empty].
   Example form: [type empty_case = |]
   [let impossible : empty_case -> 'a = function _ -> .]
   After every required translation, proof program, evaluation, and assertion in
   E41 is present and passing, print the exact line ["E41 passed"] once, and not
   earlier.
   Build and run before continuing. *)

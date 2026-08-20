(** E38 — Extending SimPL vertically, then generalizing the language

    Main-file build:
    [opam exec -- dune build exercises/e38_extending_a_language.exe]
    Main-file run:
    [opam exec -- dune exec exercises/e38_extending_a_language.exe]

    Tasks 1–3 use the cumulative ocamllex/Menhir SimPL project in
    [exercises/e38_pair_stage/work]. It initially contains the textbook SimPL
    AST, parser, lexer, type checker, and both evaluators with no pair support.
    Edit that one project in order. Tasks 4 onward return to this main file.

    Reading:
    https://cs3110.github.io/textbook/chapters/interp/exercises.html *)

(* Task 1 — Textbook [pair parsing]: extend the real SimPL front end.
   First confirm that the untouched starter builds:
   [opam exec -- dune build @exercises/e38_pair_stage/work/all]

   Before editing, predict what [Driver.parse "(1,2)"] does. Then make the four
   textbook changes in this exact order, rebuilding the same alias after each:

   1. In [work/ast.ml], add [Pair of expr * expr] to [expr].
   2. In [work/parser.mly], declare a [COMMA] token.
   3. In [work/lexer.mll], make a comma produce [COMMA]. Put the rule before the
      catch-all lexical-error rule.
   4. In [work/parser.mly], add a production for a parenthesized pair whose two
      components are arbitrary [expr] values, not merely integer literals.

   Exhaustiveness warnings from [typecheck.ml] and [eval.ml] are expected after
   step 1; this local Dune stanza allows them so the advertised incremental build
   remains real. An unused-token warning is expected after step 2. Do not silence
   those warnings with wildcard cases: Tasks 2 and 3 will implement the missing
   semantics.

   Launch [opam exec -- dune utop exercises/e38_pair_stage/work], open
   [Pair_work], and test [(1,2)], [(1+2,(3,4+5))], and [(1+2)]. Record the exact
   ASTs, then test a missing comma/parenthesis and trailing input. The final
   checker is intentionally not expected to pass yet. Build this main file
   before continuing. *)

(* Task 2 — Textbook [pair type checking]: extend the same SimPL checker.
   Before coding, write a formal typing rule for pairs in this file. The rule
   must show how the types of both components determine the pair type.

   In [work/typecheck.ml], add [TPair of typ * typ], then add the [Pair] case to
   [typeof]. Do not special-case integers or require both components to have the
   same type. Rebuild [@exercises/e38_pair_stage/work/all]. In utop, check the
   types of [(1,true)] and [((1,false),2)], and record the results. Verify that
   [typecheck.ml] no longer has a Pair exhaustiveness warning; evaluation warnings
   should remain until Task 3. Build the main file before continuing. *)

(* Task 3 — Textbook [pair evaluation]: extend both SimPL evaluators.
   Before coding, write all of the following in this file:

   - the definition of when a pair is a value;
   - [(e1,e2){v/x} = (e1{v/x},e2{v/x})];
   - the small-step rule that steps the left component;
   - the small-step rule that steps the right component only after the left is a
     value; and
   - the big-step rule that evaluates both components.

   In [work/eval.ml], make [is_value] recursive and implement pairs in
   [is_value]. Rebuild. Add the [Pair] case to [subst]. Rebuild. Add both Pair
   cases needed for left-to-right [step]. Rebuild. Finally add Pair to [eval_big]
   and rebuild. Do not replace the explicit cases with a catch-all.

   Run the black-box completion check:
   [opam exec -- dune exec exercises/e38_pair_stage/work/completion_check.exe]
   It checks parsing, heterogeneous and ordered pair types, recursive values,
   substitution, left-to-right small steps, and big-step evaluation without
   containing the missing Pair or TPair constructors itself. It must print
   [e38_pair_stage passed]. Build this main file before continuing. *)

(* Task 4 — Project extension: define a richer pattern-and-sum language.
   Tasks 1–3 above are the direct SimPL implementation exercises. This separate
   language is additional practice for the later textbook pattern and list
   questions; it does not replace the SimPL work stage.

   Define these complete variants, including every constructor payload:

   [type typ =
      | TInt
      | TPair of typ * typ
      | TSum of typ * typ]

   [type pattern =
      | PInt of int
      | PPair of pattern * pattern
      | PLeft of pattern
      | PRight of pattern
      | PVar of string
      | PWildcard]

   [type expr =
      | Int of int
      | Var of string
      | Add of expr * expr
      | Pair of expr * expr
      | Left of expr
      | Right of expr
      | Ascribe of expr * typ
      | Match of expr * (pattern * expr) list
      | Fst of expr
      | Snd of expr]

   [type value =
      | VInt of int
      | VPair of value * value
      | VLeft of value
      | VRight of value]

   [Fst] and [Snd] are declared now because OCaml variants are closed. [Ascribe]
   supplies the arm type missing from a lone sum injection. Construct and assert
   the AST [Pair (Int 1, Ascribe (Left (Int 2), TSum (TInt, TInt)))] and value
   [VPair (VInt 1, VLeft (VInt 2))]. Build and run before continuing. *)

(* Task 5 — Textbook [generalize patterns], plus an implementation extension.
   First complete the source exercise on paper in comments. Define the relation
   [value =~ pattern // substitutions], then complete and label the three
   small-step rules for Match:

   - the scrutinee takes one step;
   - a value that does not match the first pattern drops that branch; and
   - a value that matches the first pattern substitutes its bindings into the
     first branch body.

   Use those rules to give a complete labelled evaluation of
   [match (1 + 2, 3) with | (1,0) -> 4 | (1,x) -> x | (x,y) -> x + y].

   As an explicitly additional executable model, define
   [match_pattern pattern value]. Return bindings in left-to-right order or
   [None] on mismatch. Wildcards bind nothing. Reject a pattern that repeats a
   variable name, even if both matched values are equal. Test literals, wildcard,
   nested pairs, both sum injections, mismatch, and
   [PPair (PVar "x", PVar "x")]. Build and run. *)

(* Task 6 — Project extension: type-check annotations, sums, and patterns.
   Define mutually recursive [infer context expression] and
   [check context expression expected_type] for newest-first bindings.

   Integers have [TInt]; Add requires integers; Pair combines component types;
   Fst/Snd require a pair. Checking [Left payload] against
   [TSum (left_type, _)] checks its payload against [left_type], with the analogous
   rule for Right. Inferring an unannotated Left or Right returns
   [Error "sum annotation required"]. Ascription checks its expression and then
   returns the stated type.

   For Match, infer the scrutinee, check each pattern against that type, extend
   the branch context with its bindings, and require all branch result types to
   agree. Specify and test every returned error, including unbound variables,
   expected int/pair/sum, pattern mismatch, type mismatch, branch mismatch, empty
   match, and missing sum annotation. Test a left integer at both
   [TSum (TInt, TInt)] and [TSum (TInt, TPair (TInt, TInt))]. Build and run. *)

(* Task 7 — Project extension: evaluate the richer language.
   Define [eval environment expression] for newest-first string/value bindings.
   Evaluate Add and Pair left-to-right, evaluate sum payloads, ignore Ascribe at
   runtime, and evaluate Fst/Snd only on pairs. For Match, evaluate the scrutinee,
   try branches in source order, and evaluate the first matching body in an
   environment extended with the pattern bindings.

   Return precisely specified errors for an unbound name, expected integer,
   expected pair, and no matching branch. Test every expression form, pair
   evaluation order, branch order, ignored annotations, and every runtime error.
   Build and run before continuing. *)

(* Task 8 — Textbook [desugar list].
   Under [[] = Left 0] and [head :: tail = Right (head, tail)], write the exact
   Core OCaml expression to which [1; 2; 3] desugars. Preserve every nested
   constructor and pair; an informal description is not enough.

   As an implementation extension, define recursive [desugar_list] with those
   two equations. Assert exact encodings for [], [Int 1], and [Int 1; Int 2].
   Build and run before continuing. *)

(* Task 9 — Textbook [list not empty], plus an executable model.
   Write the actual Core OCaml function [not_empty] that returns 0 for the Left
   encoding of [] and 1 for any Right encoding of a non-empty list. Show its
   complete substitution-model evaluation on [] and on [1], labelling the
   evaluation steps. Merely running the model below does not replace these two
   derivations.

   Then define [not_empty_body] in the richer AST as a Match on [Var "xs"].
   Evaluate it in environments containing the empty and singleton encodings and
   assert results 0 and 1. Build and run. *)

(* Task 10 — Project extension: validate pair projections.
   Fst and Snd were declared in Task 4 and implemented in Tasks 6 and 7. Test
   both projections on an integer/sum pair, plus type and runtime errors on an
   integer. Verify that all pattern matches are exhaustive.

   After the real SimPL checker passes, and every required rule, derivation,
   explanation, implementation, and assertion in this main file is present and
   passing, print exactly ["E38 passed"] once and not earlier. Build and run the
   main file. *)

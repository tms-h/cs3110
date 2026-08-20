(** E38 — Extending an interpreter vertically (155-220 min)

    Build: [opam exec -- dune build exercises/e38_extending_a_language.exe] Run:
    [opam exec -- dune exec exercises/e38_extending_a_language.exe] *)

(* Task 1 — Define types, patterns, expressions, and values.
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

   [Fst] and [Snd] are declared now so the closed [expr] type does not have to be
   redefined later. Tasks 4 and 5 implement them; Task 7 tests that extension.

   [Ascribe (expression, typ)] is a compile-time type annotation and has no
   runtime effect. Sum injections remain [Left expression] and [Right expression];
   Task 4 will require an annotation whenever their missing arm cannot otherwise
   be known. This avoids incorrectly assuming that the other arm has type int.

   Construct and test the AST
   [Pair (Int 1, Ascribe (Left (Int 2), TSum (TInt, TInt)))] and runtime value
   [VPair (VInt 1, VLeft (VInt 2))].
   Example form: [type item = Number of int | Tuple of item * item]
   Build and run before continuing. *)

(* Task 2 — Lex and parse compositional pair expressions.
   Define [token = Lparen | Rparen | Comma | Plus | Int_lit of int | End]. Define
   [pair_phase_error = Pair_lex_error of int * string |
   Pair_parse_error of int * string], using zero-based character and token
   positions. Define [lex_pair_source] for nonnegative integers, whitespace,
   plus, commas, and parentheses. Define a cursor and mutually recursive parsers
   for this grammar:

   [expression ::= atom (PLUS atom)*]
   [atom       ::= integer | ( expression ) | ( expression , expression )]

   Addition is left associative. After parsing the first expression following a
   left parenthesis, a comma begins a pair and a right parenthesis ends grouping.
   Both pair components are arbitrary expressions, so nested pairs and arithmetic
   components must work. Require [End] after one complete expression.

   Return ["expected expression"], ["expected , or )"], ["expected )"], or
   ["trailing input"] at the first offending token. Test [(1,2)],
   [(1+2,(3,4+5))], and [(1+2)] with exact ASTs. Test each missing delimiter, a
   trailing token, and an unexpected character with exact errors and positions.
   Example parser shape: parse the first component once, then inspect whether the
   next token is [Comma] or [Rparen].
   Build and run before continuing. *)

(* Source checkpoint 3 — Formalize and implement generalized pattern matching.
   In comments, define the relation [value =~ pattern // substitutions]. Complete
   and label the three textbook small-step rules for a match expression:

   - the scrutinee takes one step;
   - a value that does not match the first pattern drops that branch;
   - a value that matches the first pattern substitutes its bindings into that
     branch body.

   Use the completed rules to evaluate
   [match (1 + 2, 3) with | (1,0) -> 4 | (1,x) -> x | (x,y) -> x + y]
   to a value, labelling every transition.

   Then define [match_pattern pattern value] to return bindings in left-to-right
   order or [None] on mismatch. [PWildcard] binds nothing; [PVar name] binds once;
   compound patterns combine child bindings. If the same variable would be bound
   twice in one pattern, return [None] even when the values agree.

   Test literals, wildcard, nested pairs, both sum injections, mismatch, and
   [PPair (PVar "x", PVar "x")].
   Example form: [match pattern, value with Any, _ -> Some [] | Name x, value -> Some [(x, value)] | _ -> None]
   Build and run before continuing. *)

(* Task 4 — Type-check with explicit sum annotations.
   Before coding, write the typing rule for pairs in a comment. Then define
   mutually recursive [infer context expression] and [check context expression
   expected_type], where contexts are newest-first string/type bindings.

   Integers have [TInt]; Add requires two ints; Pair combines child types.
   [Fst expression] and [Snd expression] require a pair and return its first or
   second component type; a non-pair produces [Error "expected pair"].
   [check context (Left payload) (TSum (left_type, _))] checks the payload against
   [left_type], and the analogous Right rule checks the right arm. Inferring a
   naked [Left] or [Right] returns [Error "sum annotation required"].
   [infer context (Ascribe (expression, typ))] checks the expression against typ,
   then returns typ. Thus [Left (Int 1)] can inhabit [int + pair] when explicitly
   ascribed; the absent arm is never silently fixed to int.

   For Match, infer the scrutinee, check each pattern against that type, extend
   each branch context with the pattern's bindings, and require every branch
   result type to match. Return [Error "empty match"], ["unbound: name"],
   ["expected int"], ["expected pair"], ["expected sum"], ["pattern type"],
   ["type mismatch"], ["branch mismatch"], or ["sum annotation required"] as
   appropriate.

   Test every expression form and error, including a left integer ascribed both
   to [TSum (TInt, TInt)] and [TSum (TInt, TPair (TInt, TInt))].
   Example form: [Result.bind (infer scope expression) (fun actual -> if actual = expected then Ok () else Error "type mismatch")]
   Build and run before continuing. *)

(* Source checkpoint 5 — State pair semantics, then evaluate the language.
   Before implementing the environment evaluator, write in comments:

   - the substitution equation for a pair;
   - the definition of when a pair is a value;
   - the left-then-right small-step rules for pairs; and
   - the big-step rule that evaluates both components left-to-right.

   Give a complete rule-labelled small-step trace of [(1+2, 3+4)] and a
   rule-labelled big-step derivation of the same expression.

   Define [eval environment expression] with newest-first string/value bindings.
   Evaluate Add and Pair left-to-right and sums on their payload. [Ascribe] simply
   evaluates its enclosed expression. [Fst] and [Snd] evaluate their operand,
   require [VPair], and return the selected component. For Match, evaluate the
   scrutinee, try branches in source order, and evaluate the first matching branch
   in an environment extended by its bindings.

   Return [Error "unbound: name"], ["expected int"], ["expected pair"], or
   ["no matching branch"]. Test every expression form, pair evaluation order,
   branch order, ignored annotations, and every runtime error.
   Example form: [match term with Number n -> Ok (Number_value n) | Name x -> lookup x scope]
   Build and run before continuing. *)

(* Task 6 — Desugar lists and check [not_empty].
   First write the exact Core OCaml expression to which [1; 2; 3] desugars under
   [[] = Left 0] and [head :: tail = Right (head, tail)].

   Define recursive [desugar_list expressions] with those two equations. These
   generated injections are runtime syntax; Task 4 requires an [Ascribe] only if
   a caller subsequently asks to type-check one without an expected sum type.
   Define [not_empty_body] as a Match on variable ["xs"] returning 0 for any Left
   and 1 for any Right.

   In comments, write the actual Core OCaml function [not_empty] and show its two
   substitution-model evaluations on [] and [1]. In code, test desugaring [],
   [Int 1], and [Int 1; Int 2], then evaluate [not_empty_body] in environments
   containing the empty and singleton encodings.
   Example form: [let rec encode = function [] -> base | head :: tail -> step head (encode tail)]
   Build and run before continuing. *)

(* Extension Task 7 — Validate pair projections.
   [Fst] and [Snd] were declared in Task 1 and implemented in Tasks 4 and 5, so
   this task does not reopen a variant or retrofit cases into a supposedly
   finished checker or evaluator. Test both projections on an integer/sum pair,
   plus type and runtime errors on an integer. Verify that every pattern match is
   exhaustive.
   Example test shape: [assert (eval [] (Fst pair_expression) = Ok first_value)]
   After every required formal rule, derivation, explanation, and assertion in
   E38 is present and passing, print the exact line ["E38 passed"] once, and not
   earlier. Build and run before continuing. *)

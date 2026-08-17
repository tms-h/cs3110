(** E38 — Extending an interpreter vertically (110-150 min)

    Build: [opam exec -- dune build exercises/e38_extending_a_language.exe] Run:
    [opam exec -- dune exec exercises/e38_extending_a_language.exe] *)

(* Task 1 — Define types, patterns, expressions, and values.
   Define [typ] with [TInt], [TPair], and [TSum]. Define [pattern] with [PInt],
   [PPair], [PLeft], [PRight], [PVar], and [PWildcard]. Define [expr] with [Int],
   [Var], [Add], [Pair], [Left], [Right], and [Match]. Define [value] with [VInt],
   [VPair], [VLeft], and [VRight].

   Construct and test the AST and value for pair [(1, Left 2)].
   Build and run before continuing. *)

(* Task 2 — Parse integer pairs.
   Define [token = Lparen | Rparen | Comma | Int_lit of int]. Define
   [parse_pair tokens] to accept exactly
   [Lparen; Int_lit a; Comma; Int_lit b; Rparen] and return
   [Ok (Pair (Int a, Int b))]. Return [Error "expected pair"] for every other
   token list, including trailing input.

   Test a valid pair, each missing delimiter, and one trailing token.
   Build and run before continuing. *)

(* Task 3 — Match generalized patterns.
   Define [match_pattern pattern value] to return bindings in left-to-right order
   or [None] on mismatch. [PWildcard] binds nothing; [PVar name] binds once;
   compound patterns combine child bindings. If the same variable name would be
   bound twice anywhere in one pattern, return [None] even when values agree.

   Test literals, wildcard, nested pair, left and right sums, mismatch, and
   [PPair (PVar "x", PVar "x")].
   Build and run before continuing. *)

(* Task 4 — Infer expression types.
   Define [infer context expression], with newest-first string/type bindings.
   Integers have [TInt]; Add requires two ints; Pair combines child types.
   [Left e] has [TSum (type_of_e, TInt)] and [Right e] has
   [TSum (TInt, type_of_e)].

   For Match, infer the scrutinee, check each pattern against that type, extend
   the branch context with pattern bindings, and require every branch result type
   to match. Return [Error "empty match"], ["unbound: name"], ["expected int"],
   ["pattern type"], or ["branch mismatch"] as appropriate. Test every form and
   every error string.
   Build and run before continuing. *)

(* Task 5 — Evaluate expression forms.
   Define [eval environment expression], with newest-first string/value bindings.
   Evaluate Add left-to-right on integers, Pair left-to-right, and sums on their
   payload. For Match, evaluate the scrutinee, try branches in source order, and
   evaluate the first matching branch in an environment extended by its bindings.

   Return [Error "unbound: name"], ["expected int"], or ["no matching branch"].
   Test every expression form, branch order, and every runtime error.
   Build and run before continuing. *)

(* Task 6 — Desugar lists.
   Define recursive [desugar_list expressions] with
   [[] -> Left (Int 0)] and
   [[head; tail...] -> Right (Pair (head, desugar_list tail))]. Define
   [not_empty] as a Match on variable ["xs"] returning 0 for any Left and 1 for
   any Right.

   Test desugaring [], [Int 1], and [Int 1; Int 2]. Evaluate [not_empty] with
   environments containing the empty and singleton encodings.
   Build and run before continuing. *)

(* Task 7 — Add pair projections.
   Add expression constructors [Fst of expr] and [Snd of expr]. In [infer],
   require a pair and return its first or second component type. In [eval],
   require [VPair] and return the selected component. Use
   [Error "expected pair"] at both layers.

   Test both projections on an integer/sum pair, plus type and runtime errors on
   an integer. Update every pattern match until compilation is exhaustive.
   Build and run before continuing. *)

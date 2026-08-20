(** E36 — Lexing, parsing, and type judgments (145-200 min)

    Build: [opam exec -- dune build exercises/e36_parser_orientation.exe] Run:
    [opam exec -- dune exec exercises/e36_parser_orientation.exe] Reading:
    https://cs3110.github.io/textbook/chapters/interp/parsing.html *)

(* Task 1 — Define tokens and a small SimPL-like syntax.
   Define [token] with [TInt_lit of int], [TBool_lit of bool],
   [TIdent of string], [TPlus], [TTimes], [TLeq], [TEqual], [TLparen],
   [TRparen], [TLet], [TIn], [TIf], [TThen], [TElse], and [TEnd].

   Define [expr] with [Int], [Bool], [Var], [Add], [Mul], [Leq], [If], and
   [Let]. Define [phase_error] with [Lex_error of int * string] and
   [Parse_error of int * string]; positions are zero-based character or token
   indices.

   Construct and test the exact AST [Add (Int 1, Mul (Int 2, Int 3))].
   Example form: [type shape = Circle of int | Combine of shape * shape]
   Build and run before continuing. *)

(* Task 2 — Lex the language.
   Define [lex source]. Skip spaces, tabs, and newlines. Recognize nonnegative
   decimal integers; identifiers beginning with an ASCII letter and continuing
   with letters, digits, or underscore; plus, star, parentheses, equals, and the
   two-character token [<=]. Recognize [let], [in], [if], [then], [else], [true],
   and [false] as keywords rather than identifiers. Append exactly one [TEnd].
   On any other character, return [Error (Lex_error (position, text))].

   Test ["x + 12*(y_2)"] and ["let x = 2 in if x <= 3 then true else false"]
   produce exact token lists. Test ["3.14"] reports a lexical error at dot
   position 1. Ensure [<=] is recognized before treating a lone [<] as invalid.
   Example form: [match source.[position] with '+' -> Ok Plus | character -> Error (position, String.make 1 character)]
   Build and run before continuing. *)

(* Task 3 — Define cursor operations.
   Define record [cursor] with [tokens : token array] and mutable
   [position : int]. Define [peek cursor] to return the current token or [TEnd]
   past the array. Define [consume cursor] to return [peek cursor] and increment
   [position] by one.

   Test two consumes from [TInt_lit 1; TPlus], then test [peek] past the array.
   Example form: [let advance reader = let item = current reader in reader.index <- reader.index + 1; item]
   Build and run before continuing. *)

(* Task 4 — Parse expressions with one self-contained recursive group.
   Define [parse_expr], [parse_comparison], [parse_sum], [parse_product], and
   [parse_atom] in the same mutually recursive definition. Use this grammar:

   [expr       ::= let identifier = expr in expr
                 | if expr then expr else expr
                 | comparison]
   [comparison ::= sum | sum <= sum]
   [sum        ::= product (+ product)*]
   [product    ::= atom (TIMES atom)*]
   [atom       ::= integer | Boolean | identifier | ( expr )]

   Sums and products are left associative; multiplication binds tighter than
   addition, and comparison is non-associative. Parenthesized atoms call
   [parse_expr], which is why all five functions must be in this recursive group.
   Return [Parse_error] at the current token position. Use precise messages such
   as ["expected atom"], ["expected identifier"], ["expected ="], ["expected in"],
   ["expected then"], ["expected else"], and ["expected )"].

   Test direct token arrays for [1*2*3], [1+2*3], a let, an if, and a missing
   right parenthesis. The product AST must be
   [Mul (Mul (Int 1, Int 2), Int 3)].
   Example invariant: after a successful parser returns, the cursor points at the
   first token not belonging to that grammar production.
   Build and run before continuing. *)

(* Task 5 — Parse one complete source string.
   Define [parse source] to call [lex], create a cursor, parse one expression, and
   require [TEnd]. Any remaining token is
   [Parse_error (position, "trailing input")]. Do not silently accept a second
   expression or a second [TEnd].

   Test exact ASTs for ["22"], ["1 + 2 + 3"], ["1+2*3"], ["(1+2)*3"], and
   ["let x = 2 in 20 + x"]. Test ["3+"], ["1 2"], and a missing [in], including
   exact error phases and positions.
   Example form: [match current reader with End -> Ok expression | _ -> Error "trailing input"]
   Build and run before continuing. *)

(* Source checkpoint 6 — Distinguish lexing from parsing.
   Before running each case, predict the result in a comment. Then evaluate
   [parse "22"], [parse "1 + 2 + 3"], and
   [parse "let x = 2 in 20 + x"] and record the returned ASTs.

   Predict and run [parse "3.14"] and [parse "3+"]. Explain why the former fails
   during lexing at character 1 and the latter fails during parsing at the final
   token. If any prediction differs from the result, explain the first mismatch
   before changing code.
   Build and run before continuing. *)

(* Source checkpoint 7 — Experiment with associativity and precedence.
   First predict and record the normal AST for ["1*2*3"]. Temporarily make the
   product parser right associative, rebuild, and record the changed AST. Restore
   left associativity before continuing.

   Next predict and record the normal AST for ["1+2*3"]. Temporarily swap the
   addition and multiplication precedence in the parser, rebuild, and record the
   changed AST. Restore multiplication-higher-than-addition and rerun all parser
   assertions. Keep the predictions and observations in comments even though the
   final implementation is restored.
   Build and run before continuing. *)

(* Source checkpoint 8 — Compare identifier rules.
   Define [is_local_identifier s] to return true exactly for the identifier rule
   used by [lex], with at least one character and excluding keywords. Test ["x"],
   ["x_2"], ["_x"], ["2x"], ["x'"], ["let"], and ["True"] according to that rule.

   In comments, record at least two differences from OCaml identifiers and one
   difference between a lexical identifier and an OCaml lowercase value name.
   Example form: [let is_ascii_letter c = ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')]
   Build and run before continuing. *)

(* Task 9 — Type-check the parsed language.
   Define [typ = TInt | TBool]. Define [type_error] with [Unbound of string],
   [Expected_int], [Expected_bool], and [Branch_mismatch]. Define
   [infer context expression], where context is a newest-first string/type list.
   Arithmetic requires ints; [Leq] requires ints and returns bool; [If] requires
   a Boolean condition and equal branch types; [Let] infers the bound expression
   before extending the context for its body.

   Define [front_end_error = Syntax of phase_error | Type of type_error] and
   [infer_source source] by parsing, then inferring in the empty context. Test the
   textbook cases ["3110"], ["1 <= 2"], and ["let x = 2 in 20 + x"]. Also test
   every type-error constructor, syntax-error propagation, and let shadowing.
   Example shape: [match parse source with
   | Error error -> Error (Syntax error)
   | Ok expression -> Result.map_error (fun error -> Type error) (infer [] expression)]
   Build and run before continuing. *)

(* Source checkpoint 10 — Reason with typing contexts and derivations.
   In comments, answer both parts precisely:

   1. If an expression is well typed in context [ctx], must every subexpression
      be well typed in that same [ctx]? Must every subexpression be well typed in
      some context? Give a concrete binder example and identify the context that
      makes its bound occurrence well typed.

   2. Draw a complete, rule-labelled derivation of
      [{} |- let x = 0 in if x <= 1 then 22 else 42 : int]. Show the context used
      for every premise rather than writing only the final type.

   After every required prediction, experiment, derivation, and assertion in E36
   is present and passing, print the exact line ["E36 passed"] once, and not
   earlier. Build and run before continuing. *)

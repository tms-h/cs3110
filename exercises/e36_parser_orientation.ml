(** E36 — Lexing, parsing, and type judgments (105-145 min)

    Build: [opam exec -- dune build exercises/e36_parser_orientation.exe] Run:
    [opam exec -- dune exec exercises/e36_parser_orientation.exe] Reading:
    https://cs3110.github.io/textbook/chapters/interp/parsing.html *)

(* Task 1 — Define tokens and arithmetic syntax.
   Define [token] with [TInt_lit of int], [TIdent of string], [TPlus], [TTimes],
   [TLparen], [TRparen], and [TEnd]. Define [expr] with [Int], [Var], [Add], and
   [Mul]. Define [phase_error] with [Lex_error of int * string] and
   [Parse_error of int * string]; positions are zero-based character or token
   indices.

   Construct and test the exact AST [Add (Int 1, Mul (Int 2, Int 3))].
   Build and run before continuing. *)

(* Task 2 — Lex the arithmetic language.
   Define [lex source]. Skip spaces, tabs, and newlines. Recognize nonnegative
   decimal integers; identifiers beginning with an ASCII letter and continuing
   with letters, digits, or underscore; plus, star, and parentheses. Append one
   [TEnd]. On any other character, return [Error (Lex_error (position, text))].

   Test ["x + 12*(y_2)"] produces the exact token list. Test ["3.14"] reports a
   lexical error at the dot position 1.
   Build and run before continuing. *)

(* Task 3 — Define cursor operations.
   Define record [cursor] with [tokens : token array] and mutable
   [position : int]. Define [peek cursor] to return the current token or [TEnd]
   past the array. Define [consume cursor] to return [peek cursor] and increment
   position by one.

   Test two consumes from [TInt_lit 1; TPlus], then test [peek] past the array.
   Build and run before continuing. *)

(* Task 4 — Parse atoms and products.
   Define mutually recursive [parse_atom cursor] and [parse_product cursor]. An
   atom is an integer, identifier, or parenthesized sum. A product is a left-
   associative sequence of atoms separated by [TTimes]. Return [Parse_error] at
   the current token position with message ["expected atom"] for a missing atom
   or ["expected )"] for a missing closing parenthesis.

   Test tokens for [1*2*3] produce [Mul (Mul (Int 1, Int 2), Int 3)]. Test a
   missing right parenthesis returns Error.
   Build and run before continuing. *)

(* Task 5 — Parse sums and complete input.
   Define [parse_sum cursor] as a left-associative sequence of products separated
   by [TPlus]. Define [parse source] to call [lex], parse one sum, and require
   [TEnd]; any trailing token is [Parse_error (position, "trailing input")].
   Multiplication binds tighter than addition.

   Test ["1+2*3"], ["(1+2)*3"], ["3+"], and ["1 2"].
   Build and run before continuing. *)

(* Task 6 — Compare identifier rules.
   Define [is_local_identifier s] to return true exactly for the identifier rule
   used by [lex], with at least one character. Test ["x"], ["x_2"], ["_x"],
   ["2x"], and ["x'"] according to that rule.

   In comments, record at least two differences from OCaml identifiers.
   Build and run before continuing. *)

(* Task 7 — Infer simple expression types.
   Define [typ = TInt | TBool]. Define [typed_expr] with [EInt], [EBool], [EVar],
   [EAdd], [ELeq], [EIf], and [ELet]. Define [type_error] with [Unbound of string],
   [Expected_int], [Expected_bool], and [Branch_mismatch].

   Define [infer context expression], where context is newest-first string/type
   bindings. Addition requires two ints and returns int; <= requires two ints and
   returns bool; if requires bool condition and equal branch types; let infers the
   bound expression then extends the context for its body. Test each success and
   each error constructor, including shadowing in a let.
   Build and run before continuing. *)

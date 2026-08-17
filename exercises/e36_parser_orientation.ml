(** E36 — Parser orientation and type judgments (40-50 min)

    OUTCOME

    Enter an unfamiliar interpreter through its tokens, AST, precedence rules, and type
    judgments. Classify failures by phase before changing code.

    STEP 1 — ORIENT WITHOUT EDITING

    - Read this entire file once without changing it.
    - Trace [parse "1+2*3"] through tokenization and the mutually recursive parser.
    - Write the exact token list and predicted AST before implementing anything.

    STEP 2 — IMPLEMENT AND DIAGNOSE THE LEXER

    - Implement [lex] while preserving source positions in error messages.
    - Predict whether ["3+"] and ["3.14"] should fail during lexing or parsing.
    - Run both inputs and record the actual phase.
    - If a prediction is wrong, explain which component had enough information to reject
      the input.

    STEP 3 — IMPLEMENT PRECEDENCE AND ASSOCIATIVITY

    - Implement the recursive-descent parser so multiplication binds more tightly than
      addition.
    - Make both operators associate to the left.
    - Predict the ASTs of ["1+2*3"] and ["1*2*3"], then run the assertions.
    - Temporarily reverse each design choice in turn. Predict the changed AST, verify
      it, then restore the required parser.

    STEP 4 — READ THE OCAML IDENTIFIER RULES

    - Find the OCaml manual's lexical rules for identifiers.
    - Compare them with the identifier rule implemented here.
    - Record at least two concrete differences in [IDENTIFIER DIFFERENCES].

    STEP 5 — IMPLEMENT STRUCTURED TYPE INFERENCE

    - Implement [infer] for arithmetic, Booleans, [let], and [if].
    - Return the provided structured errors; do not throw exceptions.
    - On paper, derive the judgment for the marked [let x=0 in ...] term.
    - Use a failing arithmetic term to confirm that the error is reported at the type
      phase.

    STEP 6 — REASON ABOUT SUBEXPRESSION CONTEXTS

    - Answer whether every subterm of an expression typed under context [G] must be
      typed under exactly [G].
    - Answer whether every subterm must be typed under some context.
    - Give binding counterexamples that distinguish the two claims.

    FINISH

    Run: [opam exec -- dune exec exercises/e36_parser_orientation.exe]

    Reading fallback: https://cs3110.github.io/textbook/chapters/interp/parsing.html

    Source coverage: parse; simpl ids; times parsing; infer; subexpression types;
    typing. *)

type token =
  | TInt_lit of int
  | TIdent of string
  | TPlus
  | TTimes
  | TLparen
  | TRparen
  | TEnd

type expr = Int of int | Var of string | Add of expr * expr | Mul of expr * expr
type phase_error = Lex_error of int * string | Parse_error of int * string

let lex (_source : string) : (token list, phase_error) result = failwith "TODO"

type cursor = { tokens : token array; mutable position : int }

let peek cursor =
  if cursor.position < Array.length cursor.tokens then cursor.tokens.(cursor.position)
  else TEnd

let consume cursor =
  let token = peek cursor in
  cursor.position <- cursor.position + 1;
  token

let rec parse_sum (_cursor : cursor) : (expr, phase_error) result = failwith "TODO"
and parse_product (_cursor : cursor) : (expr, phase_error) result = failwith "TODO"
and parse_atom (_cursor : cursor) : (expr, phase_error) result = failwith "TODO"

let parse (_source : string) : (expr, phase_error) result =
  failwith "TODO: lex then require TEnd"

type typ = TInt | TBool

type typed_expr =
  | EInt of int
  | EBool of bool
  | EVar of string
  | EAdd of typed_expr * typed_expr
  | ELeq of typed_expr * typed_expr
  | EIf of typed_expr * typed_expr * typed_expr
  | ELet of string * typed_expr * typed_expr

type type_error = Unbound of string | Expected_int | Expected_bool | Branch_mismatch

let rec infer (_context : (string * typ) list) (_expression : typed_expr) :
    (typ, type_error) result =
  failwith "TODO"

(* IDENTIFIER DIFFERENCES: ...
   PHASE CLASSIFICATION: ...
   TYPING DERIVATION for [let x=0 in if x<=1 then 22 else 42]: ...
   SUBEXPRESSION ANSWER: ... *)

let () =
  assert (parse "1 + 2 * 3" = Ok (Add (Int 1, Mul (Int 2, Int 3))));
  assert (parse "1*2*3" = Ok (Mul (Mul (Int 1, Int 2), Int 3)));
  assert (
    match parse "3+" with
    | Error (Parse_error _) -> true
    | Error (Lex_error _) | Ok _ -> false);
  let sample = ELet ("x", EInt 0, EIf (ELeq (EVar "x", EInt 1), EInt 22, EInt 42)) in
  assert (infer [] sample = Ok TInt);
  assert (infer [] (EAdd (EInt 1, EBool true)) = Error Expected_int);
  print_endline "E36 complete"

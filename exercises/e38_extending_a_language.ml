(** E38 — Extend an interpreter vertically (45-50 min)

    OUTCOME

    Carry a language feature through parsing, typing, pattern matching, and evaluation
    without leaving the interpreter inconsistent.

    STEP 1 — SPECIFY THE FEATURE BEFORE IMPLEMENTING IT

    - Inspect the existing pairs, sums, and generalized-pattern constructors.
    - Write the typing rule for each new expression form.
    - Write the big-step evaluation rule for each new expression form.
    - Predict which functions below must change when a new form is added.

    STEP 2 — PARSE PAIRS

    - Implement [parse_pair] for tokenized [(expr, expr)].
    - Require the parentheses.
    - Reject trailing input.
    - Keep the parser deliberately small: this step tests feature plumbing, not
      parser-generator syntax.

    STEP 3 — MATCH GENERALIZED PATTERNS

    - Implement [match_pattern].
    - Combine bindings from compound patterns left-to-right.
    - Reject any pattern that binds the same variable twice.
    - Debug with the provided duplicate-binder assertion before continuing.

    STEP 4 — TYPE AND EVALUATE THE NEW FORMS

    - Implement [infer] for pairs, sums, and matches.
    - Implement [eval] for the same forms.
    - Match branches in source order and use the first successful branch.
    - Return a structured runtime error when no branch matches.

    STEP 5 — DESUGAR LISTS

    - Preserve the encoding [[] -> Left 0].
    - Preserve the encoding [[h; ...] -> Right (h, t)].
    - Build the source-level [not_empty] expression.
    - Run it on [[]] and [[1]], predicting both encoded values before evaluation.

    STEP 6 — TRANSFER BY ADDING PROJECTIONS

    - Add first and second projection forms through every affected interpreter layer.
    - Compile after each layer change.
    - Record every compiler warning that identifies an omitted layer.

    FINISH

    Run: [opam exec -- dune exec exercises/e38_extending_a_language.exe]

    Source coverage: pair parsing; pair type checking; pair evaluation; desugar list;
    list not empty; generalize patterns. *)

type typ = TInt | TPair of typ * typ | TSum of typ * typ

type pattern =
  | PInt of int
  | PPair of pattern * pattern
  | PLeft of pattern
  | PRight of pattern
  | PVar of string
  | PWildcard

type expr =
  | Int of int
  | Var of string
  | Add of expr * expr
  | Pair of expr * expr
  | Left of expr
  | Right of expr
  | Match of expr * (pattern * expr) list

type value = VInt of int | VPair of value * value | VLeft of value | VRight of value
type token = Lparen | Rparen | Comma | Int_lit of int

let parse_pair (_tokens : token list) : (expr, string) result = failwith "TODO"

let match_pattern (_pattern : pattern) (_value : value) : (string * value) list option =
  failwith "TODO: reject duplicate binders"

let rec infer (_context : (string * typ) list) (_expression : expr) :
    (typ, string) result =
  failwith "TODO"

let rec eval (_environment : (string * value) list) (_expression : expr) :
    (value, string) result =
  failwith "TODO"

let rec desugar_list = function
  | [] -> Left (Int 0)
  | head :: tail -> Right (Pair (head, desugar_list tail))

let not_empty = Match (Var "xs", [ (PLeft PWildcard, Int 0); (PRight PWildcard, Int 1) ])

(* TYPING RULES: ...
   EVALUATION RULES: ... *)

let () =
  assert (
    parse_pair [ Lparen; Int_lit 1; Comma; Int_lit 2; Rparen ]
    = Ok (Pair (Int 1, Int 2)));
  assert (
    match_pattern (PPair (PVar "x", PInt 2)) (VPair (VInt 1, VInt 2))
    = Some [ ("x", VInt 1) ]);
  assert (match_pattern (PPair (PVar "x", PVar "x")) (VPair (VInt 1, VInt 1)) = None);
  assert (infer [] (Pair (Int 1, Left (Int 2))) = Ok (TPair (TInt, TSum (TInt, TInt))));
  assert (eval [ ("xs", VLeft (VInt 0)) ] not_empty = Ok (VInt 0));
  assert (
    eval [ ("xs", VRight (VPair (VInt 1, VLeft (VInt 0)))) ] not_empty = Ok (VInt 1));
  print_endline "E38 complete"

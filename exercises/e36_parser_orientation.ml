(** E36 — SimPL parsing experiments and type judgments

    Main-file build:
    [opam exec -- dune build exercises/e36_parser_orientation.exe]
    Main-file run:
    [opam exec -- dune exec exercises/e36_parser_orientation.exe]

    The textbook tasks use the real ocamllex/Menhir SimPL projects under
    [exercises/e36_simpl_stages]. The handwritten front end later in this file
    is a project extension; it is not a replacement for those framework tasks.

    Reading:
    https://cs3110.github.io/textbook/chapters/interp/parsing.html *)

(* Task 1 — Textbook [parse]: run the baseline SimPL front end.
   Before running anything, predict the AST or failure phase for each input:
   ["22"], ["1 + 2 + 3"], ["let x = 2 in 20 + x"], ["3.14"], and
   ["3+"]. Record those predictions in this file.

   Then run exactly:
   [opam exec -- dune build @exercises/e36_simpl_stages/stage1_baseline/all]
   [opam exec -- dune exec exercises/e36_simpl_stages/stage1_baseline/check.exe]

   Record every reported AST. Explain why ["3.14"] fails in ocamllex while
   ["3+"] reaches Menhir before failing. If an observation differs from your
   prediction, identify the first mistaken assumption. Build the main file
   before continuing. *)

(* Task 2 — Textbook [simpl ids]: inspect the lexer rule that actually runs.
   Open [exercises/e36_simpl_stages/stage1_baseline/lexer.mll]. Locate [letter]
   and [id], and translate the [id] regular expression into plain English.
   Compare it with OCaml identifiers and record at least one concrete string
   accepted by one language but not the other. Do not answer this from the
   handwritten extension below: its intentionally broader rule is different.

   Rebuild the baseline stage after any experiment, restore [lexer.mll], and
   build the main file before continuing. *)

(* Task 3 — Textbook [times parsing]: change real Menhir declarations.
   First predict the baseline AST for ["1*2*3"]. Run the stage-1 checker and
   record the observation.

   Stage 2 differs at the associativity declaration for [TIMES]: it uses
   [%right] where the baseline uses [%left]. Before running it, predict the new
   AST. Then run:
   [opam exec -- dune build @exercises/e36_simpl_stages/stage2_right_assoc/all]
   [opam exec -- dune exec exercises/e36_simpl_stages/stage2_right_assoc/check.exe]
   Record exactly how the tree changed.

   Next predict the baseline AST for ["1+2*3"]. Stage 3 swaps the order of the
   [%left PLUS] and [%left TIMES] declarations, making PLUS higher precedence.
   Predict the changed AST, then run:
   [opam exec -- dune build @exercises/e36_simpl_stages/stage3_swapped_precedence/all]
   [opam exec -- dune exec exercises/e36_simpl_stages/stage3_swapped_precedence/check.exe]
   Record exactly how the tree changed.

   Inspect all three [parser.mly] files and confirm that stage 1 still contains
   the original declarations. Build the main file before continuing. *)

(* Task 4 — Textbook [infer]: compose the existing SimPL phases.
   Launch the real baseline library:
   [opam exec -- dune utop exercises/e36_simpl_stages/stage1_baseline]

   In utop, open [Simpl_baseline]. Define
   [infer : string -> Typecheck.typ] by parsing the source with [Driver.parse]
   and passing its AST to [Typecheck.typeof] in [Typecheck.empty]. Do not write a
   new lexer, parser, or type checker for this task.

   Predict and evaluate [infer "3110"], [infer "1 <= 2"], and
   [infer "let x = 2 in 20 + x"]. Record the inferred types and explain why no
   constraint collection or unification is needed for SimPL. Build the main
   file before continuing. *)

(* Task 5 — Textbook [subexpression types].
   In comments, answer both questions precisely. If an expression is well typed
   in context [ctx], must every subexpression be well typed in that same [ctx]?
   Does every subexpression have some context in which it is well typed? Give a
   concrete binder example and name the context required by its bound variable.
   Build the main file before continuing. *)

(* Task 6 — Textbook [typing].
   Draw a complete, rule-labelled derivation of
   [{} |- let x = 0 in if x <= 1 then 22 else 42 : int]. Show the context and
   type in every judgment, including each premise. A final judgment without the
   derivation tree does not complete this task. Build before continuing. *)

(* Task 7 — Project extension: define a handwritten SimPL representation.
   This and Tasks 8–11 are an additional recursive-descent implementation for
   contrast with ocamllex/Menhir. They do not cover Tasks 1–4 above.

   Define [token] with [TInt_lit of int], [TBool_lit of bool],
   [TIdent of string], [TPlus], [TTimes], [TLeq], [TEqual], [TLparen],
   [TRparen], [TLet], [TIn], [TIf], [TThen], [TElse], and [TEnd].

   Define [expr] with [Int], [Bool], [Var], [Add], [Mul], [Leq], [If], and
   [Let]. Define [phase_error] with [Lex_error of int * string] and
   [Parse_error of int * string]. Positions are zero-based character or token
   indices. Assert the exact AST [Add (Int 1, Mul (Int 2, Int 3))]. Build and
   run before continuing. *)

(* Task 8 — Project extension: write the handwritten lexer.
   Define [lex source]. Skip spaces, tabs, and newlines. Recognize nonnegative
   decimal integers and identifiers that begin with an ASCII letter and continue
   with letters, digits, or underscore. Recognize [let], [in], [if], [then],
   [else], [true], and [false] as keywords. Recognize [+], [*], [(], [)], [=],
   and the two-character token [<=]. Append exactly one [TEnd]. Return
   [Lex_error (position, text)] on the first other character.

   Assert exact token lists for ["x + 12*(y_2)"] and
   ["let x = 2 in if x <= 3 then true else false"]. Assert that ["3.14"]
   reports the dot at character 1. Explain why this identifier rule is broader
   than the textbook SimPL ocamllex rule inspected in Task 2. Build and run. *)

(* Task 9 — Project extension: write one staged recursive-descent parser.
   Define [cursor = { tokens : token array; mutable position : int }], [peek],
   and [consume]. Then define [parse_expr], [parse_comparison], [parse_sum],
   [parse_product], and [parse_atom] in one mutually recursive group for:

   [expr       ::= let identifier = expr in expr
                 | if expr then expr else expr
                 | comparison]
   [comparison ::= sum | sum <= sum]
   [sum        ::= product (+ product)*]
   [product    ::= atom (TIMES atom)*]
   [atom       ::= integer | Boolean | identifier | ( expr )]

   Addition and multiplication are left associative, multiplication binds more
   tightly, and comparison is non-associative. Return a [Parse_error] at the
   current token index with a message that names the missing token or atom.
   Assert exact results for direct token arrays representing [1*2*3], [1+2*3],
   a let, an if, and a missing right parenthesis. Build and run. *)

(* Task 10 — Project extension: connect the handwritten phases.
   Define [parse source] to call [lex], initialize a cursor, parse one expression,
   and require [TEnd]. Reject any remaining token as
   [Parse_error (position, "trailing input")].

   Assert exact results for ["22"], ["1 + 2 + 3"], ["1+2*3"],
   ["(1+2)*3"], and ["let x = 2 in 20 + x"]. Test ["3+"], ["1 2"], and a
   missing [in], including the error phase and position. Build and run. *)

(* Task 11 — Project extension: type-check the handwritten AST.
   Define [typ = TInt | TBool] and [type_error] with [Unbound of string],
   [Expected_int], [Expected_bool], and [Branch_mismatch]. Define
   [infer context expression] for newest-first string/type bindings. Arithmetic
   and [Leq] require integers; [Leq] returns Boolean; [If] requires a Boolean
   condition and equal branch types; [Let] extends the context only for its body.

   Define [front_end_error = Syntax of phase_error | Type of type_error] and
   [infer_source] by composing the handwritten [parse] and [infer]. Test every
   success and error constructor, syntax propagation, and shadowing. This adapted
   implementation is extra practice; the direct textbook [infer] was completed
   against [Simpl_baseline] in Task 4.

   After all required predictions, observations, explanations, derivations, and
   assertions are present, print exactly ["E36 passed"] once and not earlier.
   Build and run the main file. *)

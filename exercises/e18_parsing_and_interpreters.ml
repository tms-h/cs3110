open! Core

(* E18 — Parsing, semantics, and interpreters

   A single small language preserves the compiler/interpreter pipeline without
   the overhead of several staged projects or generated-parser plumbing. *)

(* Task 1 — Define syntax and values.
   Define an expression language with integers, booleans, variables, [let],
   conditionals, binary operators, functions, and application. Define runtime
   values and compute free variables. Derive sexps only where useful. *)

(* Task 2 — Tokenize and parse precedence.
   Write a tokenizer and recursive-descent parser with application tighter than
   arithmetic, arithmetic tighter than comparison, and explicit parentheses.
   Return located [Or_error] values for malformed input and trailing tokens. *)

(* Task 3 — Make substitution capture-avoiding.
   Implement fresh-name generation and substitution for the lambda fragment.
   Test shadowing and the classic case where naive substitution captures a free
   variable. State the substitution contract precisely. *)

(* Task 4 — Specify small-step evaluation.
   Implement one deterministic call-by-value step and a bounded trace runner.
   Distinguish values, reducible terms, stuck terms, and a trace that exceeded
   its fuel. Test evaluation order with a term whose alternate order gets stuck. *)

(* Task 5 — Implement lexical environments and closures.
   Write a big-step evaluator whose function values capture their defining
   environment. Add recursive functions through an explicit recursive binding.
   Demonstrate lexical rather than dynamic scope. *)

(* Task 6 — Extend the language coherently.
   Add pairs and projection (or one similarly bounded feature) through every
   layer: AST, parser, free variables, substitution, stepper, evaluator, and
   tests. Record the checklist that prevents a partial language extension.

   After all checks pass, print exactly [E18 passed] as the final output line. *)

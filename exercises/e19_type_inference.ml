open! Core

(* E19 — Constraint-based type inference

   This is the compact version of the original type-system block: it retains
   constraint generation, substitutions, unification, and occurs checks. *)

(* Task 1 — Represent types and substitutions.
   Define types for integers, booleans, variables, functions, and pairs.
   Implement free type variables and capture-free application/composition of
   substitutions. Test composition order explicitly. *)

(* Task 2 — Collect constraints.
   For variables, literals, binary operators, conditionals, functions,
   application, and pairs, generate a fresh result type plus equality
   constraints. Ensure each binder and unknown result receives a fresh type. *)

(* Task 3 — Unify safely.
   Implement unification with decomposition, substitution through remaining
   constraints, and an occurs check. Return contextual [Or_error] values for
   constructor mismatch and infinite types rather than raising [Failure]. *)

(* Task 4 — Infer monomorphic programs.
   Combine collection and unification, normalize variable names for stable
   output, and infer types for identity, composition, application, conditionals,
   and pair construction. Reject self-application through the occurs check. *)

(* Task 5 — Locate the boundary of the algorithm.
   Test one expression that requires let-polymorphism and explain why this
   monomorphic inferencer rejects it. Sketch where generalization and
   instantiation occur in Hindley–Milner; implement them only as an extension.

   After all checks pass, print exactly [E19 passed] as the final output line. *)

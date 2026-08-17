(** E40 — Unification and type inference (115-155 min)

    Build: [opam exec -- dune build exercises/e40_unification_and_inference.exe] Run:
    [opam exec -- dune exec exercises/e40_unification_and_inference.exe] Reading:
    https://cs3110.github.io/textbook/chapters/interp/inference.html *)

(* Task 1 — Define types and substitution primitives.
   Define [typ = TInt | TBool | TVar of int | TArrow of typ * typ],
   [substitution = (int * typ) list], [constraint_ = typ * typ], and
   [unify_error = Mismatch of typ * typ | Occurs of int * typ].

   Define [occurs variable typ]. Define [apply_subst substitution typ], applying
   mappings transitively so one call fully updates nested variables. Test base
   types, arrows, absent variables, a two-link substitution, and occurs results.
   Build and run before continuing. *)

(* Task 2 — Unify constraints.
   Define [unify constraints]. Remove equal pairs. Decompose equal arrow types
   into argument and result constraints. Bind a type variable only when it does
   not occur in the other type, applying each new binding to the remaining
   worklist and existing substitution. Return [Mismatch] for incompatible
   constructors and [Occurs] for infinite types.

   Test no constraints, one variable binding, chained bindings, arrow
   decomposition, int/bool mismatch, and [a = a -> int] occurs failure.
   Build and run before continuing. *)

(* Task 3 — Cross-check complete solutions.
   Define [satisfies substitution constraints] to return true when applying the
   substitution makes both sides of every constraint structurally equal.

   Manually solve [(a, int); (b, a -> bool)] and
   [(a -> b, int -> c); (c, bool)] in comments. Run [unify] on both and test the
   returned substitution satisfies the original system; do not assert list order.
   Build and run before continuing. *)

(* Task 4 — Collect inference constraints.
   Define [expr] with [Int], [Bool], [Var], [Fun], [App], and [If]. Define mutable
   [infer_state] with [next : int] and [fresh state] returning the next [TVar].

   Define [collect state context expression]. Int and Bool have fixed types;
   Var uses the newest context binding; Fun gives its parameter a fresh type;
   App gives its result a fresh type and adds [function_type = argument_type ->
   result_type]; If adds [condition_type = bool] and equality of branch types.
   Return [Error "unbound: name"] only for an absent variable.

   Test exact collected types and constraints for identity and one application.
   Build and run before continuing. *)

(* Task 5 — Infer monomorphic types.
   Define [infer expression] to create state starting at 0, call [collect], call
   [unify], and apply the resulting substitution to the collected type. Convert
   [Mismatch] and [Occurs] to descriptive Error strings while preserving the
   involved types in the text.

   Test integer, Boolean, identity, application, valid if, branch mismatch,
   non-Boolean condition, and unbound variable.
   Build and run before continuing. *)

(* Task 6 — Normalize printed type variables.
   Define [show_normalized typ]. Print [int], [bool], and arrows with [->]. Rename
   type variables by first left-to-right appearance as ['a], ['b], ... regardless
   of integer IDs. Arrows associate right; parenthesize an arrow on the left of
   another arrow.

   Test [TVar 9] prints ['a], [TArrow (TVar 9, TVar 2)] prints ['a -> 'b], and
   nested left versus right arrows receive the required parentheses.
   Build and run before continuing. *)

(* Task 7 — Infer classic combinators and reject self-application.
   Define [apply_expr = fun f -> fun x -> f x],
   [double_expr = fun f -> fun x -> f (f x)], and
   [s_expr = fun x -> fun y -> fun z -> x z (y z)] in the AST.

   Define [inferred_string expression] by composing [infer] and [show_normalized].
   Test exact results [('a -> 'b) -> 'a -> 'b] for apply and
   [('a -> 'a) -> 'a -> 'a] for double; test S succeeds. Define
   [omega_half = fun x -> x x] and test inference returns an occurs-check Error.
   Build and run before continuing. *)

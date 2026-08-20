(** E40 — Unification and type inference (145-200 min)

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
   State the precondition that an input substitution is acyclic; [unify] must
   maintain that precondition with its occurs check.
   Example form: [let rec has x = function Tip -> false | Fork (l, y, r) -> x = y || has x l || has x r]
   Build and run before continuing. *)

(* Task 2 — Unify constraints.
   Define [unify constraints]. Remove equal pairs. Decompose equal arrow types
   into argument and result constraints. Bind a type variable only when it does
   not occur in the other type, applying each new binding to the remaining
   worklist and existing substitution. Return [Mismatch] for incompatible
   constructors and [Occurs] for infinite types.

   Test no constraints, one variable binding, chained bindings, arrow
   decomposition, int/bool mismatch, and [a = a -> int] occurs failure.
   Example form: [match left, right with Pair (a, b), Pair (c, d) -> compare_parts [(a, c); (b, d)] | _ -> compare_leaf left right]
   Build and run before continuing. *)

(* Task 3 — Solve the textbook systems and cross-check complete solutions.
   Define [satisfies substitution constraints] to return true when applying the
   substitution makes both sides of every constraint structurally equal.

   Manually run the unification algorithm on the two textbook systems, recording
   the worklist and composed substitution after every step:

   1. [X = int; Y = X -> X]
   2. [X -> Y = Y -> Z; Z = U -> W]

   Run [unify] on both and test the returned substitution satisfies the original
   system; do not assert association-list order. As extension regressions, also
   solve and test [(a, int); (b, a -> bool)] and
   [(a -> b, int -> c); (c, bool)].
   Example form: [List.for_all (fun (input, expected) -> run candidate input = expected) examples]
   Build and run before continuing. *)

(* Task 4 — Derive and collect inference constraints.
   Define [expr] with [Int], [Bool], [Var], [Fun], [App], and [If]. Define mutable
   [infer_state] with [next : int] and [fresh state] returning the next [TVar].

   Before coding, show the complete rule-labelled [environment |- expression :
   type -| constraints] derivation for each textbook expression:

   1. [fun x -> (+) 1 x]
   2. [fun b -> if b then false else true]
   3. [fun x -> fun y -> if x <= y then y else x]

   Treat [(+)] as [int -> int -> int] and [(<=)] as
   [int -> int -> bool], and show every fresh type variable and generated
   constraint. This written checkpoint may use operators not present in the
   executable AST below.

   Define [collect_error = Unbound of string] and
   [collect state context expression]. Int and Bool have fixed types;
   Var uses the newest context binding; Fun gives its parameter a fresh type;
   App gives its result a fresh type and adds [function_type = argument_type ->
   result_type]; If adds [condition_type = bool] and equality of branch types.
   Return [Error (Unbound name)] only for an absent variable.

   Make allocation and list order deterministic: Fun allocates its parameter
   before collecting its body; App collects function then argument, allocates its
   result, and appends the application constraint after child constraints; If
   collects condition, then branch, and else branch in that order, then appends
   the Boolean-condition and branch-equality constraints.

   Test exact collected types and constraints for identity and one application.
   Example form: [let next_ticket dispenser = let ticket = dispenser.current in dispenser.current <- ticket + 1; ticket]
   Build and run before continuing. *)

(* Task 5 — Infer monomorphic types with structural errors.
   Define [infer_error = Collect of collect_error | Unify of unify_error].
   Define [infer expression] to create state starting at 0, call [collect], call
   [unify], and apply the resulting substitution to the collected type. Preserve
   collection and unification failures structurally; do not render them to strings
   before Task 6 defines a type printer.

   Test integer, Boolean, identity, application, valid if, branch mismatch,
   non-Boolean condition, and unbound variable.
   Example form: [Result.bind (load path) (fun text -> Result.map parse_document (validate text))]
   Build and run before continuing. *)

(* Task 6 — Normalize printed type variables.
   Define [show_normalized typ]. Print [int], [bool], and arrows with [->]. Rename
   type variables by first left-to-right appearance as ['a], ['b], ... regardless
   of integer IDs. Arrows associate right; parenthesize an arrow on the left of
   another arrow. After ['z], continue with ['a1] through ['z1], then ['a2], so
   every finite type has a defined rendering.

   Define [show_infer_error] here, using one shared variable-renaming environment
   across all types in an error. Render [Mismatch (left, right)] exactly as
   ["mismatch: <left> vs <right>"] and [Occurs (variable, typ)] exactly as
   ["occurs: <variable> in <type>"], replacing angle-bracketed fields by their
   normalized renderings. This gives error-text tests one canonical format.

   Test [TVar 9] prints ['a], [TArrow (TVar 9, TVar 2)] prints ['a -> 'b], and
   nested left versus right arrows receive the required parentheses.
   Example form: [let spreadsheet_column index = String.make 1 (Char.chr (Char.code 'A' + index))]
   Build and run before continuing. *)

(* Task 7 — Infer classic combinators and reject self-application.
   Define [apply_expr = fun f -> fun x -> f x],
   [double_expr = fun f -> fun x -> f (f x)], and
   [s_expr = fun x -> fun y -> fun z -> x z (y z)] in the AST.

   Define [inferred_string expression] by composing [infer] and [show_normalized].
   Test exact results [('a -> 'b) -> 'a -> 'b] for apply and
   [('a -> 'a) -> 'a -> 'a] for double, and
   [('a -> 'b -> 'c) -> ('a -> 'b) -> 'a -> 'c] for S. Define
   [omega_half = fun x -> x x] and test inference returns an occurs-check Error.
   Example form: [let compose_ast = Fun ("f", Fun ("g", Fun ("x", App (Var "f", App (Var "g", Var "x")))))]
   After every required derivation, unification trace, exact type, and assertion in
   E40 is present and passing, print the exact line ["E40 passed"] once, and not
   earlier.
   Build and run before continuing. *)

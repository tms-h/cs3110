(** E37 — Capture avoidance and small-step evaluation (110-150 min)

    Build: [opam exec -- dune build exercises/e37_substitution_and_small_step.exe] Run:
    [opam exec -- dune exec exercises/e37_substitution_and_small_step.exe] Reading:
    https://cs3110.github.io/textbook/chapters/interp/substitution.html *)

(* Task 1 — Define syntax and free variables.
   Define [String_set = Set.Make (String)]. Define [expr] with [Int], [Bool],
   [Var], [Add], [Mul], [Leq], [If], [Let], [Fun], [App], [Left], [Right], and
   [Match of expr * (string * expr) * (string * expr)]. Let and Fun bind one name;
   each Match branch binds its own name.

   Define [free_vars expression]. Test a closed function, a let with shadowing,
   and a match whose two branch bodies contain different free names.
   Build and run before continuing. *)

(* Task 2 — Generate deterministic fresh names.
   Define [fresh_avoiding base forbidden]. Return [base] if it is absent;
   otherwise try [base_1], [base_2], and so on, returning the first absent name.

   Test an empty set, a set containing only ["x"], and a set containing ["x"],
   ["x_1"], and ["x_2"].
   Build and run before continuing. *)

(* Task 3 — Substitute without capture.
   Define [subst replacement variable expression]. Replace free occurrences of
   [variable]. Do not enter a binder for the same name. When another binder name
   is free in [replacement] and substitution must enter its body, alpha-rename
   that binder with [fresh_avoiding] before continuing. Apply this rule to Let,
   Fun, and each Match branch.

   Test ordinary arithmetic substitution, shadowing, no occurrence, and replacing
   x by y in [fun y -> x + y], expecting a fresh binder such as [y_1] while y
   remains free.
   Build and run before continuing. *)

(* Task 4 — Define call-by-value values and one step.
   Define [exception Stuck of expr]. Define [is_value] to recognize integers,
   Booleans, functions, and [Left value] or [Right value]. Define [step] with
   left-to-right call-by-value rules:

   - Add, Mul, and Leq evaluate operands then operate on integers.
   - If evaluates its condition, then selects on a Boolean.
   - Let evaluates its bound expression, then substitutes a value into the body.
   - App evaluates function then argument, then beta-reduces a [Fun].
   - Left and Right evaluate their payload.
   - Match evaluates its scrutinee, then substitutes the payload into the selected
     branch.

   Return [None] only for a value; raise [Stuck expression] for any nonvalue with
   no rule. Test one rule from each group, one value, and one stuck addition.
   Build and run before continuing. *)

(* Task 5 — Produce bounded traces.
   Define [trace ~fuel expression] to return a list beginning with [expression].
   Repeatedly append successful [step] results. Stop at a value, at [Stuck], or
   after exactly [fuel] successful steps. Raise [Invalid_argument "fuel"] for
   negative fuel. Thus a diverging term with fuel 5 returns six states.

   Test the complete trace of [let x = 2+2 in x+x] ends at 8, a value produces
   a singleton trace, and a stuck expression remains the final state.
   Build and run before continuing. *)

(* Task 6 — Trace self-application.
   Define [omega] as [(fun x -> x x) (fun x -> x x)] in the AST. Test
   [trace ~fuel:5 omega] has length 6 and every successful step returns the same
   AST. Explain why this untyped term diverges while OCaml rejects its analogous
   source type.
   Build and run before continuing. *)

(* Task 7 — Inline a value used once.
   Define [free_occurrences variable expression] to count free occurrences.
   Define [inline_once expression] recursively; for
   [Let (x, value, body)] where [is_value value] and x occurs freely exactly once
   in body, replace the let by capture-avoiding substitution. Preserve other lets.

   Test one successful inline, a body using x twice, a nonvalue binding, and a
   case requiring alpha-renaming. Test original and transformed programs reach
   the same final value with [trace].
   Build and run before continuing. *)

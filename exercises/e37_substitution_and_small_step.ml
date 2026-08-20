(** E37 — Capture avoidance and small-step evaluation (150-210 min)

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
   Example form: [let names = String_set.union left_names right_names]
   Build and run before continuing. *)

(* Task 2 — Generate deterministic fresh names.
   Define [fresh_avoiding base forbidden]. Return [base] if it is absent;
   otherwise try [base_1], [base_2], and so on, returning the first absent name.

   Test an empty set, a set containing only ["x"], and a set containing ["x"],
   ["x_1"], and ["x_2"].
   Example form: [let candidate = if suffix = 0 then base else base ^ "_" ^ string_of_int suffix]
   Build and run before continuing. *)

(* Task 3 — Substitute without capture.
   Before implementing [subst], manually compute all eight source substitutions
   below and record their resulting expressions in comments. Do not use code to
   generate the answers first. Preserve those written predictions, then use the
   implementation and assertions only to cross-check them.

   Define [subst replacement variable expression]. Replace free occurrences of
   [variable]. Do not enter a binder for the same name. When another binder name
   is free in [replacement] and substitution must enter its body, alpha-rename
   that binder with [fresh_avoiding] before continuing. The forbidden set for a
   new binder must include every variable occurring in the body, every free
   variable of [replacement], and the substitution target itself. Apply this rule
   to Let, Fun, and each Match branch; remember that a Let binder scopes only its
   body, not its bound expression.

   Compute and then test the exact eight textbook substitutions:

   - [(x + 1){2/x}]
   - [(x + y){2/x}{3/y}]
   - [(x + y){1/z}]
   - [(let x = 1 in x + 1){2/x}]
   - [(x + (let x = 1 in x + 1)){2/x}]
   - [((let x = 1 in x + 1) + x){2/x}]
   - [(let x = y in x + 1){2/y}]
   - [(let x = x in x + 1){2/x}]

   Also test replacing x by y in [fun y -> x + y], expecting [y_1] while y
   remains free.
   Example form: [match term with Name x when x = target -> replacement | Lambda (x, body) when x = target -> term | _ -> recurse term]
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
   Example form: [match term with Plus (Number a, Number b) -> Some (Number (a + b)) | other -> reduce_child other]
   Build and run before continuing. *)

(* Task 5 — Produce bounded traces and explain every source transition.
   Define [trace ~fuel expression] to return a list beginning with [expression].
   Repeatedly append successful [step] results. Stop at a value, at [Stuck], or
   after exactly [fuel] successful steps. Raise [Invalid_argument "fuel"] for
   negative fuel. Thus a diverging term with fuel 5 returns six states.

   Test the complete trace of [let x = 2+2 in x+x] ends at 8, a value produces
   a singleton trace, and a stuck expression remains the final state.
   Example accumulator contract: [loop remaining current rev_states] returns the
   visited states in forward order, including [current].

   Source checkpoint: in comments, write complete small-step traces for every
   expression below. Label every arrow with the rule used and assert that [trace]
   produces the same AST states. Preserve the stated left-to-right order.

   - [(3 + 5) * 2]
   - [if 2 + 3 <= 4 then 1 + 1 else 2 + 2]
   - [let x = 2 + 2 in x + x]
   - [let x = 5 in (let x = 6 in x) + x]
   - [let x = 1 in let x = x + x in x + x]
   - [Left (1 + 2)]
   - [match Left 42 with Left x -> x+1 | Right y -> y-1]
   - [(fun x -> 3 + x) 2]
   - [let f = fun x -> x+x in f 3 + f 3]
   - [let f = fun x -> x+x in let x=1 in
      let g = fun y -> x + f y in g 3]
   - [let f = fun x -> fun y -> x+y in
      let g = f 3 in g 1 + f 2 3]
   Build and run before continuing. *)

(* Task 6 — Trace self-application.
   Define [omega] as [(fun x -> x x) (fun x -> x x)] in the AST. Test
   [trace ~fuel:5 omega] has length 6 and every successful step returns the same
   AST. Explain why this untyped term diverges while OCaml rejects its analogous
   source type.
   Example form: [let ordinary_application = App (Fun ("z", Var "z"), Int 7)]
   Build and run before continuing. *)

(* Extension Task 7 — Inline single-use values.
   Define [free_occurrences variable expression] to count free occurrences.
   Define [inline_single_use_lets expression] as a bottom-up traversal; for
   [Let (x, value, body)] where [is_value value] and x occurs freely exactly once
   in the already-transformed body, replace the let by capture-avoiding
   substitution. Transform every eligible let encountered, not merely the first
   one in the whole tree. Recursively transform both a let's bound expression and
   its body before deciding whether that let is eligible. Preserve other lets.

   Test one successful inline, a body using x twice, a nonvalue binding, and a
   case requiring alpha-renaming. Test original and transformed programs reach
   the same final value with [trace] using enough explicit fuel for both.
   Example form: [match term with Bind (name, value, body) when used_once name body -> replace value name body | _ -> term]
   After every required substitution, labelled trace, explanation, and assertion
   in E37 is present and passing, print the exact line ["E37 passed"] once, and
   not earlier.
   Build and run before continuing. *)

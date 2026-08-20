(** E39 — Environments, closures, and recursion (180-250 min)

    Build: [opam exec -- dune build exercises/e39_environments_and_recursion.exe] Run:
    [opam exec -- dune exec exercises/e39_environments_and_recursion.exe] *)

(* Source checkpoint 1 — Repair [let rec] in the substitution model.
   In comments, first explain why the tempting rule
   [let rec f = value in body --> body{value/f}] forgets the recursive binding.
   Extend the paper syntax with [rec f -> expression], state the unfolding rule
   [rec f -> expression --> expression{(rec f -> expression)/f}], and state the
   desugaring of [let rec f = definition in body] through [rec].

   Write both capture-avoiding substitution rules for [rec], including their
   freshness side condition. Then give the complete rule-labelled small-step
   evaluation of recursive factorial applied to 3. Use [F] as an abbreviation for
   the repeated recursive term if desired, but show every one of the textbook's
   approximately 17 transitions and each substitution. This is a written source
   exercise; do not add [rec] to the environment interpreter below.
   Build and run before continuing. *)

(* Task 2 — Define expression and runtime types.
   Define the complete syntax and runtime representation up front, including the
   mutually recursive group forms reserved for Task 7:

   [type expr =
      | Int of int
      | Var of string
      | Add of expr * expr
      | Mul of expr * expr
      | If_zero of expr * expr * expr
      | Let of string * expr * expr
      | Fun of string * expr
      | App of expr * expr
      | Let_rec of string * string * expr * expr
      | Let_rec_group of definition list * expr
    and definition = string * string * expr
    and value =
      | VInt of int
      | VClosure of environment * string * expr
      | VRec_closure of environment * string * string * expr
      | VRec_group_closure of
          environment * definition list * string * string * expr
    and environment = (string * value) list]

   A [definition] triple is [(function_name, parameter, function_body)]. The
   [VRec_group_closure] fields are the saved environment, the entire group, the
   closure's own function name, its parameter, and its body. Declare these forms
   now because OCaml variants and mutually recursive type groups cannot be
   reopened in Task 7. Until that task, earlier evaluator stages may return
   [Expected_function] for [Let_rec_group]. Define [runtime_error] with
   [Unbound of string], [Expected_int], and [Expected_function].

   Construct and test the AST for [let x = 2 in x + 3].
   Example form: [type term = Number of int | Name of string | Bind of string * term * term]
   Build and run before continuing. *)

(* Task 3 — Derive and evaluate first-order expressions.
   Begin [eval environment expression]. Integers return [VInt]. Variables use the
   first binding or [Unbound name]. Add and Mul evaluate left-to-right and require
   integers. [If_zero (condition, yes, no)] requires an integer and selects [yes]
   exactly for zero. Let evaluates its bound expression then extends the
   environment for its body.

   Test arithmetic, shadowing, both branches, an unbound variable, and each
   integer-type error.

   Source checkpoint: in comments, draw complete rule-labelled big-step trees for
   [110 + 3*1000], [if 2+3 < 4 then 1+1 else 2+2], [let x=0 in 1],
   [let x=2 in x+1], and
   [match Left 2 with Left x -> x+1 | Right x -> x-1]. Show the environment at
   every premise. These written trees use the textbook's full Core OCaml syntax;
   do not add comparison or variants merely to make them executable here.
   Example form: [match expression with Number n -> Ok (Number_value n) | Name x -> lookup x environment]
   Build and run before continuing. *)

(* Task 4 — Derive and evaluate lexical closures.
   Extend [eval] so [Fun (parameter, body)] returns [VClosure] containing the
   definition environment. App evaluates function then argument; applying a
   closure evaluates its body in the saved environment extended with the
   parameter binding. Nonclosures produce [Expected_function].

   Define [lexical_scope_probe] for
   [let x=5 in let f y=x+y in let x=4 in f 3]. Test it returns [VInt 8], then
   test a higher-order application and applying an integer.

   Source checkpoint: draw rule-labelled big-step trees for
   [(fun x -> x+1) 2], [let f=fun x -> x+1 in f 2],
   [let x=0 in x + (let x=1 in x)], and [lexical_scope_probe]. Then evaluate and
   label the four textbook "more evaluation" examples:
   [let x = 2 + 2 in x + x];
   [let x = 1 in let x = x + x in x + x];
   [let f = fun x -> fun y -> x + y in let g = f 3 in g 2]; and
   [let f = fst ((let x = 3 in fun y -> x), 2) in f 0].
   The last is written work only because this small executable language has no
   pairs.
   Example form: [match expression with Lambda (parameter, body) -> Ok (Closure (environment, parameter, body)) | _ -> other_cases ()]
   Build and run before continuing. *)

(* Extension Task 5 — Evaluate recursive closures.
   Extend [eval] for [Let_rec (name, parameter, function_body, in_body)]. Bind
   [name] to a [VRec_closure] saving the current environment. On application,
   evaluate the function body in that saved environment extended first with the
   recursive self-binding and then the parameter.

   Define [factorial_3] with [If_zero] and subtraction represented as addition of
   a negative integer. Test it returns [VInt 6], and test a zero input returns 1.
   Example form: [let saved_function = Recursive_closure (saved_scope, label, parameter, body)]
   Build and run before continuing. *)

(* Task 6 — Implement dynamic scope deliberately.
   Define [dynamic_value] with [DInt], [DClosure of parameter * body], and
   [DRec_closure of name * parameter * body]. Define [eval_dynamic] with the same
   rules as [eval] except closures save no environment and application extends the
   caller environment.

   Test [lexical_scope_probe] returns [DInt 7]. Encode and test the textbook's two
   additional programs exactly:

   1. [let x=5 in let f y=x+y in let g x=f x in let x=4 in g 3]
   2. [let f y=x+y in let x=3 in let y=4 in f 2]

   Record both lexical and dynamic results. In particular, do not replace the
   second example with an easier shadowing case: its free x at function definition
   is the point, and lexical evaluation must report [Unbound "x"].
   Example form: [let dynamic_function = Dynamic_closure (parameter, body)]
   Build and run before continuing. *)

(* Extension Task 7 — Implement mutually recursive groups.
   Implement the [Let_rec_group] and [VRec_group_closure] forms declared in Task
   2. Evaluating a group binds every name to a closure carrying the same saved
   environment and complete definition group. Applying one of those closures
   reconstructs all group bindings before adding the parameter binding.

   Define mutually recursive [even] and [odd] over nonnegative integers using
   [If_zero] and decrement by one. Test even 10 and odd 9 return 1, while even 9
   and odd 10 return 0.
   Example form: [let names = List.map (fun (name, _, _) -> name) declarations]
   After every required small-step trace, big-step derivation, scope explanation,
   and assertion in E39 is present and passing, print the exact line
   ["E39 passed"] once, and not earlier.
   Build and run before continuing. *)

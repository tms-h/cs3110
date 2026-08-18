(** E39 — Environments, closures, and recursion (105-145 min)

    Build: [opam exec -- dune build exercises/e39_environments_and_recursion.exe] Run:
    [opam exec -- dune exec exercises/e39_environments_and_recursion.exe] *)

(* Task 1 — Define expression and runtime types.
   Define [expr] with [Int], [Var], [Add], [Mul], [If_zero], [Let], [Fun], [App],
   and [Let_rec of function_name * parameter * function_body * in_body]. Define
   mutually recursive [value] and [environment]: values are [VInt],
   [VClosure of environment * parameter * body], or
   [VRec_closure of environment * function_name * parameter * body]; an
   environment is a newest-first string/value list. Define [runtime_error] with
   [Unbound], [Expected_int], and [Expected_function].

   Construct and test the AST for [let x = 2 in x + 3].
   Example form: [type term = Number of int | Name of string | Bind of string * term * term]
   Build and run before continuing. *)

(* Task 2 — Evaluate first-order expressions.
   Begin [eval environment expression]. Integers return [VInt]. Variables use the
   first binding or [Unbound name]. Add and Mul evaluate left-to-right and require
   integers. [If_zero (condition, yes, no)] requires an integer and selects [yes]
   exactly for zero. Let evaluates its bound expression then extends the
   environment for its body.

   Test arithmetic, shadowing, both branches, an unbound variable, and each
   integer-type error.
   Example form: [match expression with Number n -> Ok (Number_value n) | Name x -> lookup x environment]
   Build and run before continuing. *)

(* Task 3 — Evaluate lexical closures.
   Extend [eval] so [Fun (parameter, body)] returns [VClosure] containing the
   definition environment. App evaluates function then argument; applying a
   closure evaluates its body in the saved environment extended with the
   parameter binding. Nonclosures produce [Expected_function].

   Define [lexical_scope_probe] for
   [let x=5 in let f y=x+y in let x=4 in f 3]. Test it returns [VInt 8], then
   test a higher-order application and applying an integer.
   Example form: [match expression with Lambda (parameter, body) -> Ok (Closure (environment, parameter, body)) | _ -> other_cases ()]
   Build and run before continuing. *)

(* Task 4 — Evaluate recursive closures.
   Extend [eval] for [Let_rec (name, parameter, function_body, in_body)]. Bind
   [name] to a [VRec_closure] saving the current environment. On application,
   evaluate the function body in that saved environment extended first with the
   recursive self-binding and then the parameter.

   Define [factorial_3] with [If_zero] and subtraction represented as addition of
   a negative integer. Test it returns [VInt 6], and test a zero input returns 1.
   Example form: [let saved_function = Recursive_closure (saved_scope, label, parameter, body)]
   Build and run before continuing. *)

(* Task 5 — Implement dynamic scope deliberately.
   Define [dynamic_value] with [DInt], [DClosure of parameter * body], and
   [DRec_closure of name * parameter * body]. Define [eval_dynamic] with the same
   rules as [eval] except closures save no environment and application extends the
   caller environment.

   Test [lexical_scope_probe] returns [DInt 7]. Add two more nested-shadowing
   programs and test both evaluators' exact, different results.
   Example form: [let dynamic_function = Dynamic_closure (parameter, body)]
   Build and run before continuing. *)

(* Task 6 — Add mutually recursive groups.
   Extend the syntax with mutually recursive declarations
   [and definition = string * string * expr] and constructor
   [Let_rec_group of definition list * expr]. Add a closure value carrying the
   saved environment, entire definition list, its own name, parameter, and body.
   Evaluating a group binds every name to a closure carrying the same group;
   application reconstructs all group bindings before the parameter binding.

   Define mutually recursive [even] and [odd] over nonnegative integers using
   [If_zero] and decrement by one. Test even 10 and odd 9 return 1, while even 9
   and odd 10 return 0.
   Example form: [let names = List.map (fun (name, _, _) -> name) declarations]
   Build and run before continuing. *)

(** E39 — Environments, closures, and recursion (45-50 min)

    OUTCOME

    Implement lexical closures and recursive bindings, then contrast them with dynamic
    scope using diagnostic programs.

    STEP 1 — DERIVE BIG-STEP EVALUATIONS ON PAPER

    - Draw one derivation tree for nested arithmetic.
    - Draw one derivation tree for a [let] expression with shadowing.
    - Label every rule application and every environment extension.

    STEP 2 — IMPLEMENT LEXICAL EVALUATION

    - Implement [eval] for nonrecursive expressions first.
    - When evaluating [Fun], save the definition environment in the closure.
    - When applying a closure, extend its saved environment, not the caller's.
    - Predict [lexical_scope_probe] before running its assertion.

    STEP 3 — ADD RECURSIVE CLOSURES

    - Implement [Let_rec].
    - Ensure the recursive closure regains a binding for its own name on every call.
    - Trace [factorial_3] by hand and count the big-step rule applications.
    - Run the assertion and use the first missing self-binding to diagnose recursion
      failures.

    STEP 4 — BUILD A DYNAMIC-SCOPE COUNTEREXAMPLE

    - Implement [eval_dynamic], using the caller environment at application.
    - Evaluate three shadowing programs with both evaluators.
    - Predict both results before running each program.
    - Explain every difference by naming the environment used for a free variable.

    STEP 5 — PERFORM A CONTROLLED BREAKAGE

    - Temporarily remove the saved environment from lexical closures.
    - Run the provided tests and identify the first failure.
    - Explain why that particular test isolates the closure-environment bug.
    - Restore the correct implementation.

    STEP 6 — DESIGN MUTUAL RECURSION

    - Either add mutual recursion or describe the value/environment representation
      change it requires.
    - Do not simulate recursive scope with global mutable state.

    FINISH

    Run: [opam exec -- dune exec exercises/e39_environments_and_recursion.exe]

    Source coverage: let rec; simple expressions; let and match expressions; closures;
    lexical scope and shadowing; more evaluation; dynamic scope; more dynamic scope. *)

type expr =
  | Int of int
  | Var of string
  | Add of expr * expr
  | Mul of expr * expr
  | If_zero of expr * expr * expr
  | Let of string * expr * expr
  | Fun of string * expr
  | App of expr * expr
  | Let_rec of string * string * expr * expr

type value =
  | VInt of int
  | VClosure of environment * string * expr
  | VRec_closure of environment * string * string * expr

and environment = (string * value) list

type runtime_error = Unbound of string | Expected_int | Expected_function

let rec eval (_environment : environment) (_expression : expr) :
    (value, runtime_error) result =
  failwith "TODO: lexical big-step"

type dynamic_value =
  | DInt of int
  | DClosure of string * expr
  | DRec_closure of string * string * expr

let rec eval_dynamic (_environment : (string * dynamic_value) list) (_expression : expr)
    : (dynamic_value, runtime_error) result =
  failwith "TODO: caller environment at application"

let lexical_scope_probe =
  Let
    ( "x",
      Int 5,
      Let
        ("f", Fun ("y", Add (Var "x", Var "y")), Let ("x", Int 4, App (Var "f", Int 3)))
    )

let factorial_3 =
  Let_rec
    ( "fact",
      "n",
      If_zero (Var "n", Int 1, Mul (Var "n", App (Var "fact", Add (Var "n", Int (-1))))),
      App (Var "fact", Int 3) )

(* BIG-STEP DERIVATIONS: ...
   LEXICAL VS DYNAMIC EXPLANATIONS: ...
   MUTUAL RECURSION DESIGN: ... *)

let () =
  assert (eval [] lexical_scope_probe = Ok (VInt 8));
  assert (eval_dynamic [] lexical_scope_probe = Ok (DInt 7));
  assert (eval [] factorial_3 = Ok (VInt 6));
  print_endline "E39 complete"

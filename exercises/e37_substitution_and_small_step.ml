(** E37 — Capture avoidance and small-step debugging (45-50 min)

    OUTCOME

    Implement capture-avoiding substitution and deterministic small-step evaluation,
    then use traces to distinguish values, stuck terms, and divergence.

    STEP 1 — SOLVE SUBSTITUTION ON PAPER

    - Work all eight substitution examples from the source section before coding.
    - Mark the free variables of the replacement in every example.
    - Mark exactly where a binder must be renamed to prevent capture.

    STEP 2 — IMPLEMENT CAPTURE AVOIDANCE

    - Implement [free_vars].
    - Implement [fresh_avoiding].
    - Implement [subst]. Rename binders only when necessary, and never capture a free
      variable of the replacement.
    - Run the provided capture case. If it fails, print the substituted AST and inspect
      the renamed binder before changing more code.

    STEP 3 — IMPLEMENT ONE EVALUATION STEP

    - Implement [is_value].
    - Implement one call-by-value [step] with left-to-right evaluation.
    - Return [None] only when the input is already a value.
    - Raise [Stuck expression] for a nonvalue with no applicable rule.
    - Test one reducible term, one value, and one stuck term separately.

    STEP 4 — PREDICT AND DEBUG TRACES

    - Implement [trace] with a fuel limit, including the initial and final or stuck AST.
    - Before running, write every intermediate AST for examples involving nested lets,
      variant matching, closures, and shadowing.
    - Compare the actual trace with the prediction and locate the first divergent step,
      not merely the wrong final value.

    STEP 5 — SEPARATE DIVERGENCE FROM TYPE REJECTION

    - Evaluate the provided [omega] with a small fuel limit.
    - Explain why the untyped semantics can keep stepping forever.
    - Explain why OCaml rejects the corresponding source during type checking.

    STEP 6 — TRANSFER TO AN OPTIMIZATION

    - Add a [Let] optimization that substitutes a value exactly once.
    - Construct a counterexample showing why naive textual replacement is unsound.
    - Confirm that the optimized evaluator preserves the original trace's final result
      on terminating examples.

    FINISH

    Run: [opam exec -- dune exec exercises/e37_substitution_and_small_step.exe]

    Reading fallback:
    https://cs3110.github.io/textbook/chapters/interp/substitution.html

    Source coverage: substitution; step expressions; step let expressions; variants;
    application; omega. *)

module String_set = Set.Make (String)

type expr =
  | Int of int
  | Bool of bool
  | Var of string
  | Add of expr * expr
  | Mul of expr * expr
  | Leq of expr * expr
  | If of expr * expr * expr
  | Let of string * expr * expr
  | Fun of string * expr
  | App of expr * expr
  | Left of expr
  | Right of expr
  | Match of expr * (string * expr) * (string * expr)

exception Stuck of expr

let _stuck_marker = Stuck (Var "<stuck>")
let rec free_vars (_expression : expr) : String_set.t = failwith "TODO"

let fresh_avoiding (_base : string) (_forbidden : String_set.t) : string =
  failwith "TODO"

let rec subst (_replacement : expr) (_variable : string) (_expression : expr) : expr =
  failwith "TODO: capture avoiding"

let rec is_value (_expression : expr) : bool = failwith "TODO"
let rec step (_expression : expr) : expr option = failwith "TODO: CBV left-to-right"

let trace ~fuel:_ (_expression : expr) : expr list =
  failwith "TODO: include initial and final/stuck expression"

let omega =
  let self = Fun ("x", App (Var "x", Var "x")) in
  App (self, self)

(* PAPER TRACES: ...
   OMEGA EXPLANATION: ... *)

let () =
  assert (subst (Int 2) "x" (Add (Var "x", Int 1)) = Add (Int 2, Int 1));
  let capture_case = subst (Var "y") "x" (Fun ("y", Add (Var "x", Var "y"))) in
  assert (String_set.mem "y" (free_vars capture_case));
  let program = Let ("x", Add (Int 2, Int 2), Add (Var "x", Var "x")) in
  let states = trace ~fuel:10 program in
  assert (List.hd (List.rev states) = Int 8);
  assert (List.length (trace ~fuel:5 omega) = 6);
  print_endline "E37 complete"

(** E40 — Constraint generation, unification, and inference (45-50 min)

    OUTCOME

    Derive principal types mechanically, implement unification, and explain an
    occurs-check failure in the same terms as the OCaml compiler.

    STEP 1 — PREDICT PRINCIPAL TYPES ON PAPER

    - Derive constraints for identity, apply, twice, and S.
    - Predict each principal type before using any implementation below.
    - Keep the derivations so you can compare individual constraints later.

    STEP 2 — IMPLEMENT SUBSTITUTION AND UNIFICATION

    - Implement [occurs].
    - Implement [apply_subst].
    - Implement [unify]. Apply every new substitution to the remaining worklist.
    - Compose substitutions so applying the final result once produces a fully updated
      type.
    - Test arrow decomposition, a constructor mismatch, and an occurs-check failure
      separately.

    STEP 3 — CROSS-CHECK BY HAND

    - Solve the two source constraint systems in [HAND DERIVATIONS] manually.
    - Run each system through [unify].
    - On a mismatch, compare the first substitution where the two solutions diverge.

    STEP 4 — GENERATE CONSTRAINTS

    - Implement [collect] for variables, lambdas, application, and [if].
    - Keep fresh type-variable allocation explicit and reproducible through
      [infer_state].
    - Implement [infer] by collecting constraints and then unifying them.

    STEP 5 — STABILIZE TYPE OUTPUT

    - Implement [show_normalized].
    - Rename type variables by first appearance as ['a], ['b], and so on.
    - Verify that printed types do not depend on prior allocation history.
    - Compare the inferred types of apply, double, and S with Step 1.

    STEP 6 — EXPLAIN SELF-APPLICATION

    - Infer the type of [omega_half], representing [fun x -> x x].
    - Identify the exact constraint that triggers the occurs check.
    - Explain why satisfying it would require an infinite type.
    - Connect that explanation to OCaml's "type variable occurs inside" message.

    FINISH

    Run: [opam exec -- dune exec exercises/e40_unification_and_inference.exe]

    Reading fallback: https://cs3110.github.io/textbook/chapters/interp/inference.html

    Source coverage: constraints; unify; unify more; infer apply; infer double; infer S.
*)

type typ = TInt | TBool | TVar of int | TArrow of typ * typ
type substitution = (int * typ) list
type constraint_ = typ * typ
type unify_error = Mismatch of typ * typ | Occurs of int * typ

let rec occurs (_variable : int) (_typ : typ) : bool = failwith "TODO"
let rec apply_subst (_subst : substitution) (_typ : typ) : typ = failwith "TODO"

let unify (_constraints : constraint_ list) : (substitution, unify_error) result =
  failwith "TODO"

type expr =
  | Int of int
  | Bool of bool
  | Var of string
  | Fun of string * expr
  | App of expr * expr
  | If of expr * expr * expr

type infer_state = { mutable next : int }

let fresh state =
  let variable = state.next in
  state.next <- variable + 1;
  TVar variable

let rec collect (_state : infer_state) (_context : (string * typ) list)
    (_expression : expr) : (typ * constraint_ list, string) result =
  failwith "TODO"

let infer (_expression : expr) : (typ, string) result =
  failwith "TODO: collect then unify"

let show_normalized (_typ : typ) : string = failwith "TODO: 'a, 'b, ..."
let apply_expr = Fun ("f", Fun ("x", App (Var "f", Var "x")))
let double_expr = Fun ("f", Fun ("x", App (Var "f", App (Var "f", Var "x"))))

let s_expr =
  Fun ("x", Fun ("y", Fun ("z", App (App (Var "x", Var "z"), App (Var "y", Var "z")))))

let omega_half = Fun ("x", App (Var "x", Var "x"))

(* HAND DERIVATIONS:
   constraint system 1:
   constraint system 2:
   apply:
   double:
   S:
   occurs-check explanation:
*)

let inferred_string expression =
  match infer expression with
  | Ok typ -> Ok (show_normalized typ)
  | Error error -> Error error

let () =
  assert (inferred_string apply_expr = Ok "('a -> 'b) -> 'a -> 'b");
  assert (inferred_string double_expr = Ok "('a -> 'a) -> 'a -> 'a");
  assert (match infer omega_half with Error _ -> true | Ok _ -> false);
  assert (match infer s_expr with Ok _ -> true | Error _ -> false);
  print_endline "E40 complete"

open Ast

type typ =
  | TInt
  | TBool

type environment = (string * typ) list

let empty = []

let lookup environment name =
  try List.assoc name environment with
  | Not_found -> failwith "Unbound variable"

let extend environment name typ =
  (name, typ) :: environment

let rec typeof environment = function
  | Int _ -> TInt
  | Bool _ -> TBool
  | Var name -> lookup environment name
  | Let (name, bound, body) ->
      typeof (extend environment name (typeof environment bound)) body
  | Binop (operator, left, right) ->
      begin match operator, typeof environment left, typeof environment right with
      | (Add | Mult), TInt, TInt -> TInt
      | Leq, TInt, TInt -> TBool
      | _ -> failwith "Operator and operand type mismatch"
      end
  | If (condition, yes_branch, no_branch) ->
      if typeof environment condition <> TBool then
        failwith "Guard of if must have type bool";
      let branch_type = typeof environment yes_branch in
      if branch_type = typeof environment no_branch then branch_type
      else failwith "Branches of if must have same type"

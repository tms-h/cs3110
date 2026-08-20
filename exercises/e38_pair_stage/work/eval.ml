open Ast

let is_value = function
  | Int _ | Bool _ -> true
  | Var _ | Let _ | Binop _ | If _ -> false

let rec subst expression value name =
  match expression with
  | Var other -> if name = other then value else expression
  | Bool _ | Int _ -> expression
  | Binop (operator, left, right) ->
      Binop (operator, subst left value name, subst right value name)
  | Let (other, bound, body) ->
      let bound' = subst bound value name in
      if name = other then Let (other, bound', body)
      else Let (other, bound', subst body value name)
  | If (condition, yes_branch, no_branch) ->
      If (subst condition value name, subst yes_branch value name,
          subst no_branch value name)

let rec step = function
  | Int _ | Bool _ -> failwith "Does not step"
  | Var _ -> failwith "Unbound variable"
  | Binop (operator, left, right) when is_value left && is_value right ->
      step_bop operator left right
  | Binop (operator, left, right) when is_value left ->
      Binop (operator, left, step right)
  | Binop (operator, left, right) -> Binop (operator, step left, right)
  | Let (name, bound, body) when is_value bound -> subst body bound name
  | Let (name, bound, body) -> Let (name, step bound, body)
  | If (Bool true, yes_branch, _) -> yes_branch
  | If (Bool false, _, no_branch) -> no_branch
  | If (Int _, _, _) -> failwith "Guard of if must have type bool"
  | If (condition, yes_branch, no_branch) ->
      If (step condition, yes_branch, no_branch)

and step_bop operator left right =
  match operator, left, right with
  | Add, Int a, Int b -> Int (a + b)
  | Mult, Int a, Int b -> Int (a * b)
  | Leq, Int a, Int b -> Bool (a <= b)
  | _ -> failwith "Operator and operand type mismatch"

let rec eval_small expression =
  if is_value expression then expression else eval_small (step expression)

let rec eval_big = function
  | (Int _ | Bool _) as value -> value
  | Var _ -> failwith "Unbound variable"
  | Binop (operator, left, right) ->
      step_bop operator (eval_big left) (eval_big right)
  | Let (name, bound, body) -> subst body (eval_big bound) name |> eval_big
  | If (condition, yes_branch, no_branch) ->
      begin match eval_big condition with
      | Bool true -> eval_big yes_branch
      | Bool false -> eval_big no_branch
      | _ -> failwith "Guard of if must have type bool"
      end

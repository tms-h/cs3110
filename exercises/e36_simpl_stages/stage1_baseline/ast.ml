type bop =
  | Add
  | Mult
  | Leq

type expr =
  | Var of string
  | Int of int
  | Bool of bool
  | Binop of bop * expr * expr
  | Let of string * expr * expr
  | If of expr * expr * expr

exception Lex_error of int * string

let string_of_bop = function
  | Add -> "Add"
  | Mult -> "Mult"
  | Leq -> "Leq"

let rec to_string = function
  | Var name -> Printf.sprintf "Var(%S)" name
  | Int value -> Printf.sprintf "Int(%d)" value
  | Bool value -> Printf.sprintf "Bool(%b)" value
  | Binop (operator, left, right) ->
      Printf.sprintf "Binop(%s,%s,%s)" (string_of_bop operator)
        (to_string left) (to_string right)
  | Let (name, bound, body) ->
      Printf.sprintf "Let(%S,%s,%s)" name (to_string bound) (to_string body)
  | If (condition, yes_branch, no_branch) ->
      Printf.sprintf "If(%s,%s,%s)" (to_string condition)
        (to_string yes_branch) (to_string no_branch)

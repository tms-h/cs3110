module S = Simpl_swapped_precedence
open S.Ast

let () =
  let plus_binds_tighter =
    Binop (Mult, Binop (Add, Int 1, Int 2), Int 3)
  in
  assert (S.Driver.parse "1+2*3" = plus_binds_tighter);
  assert (S.Driver.classify "3.14" = Error S.Driver.Lexing);
  assert (S.Driver.classify "3+" = Error S.Driver.Parsing);
  Printf.printf "PLUS above TIMES: %s\n"
    (S.Driver.parse "1+2*3" |> to_string);
  print_endline "stage3_swapped_precedence passed"

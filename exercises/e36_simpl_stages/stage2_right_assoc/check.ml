module S = Simpl_right_assoc
open S.Ast

let () =
  let times_right =
    Binop (Mult, Int 1, Binop (Mult, Int 2, Int 3))
  in
  let times_binds_tighter =
    Binop (Add, Int 1, Binop (Mult, Int 2, Int 3))
  in
  assert (S.Driver.parse "1*2*3" = times_right);
  assert (S.Driver.parse "1+2*3" = times_binds_tighter);
  assert (S.Driver.classify "3.14" = Error S.Driver.Lexing);
  assert (S.Driver.classify "3+" = Error S.Driver.Parsing);
  Printf.printf "right-associative TIMES: %s\n"
    (S.Driver.parse "1*2*3" |> to_string);
  print_endline "stage2_right_assoc passed"

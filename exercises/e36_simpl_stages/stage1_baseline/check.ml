module S = Simpl_baseline
open S.Ast

let show source =
  Printf.printf "%S -> %s\n" source (S.Driver.parse source |> to_string)

let () =
  let add_left =
    Binop (Add, Binop (Add, Int 1, Int 2), Int 3)
  in
  let times_left =
    Binop (Mult, Binop (Mult, Int 1, Int 2), Int 3)
  in
  let times_binds_tighter =
    Binop (Add, Int 1, Binop (Mult, Int 2, Int 3))
  in
  assert (S.Driver.parse "22" = Int 22);
  assert (S.Driver.parse "1 + 2 + 3" = add_left);
  assert
    (S.Driver.parse "let x = 2 in 20 + x"
    = Let ("x", Int 2, Binop (Add, Int 20, Var "x")));
  assert (S.Driver.parse "1*2*3" = times_left);
  assert (S.Driver.parse "1+2*3" = times_binds_tighter);
  assert (S.Driver.classify "3.14" = Error S.Driver.Lexing);
  assert (S.Driver.classify "3+" = Error S.Driver.Parsing);
  List.iter show [ "22"; "1 + 2 + 3"; "let x = 2 in 20 + x";
                   "1*2*3"; "1+2*3" ];
  print_endline "stage1_baseline passed"

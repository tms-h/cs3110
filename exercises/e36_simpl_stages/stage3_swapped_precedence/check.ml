module S = Simpl_swapped_precedence
open S.Ast

let () =
  Printf.printf "PLUS above TIMES: %s\n"
    (S.Driver.parse "1+2*3" |> to_string);
  print_endline "stage3_swapped_precedence passed"

module S = Simpl_right_assoc
open S.Ast

let () =
  Printf.printf "right-associative TIMES: %s\n"
    (S.Driver.parse "1*2*3" |> to_string);
  print_endline "stage2_right_assoc passed"

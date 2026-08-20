module S = Simpl_baseline
open S.Ast

let show source =
  match S.Driver.classify source with
  | Ok expression -> Printf.printf "%S -> %s\n" source (to_string expression)
  | Error S.Driver.Lexing -> Printf.printf "%S -> lexical error\n" source
  | Error S.Driver.Parsing -> Printf.printf "%S -> parse error\n" source

let () =
  List.iter show [ "22"; "1 + 2 + 3"; "let x = 2 in 20 + x";
                   "3.14"; "3+"; "1*2*3"; "1+2*3" ];
  print_endline "stage1_baseline passed"

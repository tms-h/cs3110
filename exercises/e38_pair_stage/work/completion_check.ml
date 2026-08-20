module W = Pair_work

let require condition message =
  if not condition then failwith message

let check () =
  let parse = W.Driver.parse in
  let pair_with_work = parse "(1+2,3*4)" in
  require
    (W.Eval.step pair_with_work = parse "(3,3*4)")
    "small-step evaluation must reduce the left component first";
  require
    (W.Eval.step (parse "(3,3*4)") = parse "(3,12)")
    "small-step evaluation must reduce the right component after the left value";
  require
    (W.Eval.eval_small pair_with_work = parse "(3,12)")
    "small-step evaluation produced the wrong pair";
  require
    (W.Eval.eval_big pair_with_work = parse "(3,12)")
    "big-step evaluation produced the wrong pair";
  require
    (W.Eval.is_value (parse "(3,12)"))
    "a pair of values must be a value";
  require
    (not (W.Eval.is_value pair_with_work))
    "a pair with work remaining must not be a value";
  require
    (W.Eval.subst (parse "(x,y)") (W.Ast.Int 7) "x" = parse "(7,y)")
    "substitution must recurse through both pair components";
  let int_bool = W.Typecheck.typeof W.Typecheck.empty (parse "(1,true)") in
  let int_bool_again =
    W.Typecheck.typeof W.Typecheck.empty (parse "(2,false)")
  in
  let bool_int = W.Typecheck.typeof W.Typecheck.empty (parse "(true,1)") in
  require (int_bool = int_bool_again) "pair types must depend on component types";
  require (int_bool <> bool_int) "pair type component order must be preserved";
  require
    (int_bool <> W.Typecheck.typeof W.Typecheck.empty (parse "1"))
    "a pair type must differ from int";
  print_endline "e38_pair_stage passed"

let () =
  try check () with
  | exception_ ->
      prerr_endline
        ("e38_pair_stage incomplete: " ^ Printexc.to_string exception_);
      exit 1

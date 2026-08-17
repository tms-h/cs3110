(** E03 — Lists and the library boundary (30-40 min)

    OUTCOME

    - Read list shapes directly with patterns.
    - Decide when recursion or a library operation is the clearer tool.

    STEP 1 — CONSTRUCT ONE LIST THREE WAYS

    - Fill [one_to_five_a] with bracket syntax.
    - Fill [one_to_five_b] using only [::] and [[]].
    - Fill [one_to_five_c] using [@] and the literal sublist [[2; 3; 4]].

    STEP 2 — RECURSE OVER CONTENTS

    - Implement [product] and [concat] directly recursively.
    - Write down the identity element for each operation.
    - Explain why that identity determines the empty-list result.

    STEP 3 — RECOGNIZE SHAPES

    - Implement the three predicates in source order.
    - Do not call [List.length]. Let exhaustiveness warnings guide the cases.

    STEP 4 — CROSS THE LIBRARY BOUNDARY

    - Open https://ocaml.org/manual/5.4/api/List.html.
    - Implement [fifth_or_zero], [descending], [last_exn], and [any_zero].
    - Use no pattern matching in [last_exn] or [any_zero].

    STEP 5 — TEST, THEN DEBUG

    - Add one boundary input and one adversarial input for every function.
    - When a test fails, explain the bad case before editing the implementation.
    - Run [opam exec -- dune exec exercises/e03_lists_and_library.exe].

    Source coverage: list expressions; product; concat; product test; patterns; library;
    library test; library puzzle. *)

let one_to_five_a : int list = failwith "TODO"
let one_to_five_b : int list = failwith "TODO"
let one_to_five_c : int list = failwith "TODO"
let rec product (_xs : int list) : int = failwith "TODO"
let rec concat (_xs : string list) : string = failwith "TODO"
let starts_with_bigred (_xs : string list) : bool = failwith "TODO"
let length_is_two_or_four (_xs : 'a list) : bool = failwith "TODO"
let first_two_equal (_xs : 'a list) : bool = failwith "TODO"
let fifth_or_zero (_xs : int list) : int = failwith "TODO: consult List docs"
let descending (_xs : int list) : int list = failwith "TODO"
let last_exn (_xs : 'a list) : 'a = failwith "TODO: no pattern matching"
let any_zero (_xs : int list) : bool = failwith "TODO: one library call"

let () =
  assert (one_to_five_a = one_to_five_b && one_to_five_b = one_to_five_c);
  assert (one_to_five_a = [ 1; 2; 3; 4; 5 ]);
  assert (product [] = 1 && product [ 2; -3; 4 ] = -24);
  assert (concat [] = "" && concat [ "meta"; "learn" ] = "metalearn");
  assert (starts_with_bigred [ "bigred"; "bear" ]);
  assert (
    length_is_two_or_four [ 1; 2; 3; 4 ] && not (length_is_two_or_four [ 1; 2; 3 ]));
  assert (first_two_equal [ Some 1; Some 1 ] && not (first_two_equal [ 1; 2 ]));
  assert (fifth_or_zero [ 9; 8; 7; 6; 5 ] = 5 && fifth_or_zero [ 9 ] = 0);
  assert (descending [ 3; 1; 2; 3 ] = [ 3; 3; 2; 1 ]);
  assert (last_exn [ "a"; "b" ] = "b");
  assert (any_zero [ 4; 0; 5 ] && not (any_zero [ 4; 5 ]));
  print_endline "E03 complete"

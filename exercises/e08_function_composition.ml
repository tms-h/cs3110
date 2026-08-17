(** E08 — Function composition as an interface (25-35 min)

    OUTCOME

    - Read curried types left-to-right and use partial application deliberately.
    - Recognize point-free code without making debugging harder.

    STEP 1 — PREDICT INFERRED FUNCTIONS

    - Predict the types of [quad] and [fourth] before invoking the compiler.
    - Explain how a binding with no visible final parameter is still a function.
    - Check with [opam exec -- ocamlc -i exercises/e08_function_composition.ml].

    STEP 2 — INVESTIGATE AN OPERATOR

    - Predict how [($)] groups an expression containing addition.
    - Run the smallest experiment that distinguishes the possible parses.
    - Do not use [($)] elsewhere. Explain its readability cost.

    STEP 3 — IMPLEMENT COMPOSITION AND REPETITION

    - Implement forward composition [(%>)].
    - Choose explicit behavior for a negative [repeat] count.
    - Implement [repeat] without silently looping on invalid input.

    STEP 4 — ADAPT LIBRARY FUNCTIONS

    - Implement the three uncurried wrappers in source order.
    - Build [descending] from [List.sort] using partial application.

    STEP 5 — FUSE, EXPLAIN, FINISH

    - Write the map-fusion argument in the marked block.
    - Implement [map_fused] with exactly one [List.map].
    - Explain when effects or exceptions make fusion observable.
    - Run [opam exec -- dune exec exercises/e08_function_composition.exe].

    Source coverage: twice, no arguments; mystery operator 1; mystery operator 2;
    repeat; library uncurried; map composition. *)

let double x = 2 * x
let square x = x * x
let twice f x = f (f x)
let quad = twice double
let fourth = twice square
let ( $ ) f x = f x

let ( %> ) (_f : 'a -> 'b) (_g : 'b -> 'c) : 'a -> 'c =
  failwith "TODO: forward composition"

let repeat (_f : 'a -> 'a) (_n : int) (_x : 'a) : 'a = failwith "TODO"
let uncurried_append (_args : 'a list * 'a list) : 'a list = failwith "TODO"
let uncurried_char_compare (_args : char * char) : int = failwith "TODO"
let uncurried_max (_args : 'a * 'a) : 'a = failwith "TODO"
let descending : int list -> int list = failwith "TODO: partial application"

let map_fused (_f : 'b -> 'c) (_g : 'a -> 'b) (_xs : 'a list) : 'c list =
  failwith "TODO: exactly one List.map call"

(* MAP FUSION ARGUMENT: ...
   EFFECT/EXCEPTION CAVEAT: ... *)

let () =
  assert (quad 3 = 12 && fourth 2 = 16);
  assert ((fun x -> x * x) $ 2 + 2 = 16);
  assert (((fun x -> x + 1) %> string_of_int) 9 = "10");
  assert (repeat (fun x -> x * 2) 5 1 = 32);
  assert (uncurried_append ([ 1; 2 ], [ 3 ]) = [ 1; 2; 3 ]);
  assert (uncurried_char_compare ('a', 'b') < 0);
  assert (uncurried_max (3, 9) = 9);
  assert (descending [ 2; 1; 3; 2 ] = [ 3; 2; 2; 1 ]);
  assert (map_fused string_of_int (( + ) 1) [ 1; 2; 3 ] = [ "2"; "3"; "4" ]);
  print_endline "E08 complete"

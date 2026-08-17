(** E25 — Testing from contracts (35-50 min)

    OUTCOME

    - Separate black-box input partitions from glass-box execution paths.
    - Generate reproducible data and interpret coverage cautiously.

    STEP 1 — WRITE BLACK-BOX CASES BEFORE CODE

    - Partition empty versus non-empty sets.
    - Cover present versus absent elements, repeated insertion/removal, and sequences.
    - Turn the table into [black_box_tests].

    STEP 2 — IMPLEMENT THE SET

    - State the no-duplicates RI.
    - Implement [List_set] in source order.
    - Run only [black_box_tests] until they pass.

    STEP 3 — ADD GLASS-BOX PATHS

    - Read the implementation after black-box tests pass.
    - Add an input for every branch to [glass_box_tests].
    - Identify one path that adds coverage but no new contractual behavior.

    STEP 4 — GENERATE REPRODUCIBLE LISTS

    - Implement [bounded_list] with the supplied [Random.State].
    - Generate lengths 5 through 10 and elements 0 through 100.
    - Never use global randomness in a reproducible test.

    STEP 5 — FIND A FALSE PROPERTY

    - Run "contains an even value" for 100 generated lists.
    - Record the seed and smallest failing sample.
    - Explain why a random pass is not a proof.

    STEP 6 — TRANSFER AND FINISH

    - Generate operation traces and compare [List_set] with [Stdlib.Set].
    - Run [opam exec -- dune exec exercises/e25_testing_from_contracts.exe].
    - Optional later tool: https://github.com/aantron/bisect_ppx

    Source coverage: set black box; set glass box; random lists. *)

module List_set = struct
  type 'a t = 'a list

  let empty = []
  let mem (_x : 'a) (_set : 'a t) : bool = failwith "TODO"
  let add (_x : 'a) (_set : 'a t) : 'a t = failwith "TODO: preserve RI"
  let remove (_x : 'a) (_set : 'a t) : 'a t = failwith "TODO"
  let elements (_set : 'a t) : 'a list = failwith "TODO"
end

let black_box_tests () : unit = failwith "TODO: contract partitions"
let glass_box_tests () : unit = failwith "TODO: branch-directed"

let bounded_list (_state : Random.State.t) : int list =
  failwith "TODO: length 5..10, elements 0..100"

let find_counterexample (_state : Random.State.t) (_trials : int)
    (_property : int list -> bool) : int list option =
  failwith "TODO"

let () =
  black_box_tests ();
  glass_box_tests ();
  let state = Random.State.make [| 3110 |] in
  for _ = 1 to 100 do
    let xs = bounded_list state in
    assert (List.length xs >= 5 && List.length xs <= 10);
    assert (List.for_all (fun x -> 0 <= x && x <= 100) xs)
  done;
  let _possibly_failing =
    find_counterexample
      (Random.State.make [| 3110 |])
      100
      (List.exists (fun x -> x mod 2 = 0))
  in
  print_endline "E25 complete"

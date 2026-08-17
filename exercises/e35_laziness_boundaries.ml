(** E35 — Laziness boundaries and memoization (30-45 min)

    OUTCOME

    Compare two lazy-sequence representations, observe [Lazy.t] memoization, and
    preserve short-circuit forcing behavior.

    STEP 1 — LOCATE THE LAZINESS

    - Implement [head], [tail], [naturals_from], and [map] for the extra-lazy [sequence]
      below.
    - Compare it with E33's [Cons of 'a * (unit -> 'a sequence)].
    - State which representation can defer computation of the first element.
    - State whether either representation memoizes a forced thunk automatically.

    STEP 2 — OBSERVE MEMOIZATION DIRECTLY

    - Implement [lazy_hello] so forcing it logs exactly once.
    - Force the same value twice and observe the output.
    - Explain how [Lazy.t] differs from a plain [unit -> 'a] thunk.

    STEP 3 — PRESERVE SHORT-CIRCUIT BEHAVIOR

    - Before coding, predict whether the right operand of [false &&& right] should be
      forced.
    - Implement [(&&&)].
    - Use a counter in the right operand to prove the prediction; do not rely only on
      the returned Boolean.

    STEP 4 — USE A MEMOIZING LAZY SEQUENCE

    - Implement [lazy_map] and [lazy_filter].
    - Instrument an input sequence and verify that constructing [lazy_map f input] does
      not force [input].
    - Force the same result node twice and verify that its work is memoized.

    STEP 5 — TRANSFER TO ZIP

    - Implement [lazy_zip].
    - State exactly which nodes of each input are forced when one output node is forced.
    - Verify the statement with counters or logs on both inputs.

    FINISH

    Run: [opam exec -- dune exec exercises/e35_laziness_boundaries.exe]

    Source coverage: different sequence rep; lazy hello; lazy and; lazy sequence. *)

type 'a sequence = Cons of (unit -> 'a * 'a sequence)

let head (_s : 'a sequence) : 'a = failwith "TODO"
let tail (_s : 'a sequence) : 'a sequence = failwith "TODO"
let rec naturals_from (_n : int) : int sequence = failwith "TODO"
let rec map (_f : 'a -> 'b) (_s : 'a sequence) : 'b sequence = failwith "TODO"
let lazy_hello : unit Lazy.t = lazy (failwith "TODO: print once")

let ( &&& ) (_left : bool Lazy.t) (_right : bool Lazy.t) : bool =
  failwith "TODO: short circuit"

type 'a lazy_sequence = 'a lazy_node Lazy.t
and 'a lazy_node = LCons of 'a * 'a lazy_sequence

let rec lazy_map (_f : 'a -> 'b) (_s : 'a lazy_sequence) : 'b lazy_sequence =
  failwith "TODO"

let rec lazy_filter (_p : 'a -> bool) (_s : 'a lazy_sequence) : 'a lazy_sequence =
  failwith "TODO"

let rec lazy_zip (_a : 'a lazy_sequence) (_b : 'b lazy_sequence) :
    ('a * 'b) lazy_sequence =
  failwith "TODO: transfer"

let () =
  assert (head (naturals_from 10) = 10);
  assert (head (tail (map (( * ) 2) (naturals_from 10))) = 22);
  let forced = ref 0 in
  let no = lazy false in
  let dangerous =
    lazy
      (incr forced;
       true)
  in
  assert ((not (no &&& dangerous)) && !forced = 0);
  Lazy.force lazy_hello;
  Lazy.force lazy_hello;
  print_endline "E35 complete"

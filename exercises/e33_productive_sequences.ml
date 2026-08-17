(** E33 — Productive infinite sequences (35-50 min)

    OUTCOME

    Build and transform infinite sequences while predicting exactly when their thunks
    are forced.

    STEP 1 — BUILD FOUR PRODUCERS

    - Implement [naturals_from].
    - Implement powers of two.
    - Implement cyclic lowercase letters.
    - Implement deterministic coin flips. Thread a [Random.State.t] through sequence
      construction so repeated tests produce the same observations.
    - Inspect a short finite prefix of each producer before continuing.

    STEP 2 — PREDICT FORCING

    - Implement [head], [tail], and [nth].
    - Before running code, predict exactly which thunks are invoked by
      [head (tail (tail naturals))].
    - Add a counter or log to an instrumented sequence and execute the expression.
    - Explain any mismatch between the prediction and observation.

    STEP 3 — TRANSFORM WITHOUT LOSING PRODUCTIVITY

    - Implement [map]. Verify that constructing a mapped sequence does not inspect an
      infinite suffix.
    - Implement [filter]. It may diverge when no future value passes, but merely
      building it must not eagerly search the entire input.
    - Implement [interleave].

    STEP 4 — CHECK FAIRNESS

    - Interleave two productive sequences whose values reveal their source.
    - Inspect a finite prefix and show that neither input is starved.

    STEP 5 — TRANSFER THE FORCING DISCIPLINE

    - Implement [take].
    - Implement [scan] for running accumulation.
    - Instrument the source and verify that requesting [n] output values does not force
      input element [n + 1].

    FINISH

    Run: [opam exec -- dune exec exercises/e33_productive_sequences.exe]

    Source coverage: pow2; more sequences; nth; hd tl; filter; interleave. *)

type 'a sequence = Cons of 'a * (unit -> 'a sequence)

let head (Cons (x, _)) = x
let tail (Cons (_, next)) = next ()
let rec naturals_from (_n : int) : int sequence = failwith "TODO"
let powers_of_two : int sequence = failwith "TODO"
let lowercase_cycle : char sequence = failwith "TODO"

type coin = Heads | Tails

let coin_flips (_state : Random.State.t) : coin sequence = failwith "TODO"
let rec nth (_sequence : 'a sequence) (_index : int) : 'a = failwith "TODO"
let rec map (_f : 'a -> 'b) (_sequence : 'a sequence) : 'b sequence = failwith "TODO"

let rec filter (_p : 'a -> bool) (_sequence : 'a sequence) : 'a sequence =
  failwith "TODO"

let rec interleave (_a : 'a sequence) (_b : 'a sequence) : 'a sequence = failwith "TODO"
let take (_count : int) (_sequence : 'a sequence) : 'a list = failwith "TODO: transfer"

let rec scan (_f : 'acc -> 'a -> 'acc) (_initial : 'acc) (_sequence : 'a sequence) :
    'acc sequence =
  failwith "TODO: transfer"

let () =
  let naturals = naturals_from 0 in
  assert (take 6 naturals = [ 0; 1; 2; 3; 4; 5 ]);
  assert (nth powers_of_two 10 = 1024);
  assert (List.nth_opt (take 30 lowercase_cycle) 26 = Some 'a');
  assert (take 5 (filter (fun n -> n mod 2 = 0) naturals) = [ 0; 2; 4; 6; 8 ]);
  assert (take 8 (interleave naturals powers_of_two) = [ 0; 1; 1; 2; 2; 4; 3; 8 ]);
  assert (take 5 (scan ( + ) 0 (naturals_from 1)) = [ 1; 3; 6; 10; 15 ]);
  print_endline "E33 complete"

(** E33 — Productive infinite sequences (95-135 min)

    Build: [opam exec -- dune build exercises/e33_productive_sequences.exe] Run:
    [opam exec -- dune exec exercises/e33_productive_sequences.exe] *)

(* Task 1 — Define the sequence representation.
   Define ['a sequence = Cons of 'a * (unit -> 'a sequence)]. Define [head] to
   return the stored value and [tail] to invoke the tail thunk once.

   Define a self-referential sequence of zeros and test its head plus the head of
   its tail.
   Example form: [let rec countdown n = Cons (n, fun () -> countdown (n - 1))]
   Build and run before continuing. *)

(* Task 2 — Define the textbook producers.
   Define [naturals_from n] as n, n+1, ...; [powers_of_two] as 1, 2, 4, ...;
   [even_naturals] as 0, 2, 4, ...; [lowercase_cycle] as a through z repeatedly;
   variant [coin = Heads | Tails]; and [coin_flips state] using
   [Random.State.bool] without global randomness.

   Define [take count sequence], returning [] when [count <= 0]. Test the first
   six naturals, first six powers, and first six evens. Using zero-based indices,
   test that positions 25 and 26 of the letter cycle are ['z'] and ['a'].
   With two states seeded 3110, test the first 20 coin flips are identical.
   [take 0] must force no tail thunk; for positive [count], [take] must force
   exactly the [count - 1] tail thunks needed to obtain the requested heads.

   Define [nats = naturals_from 0]. In comments, explain the evaluation and thunk
   forcing for [head nats], [tail nats], [head (tail nats)],
   [tail (tail nats)], and [head (tail (tail nats))].
   Example form: [let rec counting_from n = Cons (n, fun () -> counting_from (n + 2))]
   Build and run before continuing. *)

(* Task 3 — Select by index.
   Define zero-based [nth sequence index]. Raise [Invalid_argument "nth"] when
   [index < 0]. Force only enough tails to reach the requested element.

   Test natural indices 0 and 5, powers-of-two index 10 yielding 1024, and a
   negative index.
   Example form: [let second stream = first (rest stream)]
   Build and run before continuing. *)

(* Extension Task 4 — Map without eager tails.
   Define [map f sequence]. Constructing the mapped head may apply [f] to the
   source head, but it must not force the source tail until the mapped tail is
   requested.

   Instrument a source tail with a counter. Test construction leaves the counter
   zero, requesting one tail makes it one, and mapped naturals have doubled values.
   Example form: [let repeat_head (Link (x, _)) = Link (x, fun () -> Link (x, fun () -> failwith "end"))]
   Build and run before continuing. *)

(* Task 5 — Filter productively.
   Define [filter predicate sequence] to return the next matching value and delay
   the remaining search. It may diverge only if no future value matches.

   Test the first five even naturals are [0; 2; 4; 6; 8] and filtering a sequence
   whose head matches does not force beyond the first output node.
   Example form: [let head_matches predicate stream = predicate (head stream)]
   Build and run before continuing. *)

(* Task 6 — Interleave fairly.
   Define [interleave a b] to alternate heads starting with [a], then recursively
   emit [b]'s head before returning to the delayed tail of [a]. Do not force both
   input tails merely to construct one output node. Test naturals with powers of two produce
   [0; 1; 1; 2; 2; 4; 3; 8] for the first eight values.
   Example form: [let pair_heads a b = (head a, head b)]
   Build and run before continuing. *)

(* Extension Task 7 — Scan running accumulations.
   Define [scan f initial sequence]. Its first output is
   [f initial (head sequence)], and later outputs continue accumulating.

   Test summing naturals from 1 with initial 0 produces [1; 3; 6; 10; 15]. Use a
   counter to test that the minimally forcing [take] definition from Task 2 forces
   exactly four source tails while producing those five outputs.
   Example form: [let next_total = combine accumulated (head source)]
   After every required forcing explanation and assertion in E33 is present and
   passing, print the exact line ["E33 passed"] once, and not earlier.
   Build and run before continuing. *)

(** E06 — Variants and pattern coverage (25-40 min)

    OUTCOME

    - Make illegal states harder to represent with variants.
    - Use exhaustiveness and redundancy warnings as design feedback.

    STEP 1 — CLOSE THE CARD MODEL

    - Implement [make_numbered_rank]. Reject integers outside 2 through 10.
    - Implement [compare_rank]. Decide and document where Ace belongs.
    - Check that invalid numbered ranks cannot enter through the public helper.

    STEP 2 — PREDICT PATTERN COVERAGE

    - Fill the counterexample block before compiling anything else.
    - For each listed pattern, give a non-empty [int option list] that misses.
    - If none exists, explain why the pattern is exhaustive for non-empty lists.

    STEP 3 — IMPLEMENT TWO QUADRANT STYLES

    - Implement [sign] and then [quadrant] with patterns and no guards.
    - Implement [quadrant_guarded] with guards and no call to [sign].
    - Compare which version makes axis handling easier to audit.

    STEP 4 — OPEN THE VARIANT API

    - Implement [sign_poly] and [quadrant_poly].
    - Record one benefit and one loss versus the closed [quad] type.

    STEP 5 — TRANSFER

    - Implement [classify_axis] without changing [quad].
    - Run [opam exec -- dune exec exercises/e06_variants_and_patterns.exe].

    Source coverage: cards; matching; quadrant; quadrant when; quadrant poly. *)

type suit = Clubs | Diamonds | Hearts | Spades
type rank = Num of int | Jack | Queen | King | Ace
type card = { suit : suit; rank : rank }

let make_numbered_rank (_n : int) : rank option = failwith "TODO: accept 2..10"
let compare_rank (_a : rank) (_b : rank) : int = failwith "TODO"

(* PATTERN COUNTEREXAMPLES / EXPLANATIONS:
   1.
   2.
   3.
   4.
   5.
*)

type sign = Neg | Zero | Pos
type quad = I | II | III | IV

let sign (_x : int) : sign = failwith "TODO"
let quadrant (_point : int * int) : quad option = failwith "TODO: no guards"

let quadrant_guarded (_point : int * int) : quad option =
  failwith "TODO: guards, no sign"

let sign_poly (_x : int) : [ `Neg | `Pos | `Zero ] = failwith "TODO"

let quadrant_poly (_point : int * int) : [ `I | `II | `III | `IV ] option =
  failwith "TODO"

let classify_axis (_point : int * int) :
    [ `Axis_x | `Axis_y | `Origin | `Quadrant of quad ] =
  failwith "TODO: transfer"

let () =
  assert (make_numbered_rank 1 = None && make_numbered_rank 10 = Some (Num 10));
  assert (compare_rank Ace King > 0);
  assert (quadrant (-2, 3) = Some II && quadrant (0, 3) = None);
  assert (quadrant_guarded (2, -3) = Some IV);
  assert (quadrant_poly (-2, -3) = Some `III);
  assert (classify_axis (0, 0) = `Origin && classify_axis (3, 0) = `Axis_x);
  print_endline "E06 complete"

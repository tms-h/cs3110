(** E06 — Variants and pattern matching (95-130 min)

    Build: [opam exec -- dune build exercises/e06_variants_and_patterns.exe] Run:
    [opam exec -- dune exec exercises/e06_variants_and_patterns.exe] *)

(* Task 1 — Model cards with variants.
   Define [suit] with [Clubs], [Diamonds], [Hearts], and [Spades]. Define [rank]
   with [Num of int], [Jack], [Queen], [King], and [Ace]. Define record [card]
   with fields [suit] and [rank].

   Construct values for the Ace of Clubs, Queen of Hearts, Two of Diamonds, and
   Seven of Spades.

   Extension: define [make_numbered_rank n] to return [Some (Num n)] for 2
   through 10 and [None] otherwise. Test 1, 2, 10, and 11.
   Example form: [type temperature = Cold | Warm of int]
   Build and run before continuing. *)

(* Task 2 — Extension: order ranks.
   Define [compare_rank a b] so numbered ranks use their integer order and
   [Jack < Queen < King < Ace], with every face rank greater than every numbered
   rank. Return a negative integer, zero, or a positive integer as usual.

   Test [Num 2] against [Num 10], [Num 10] against [Jack], [Ace] against [King],
   and equality.
   Example form:
   [let compare_size a b =
      match (a, b) with
      | Small, Small | Large, Large -> 0
      | Small, Large -> -1
      | Large, Small -> 1]
   Build and run before continuing. *)

(* Task 3 — Check pattern coverage.
   For each pattern below, write in a comment a nonempty [int option list] that
   does not match it, or explain why no such nonempty list exists:

   - [Some x :: tl]
   - [[Some 3110; None]]
   - [[Some x; _]]
   - [h1 :: h2 :: tl]
   - [h :: tl]

   The point is to distinguish patterns that match one exact list shape from
   patterns that match every nonempty list.

   Extension: define [starts_with_some xs] to return true when the first element
   is [Some _], and false for [None :: _] or []. Before coding, record why
   patterns [Some _ :: _] and [None :: _] still need an [] case.

   Test [], [None], and [Some 1; None].
   Example form: [let begins_ok = function Ok _ :: _ -> true | _ -> false]
   Build and run before continuing. *)

(* Task 4 — Classify quadrants with closed variants.
   Define [sign] with [Neg], [Zero], and [Pos]. Define [quad] with [I], [II],
   [III], and [IV]. Define [sign x], then define [quadrant (x, y)] using patterns
   and no guards. Return [None] when either coordinate is zero.

   Test one point in each quadrant, the origin, and one point on each axis.
   Example form: [let classify = function Left, Up -> Northwest | _ -> Center]
   Build and run before continuing. *)

(* Task 5 — Classify quadrants with guards.
   Define [quadrant_guarded (x, y)] with guards and without calling [sign]. It
   must have exactly the same result as [quadrant]. Test agreement on the seven
   cases from Task 4.
   Example form: [let direction (x, y) = match x, y with x, _ when x > 0 -> `Right | _ -> `Other]
   Build and run before continuing. *)

(* Task 6 — Use polymorphic variants.
   Define [sign_poly x] returning [`Neg], [`Zero], or [`Pos]. Define
   [quadrant_poly point] returning [Some `I], [Some `II], [Some `III],
   [Some `IV], or [None] on an axis.

   Test -1, 0, and 1 with [sign_poly], and test quadrants II and IV plus an axis.
   Example form: [let traffic_light = function 0 -> `Red | _ -> `Green]
   Build and run before continuing. *)

(* Task 7 — Extension: classify axes without changing [quad].
   Define [classify_axis point] returning [`Origin], [`Axis_x], [`Axis_y], or
   [`Quadrant q] for a value [q : quad]. Test the origin, both axes, and one
   quadrant.
   Example form: [let wrap color = `Colored color]
   Build and run before continuing. *)

(* Task 8 — Supplemental practice: flatten explicitly nested data.
   Inspired by 99 Problems P07. Define
   [type 'a nested = Atom of 'a | Group of 'a nested list], then define
   [flatten : 'a nested list -> 'a list]. Preserve the left-to-right order of
   atoms at every depth, including across empty groups. Use an accumulator or
   continuation so the implementation does not repeatedly append growing
   intermediate lists.

   Test [], a flat list of atoms, empty groups, and at least three levels of
   nesting. State why the result type is an ordinary homogeneous list even
   though the input can have different shapes.
   Example form: [Group [Atom 1; Group [Atom 2]]]
   Build and run before continuing. *)

(* Task 9 — Supplemental practice: design a run-length codec.
   Inspired by 99 Problems P09-P13. Define
   [type 'a run = Single of 'a | Repeat of int * 'a]. Define
   [encode_runs : equal:('a -> 'a -> bool) -> 'a list -> 'a run list] directly:
   scan once, use [equal] rather than polymorphic equality, combine only
   consecutive equal values, emit [Single x] for a run of length one, and emit
   [Repeat (count, x)] for a longer run. Do not first construct a list of packed
   sublists.

   Define [decode_runs : 'a run list -> ('a list, string) result]. Its
   representation invariant is that [Repeat (count, _)] has [count >= 2]; return
   [Error "invalid run length"] for a violation. Preserve order without repeated
   append. Test empty and singleton inputs, separated runs of the same value, a
   mixed round trip
   [decode_runs (encode_runs ~equal:Char.equal xs) = Ok xs], and malformed
   counts 0 and 1.

   After every required assertion and written explanation in E06 is present,
   print exactly [E06 passed].
   Example form: [[Repeat (3, 'a'); Single 'b'; Repeat (2, 'a')]]
   Build and run before continuing. *)

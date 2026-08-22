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

type suit =
  | Clubs
  | Diamonds
  | Hearts
  | Spades

type rank =
  | Num of int
  | Jack
  | Queen
  | King
  | Ace

type card =
  { suit : suit
  ; rank : rank
  }

let make_numbered_rank = function
  | x when 2 <= x && x <= 10 -> Some (Num x)
  | _ -> None
;;

let card1 = { suit = Clubs; rank = Ace }
let card2 = { suit = Hearts; rank = Queen }
let card3 = { suit = Diamonds; rank = Num 2 }
let card4 = { suit = Spades; rank = Num 7 }

let () =
  assert (make_numbered_rank 1 = None);
  assert (make_numbered_rank 2 = Some (Num 2));
  assert (make_numbered_rank 10 = Some (Num 10));
  assert (make_numbered_rank 11 = None)
;;

(* Task 2 — Extension: order ranks.
   Define [compare_rank a b] so numbered ranks use their integer order and
   [Jack < Queen < King < Ace], with every face rank greater than every numbered
   rank. Return a negative integer, zero, or a positive integer as usual.

   Test [Num 2] against [Num 10], [Num 10] against [Jack], [Ace] against [King],
   and equality.
   Example form:
   [let compare_size a b = match (a, b) with | Small, Small | Large, Large -> 0 | Small, Large -> -1 | Large, Small -> 1]
   Build and run before continuing. *)

let rank_key = function
  | Num n -> n
  | Jack -> 11
  | Queen -> 12
  | King -> 13
  | Ace -> 14
;;

let compare_rank a b = Int.compare (rank_key a) (rank_key b)

let () =
  assert (compare_rank (Num 2) (Num 10) < 0);
  assert (compare_rank (Num 10) Jack < 0);
  assert (compare_rank Ace King > 0);
  assert (compare_rank Queen Queen = 0)
;;

(* Task 3 — Check pattern coverage.
   For each pattern below, write in a comment a nonempty [int option list] that
   does not match it, or explain why no such nonempty list exists:

   - [Some x :: tl] -> [None] 
   - [[Some x; _]] -> [[None]] list of empty list
   - [[Some 3110; None]] -> [[Some 3110]] -> list of non zero number of items
   - [h1 :: h2 :: tl] -> any list of less than size 2 e.g. [Some singleton]
   - [h :: tl] -> this matches every nonempty list so no valid counterexample

   The point is to distinguish patterns that match one exact list shape from
   patterns that match every nonempty list.

   Extension: define [starts_with_some xs] to return true when the first element
   is [Some _], and false for [None :: _] or []. Before coding, record why
   patterns [Some _ :: _] and [None :: _] still need an [] case.

   Test [], [None], and [Some 1; None].
   Example form: [let begins_ok = function Ok _ :: _ -> true | _ -> false]
   Build and run before continuing. *)

let starts_with_some = function
  | Some _ :: _ -> true
  | _ -> false
;;

let () =
  assert (starts_with_some [] = false);
  assert (starts_with_some [ None ] = false);
  assert (starts_with_some [ Some 1; None ] = true)
;;

(* Task 4 — Classify quadrants with closed variants.
   Define [sign] with [Neg], [Zero], and [Pos]. Define [quad] with [I], [II],
   [III], and [IV]. Define [sign x], then define [quadrant (x, y)] using patterns
   and no guards. Return [None] when either coordinate is zero.

   Test one point in each quadrant, the origin, and one point on each axis.
   Example form: [let classify = function Left, Up -> Northwest | _ -> Center]
   Build and run before continuing. *)

type sign =
  | Neg
  | Zero
  | Pos

type quad =
  | I
  | II
  | III
  | IV

let sign x = if x < 0 then Neg else if x = 0 then Zero else Pos

let quadrant (x, y) =
  match sign x, sign y with
  | Pos, Pos -> Some I
  | Neg, Pos -> Some II
  | Neg, Neg -> Some III
  | Pos, Neg -> Some IV
  | Zero, _ | _, Zero -> None
;;

let () =
  assert (quadrant (1, 1) = Some I);
  assert (quadrant (-1, 1) = Some II);
  assert (quadrant (-1, -1) = Some III);
  assert (quadrant (1, -1) = Some IV);
  assert (quadrant (0, 0) = None);
  assert (quadrant (0, 2) = None);
  assert (quadrant (2, 0) = None)
;;

(* Task 5 — Classify quadrants with guards.
   Define [quadrant_guarded (x, y)] with guards and without calling [sign]. It
   must have exactly the same result as [quadrant]. Test agreement on the seven
   cases from Task 4.
   Example form: [let direction (x, y) = match x, y with x, _ when x > 0 -> `Right | _ -> `Other]
   Build and run before continuing. *)

let quadrant_guarded (x, y) =
  match x, y with
  | x, y when x > 0 && y > 0 -> Some I
  | x, y when x < 0 && y > 0 -> Some II
  | x, y when x < 0 && y < 0 -> Some III
  | x, y when x > 0 && y < 0 -> Some IV
  | x, y when x = 0 || y = 0 -> None
  | _, _ -> invalid_arg "impossible case!"
;;

let () =
  assert (quadrant_guarded (1, 1) = Some I);
  assert (quadrant_guarded (-1, 1) = Some II);
  assert (quadrant_guarded (-1, -1) = Some III);
  assert (quadrant_guarded (1, -1) = Some IV);
  assert (quadrant_guarded (0, 0) = None);
  assert (quadrant_guarded (0, 2) = None);
  assert (quadrant_guarded (2, 0) = None)
;;

(* Task 6 — Use polymorphic variants.
   Define [sign_poly x] returning [`Neg], [`Zero], or [`Pos]. Define
   [quadrant_poly point] returning [Some `I], [Some `II], [Some `III],
   [Some `IV], or [None] on an axis.

   Test -1, 0, and 1 with [sign_poly], and test quadrants II and IV plus an axis.
   Example form: [let traffic_light = function 0 -> `Red | _ -> `Green]
   Build and run before continuing. *)

let sign_poly x = if x < 0 then `Neg else if x = 0 then `Zero else `Pos

let quadrant_poly (x, y) =
  match sign_poly x, sign_poly y with
  | `Pos, `Pos -> Some I
  | `Neg, `Pos -> Some II
  | `Neg, `Neg -> Some III
  | `Pos, `Neg -> Some IV
  | `Zero, _ | _, `Zero -> None
  | _, _ -> None
;;

let () =
  assert (quadrant_poly (1, 1) = Some I);
  assert (quadrant_poly (-1, 1) = Some II);
  assert (quadrant_poly (-1, -1) = Some III);
  assert (quadrant_poly (1, -1) = Some IV);
  assert (quadrant_poly (0, 0) = None);
  assert (quadrant_poly (0, 2) = None);
  assert (quadrant_poly (2, 0) = None)
;;

(* Task 7 — Extension: classify axes without changing [quad].
   Define [classify_axis point] returning [`Origin], [`Axis_x], [`Axis_y], or
   [`Quadrant q] for a value [q : quad]. Test the origin, both axes, and one
   quadrant.
   Example form: [let wrap color = `Colored color]
   Build and run before continuing. *)

let classify_axis point =
  match point with
  | 0, 0 -> `Origin
  | 0, _ -> `Axis_y
  | _, 0 -> `Axis_x
  | point ->
    (match quadrant point with
     | Some q -> `Quadrant q
     | None -> invalid_arg "impossible ;(")
;;

let () =
  assert (classify_axis (0, 0) = `Origin);
  assert (classify_axis (0, 4) = `Axis_y);
  assert (classify_axis (-3, 0) = `Axis_x);
  assert (classify_axis (2, -5) = `Quadrant IV)
;;

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

type 'a nested =
  | Atom of 'a
  | Group of 'a nested list

let rec flatten xs =
  match xs with
  | [] -> []
  | item :: rest ->
    (match item with
     | Atom x -> [ x ]
     | Group children -> flatten children)
    @ flatten rest
;;

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

type 'a run =
  | Single of 'a
  | Repeat of int * 'a

let add_n n item acc_rev =
  let rec loop remaining acc =
    match remaining with
    | 0 -> acc
    | _ -> loop (remaining - 1) (item :: acc)
  in
  loop n acc_rev
;;

let decode_runs = function
  | [] -> Ok []
  | xs ->
    let rec loop acc_list tail =
      match tail with
      | [] -> Ok (List.rev acc_list)
      | Single item :: rest -> loop (item :: acc_list) rest
      | Repeat (n, item) :: rest ->
        if n < 2 then Error "invalid run length" else loop (add_n n item acc_list) rest
    in
    loop [] xs
;;

let () = print_endline "e06 all done :3"

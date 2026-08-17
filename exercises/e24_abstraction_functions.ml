(** E24 — Abstraction functions and invariants (85-115 min)

    Build: [opam exec -- dune build exercises/e24_abstraction_functions.exe] Run:
    [opam exec -- dune exec exercises/e24_abstraction_functions.exe] *)

(* Task 1 — Construct closed intervals.
   Begin module [Interval]. Use record representation
   [{ lo : float; hi : float }] with invariant [lo <= hi]. Define [rep_ok x] to
   return [x] when the invariant holds and raise [Invalid_argument "interval"]
   otherwise. Define [make a b] to represent the closed interval from the lesser
   endpoint to the greater endpoint, so it always satisfies the invariant.

   Test [make (-2.0) 3.0], reversed inputs 3.0 and -2.0, and direct [rep_ok] on
   an invalid internal record.
   Build and run before continuing. *)

(* Task 2 — Observe intervals.
   Define [bounds interval] to return [(lo, hi)]. Define [contains x interval]
   to return [lo <= x && x <= hi]. Define [pp formatter interval] to print
   ["[lo, hi]"] using [%g] for both floats.

   Test both endpoints, an interior point, an outside point, and the rendered
   interval [-2.0, 3.0].
   Build and run before continuing. *)

(* Task 3 — Add intervals.
   Define [add [a,b] [c,d]] as [[a+c, b+d]], routing the result through [make].
   Test [-2,3] + [4,5] = [2,8] and addition with [0,0].
   Build and run before continuing. *)

(* Task 4 — Multiply intervals.
   Define [mul [a,b] [c,d]] as the interval whose bounds are the minimum and
   maximum of [a*c], [a*d], [b*c], and [b*d].

   Test [-2,3] * [4,5] = [-10,15], two negative intervals, and multiplication
   by [0,0]. Then seal [Interval] with abstract [t] and its six public operations.
   Build and run before continuing. *)

(* Task 5 — Define maps as functions.
   Define module [Function_map] with [('k, 'v) t = 'k -> 'v option]. Define
   [empty key = None], [find key map = map key], and [mem key map] according to
   whether [find] returns [Some _].

   Test two absent keys in [empty].
   Build and run before continuing. *)

(* Task 6 — Add persistent map updates.
   Define [add key value map] to return a new function yielding [Some value] for
   equal [key] and otherwise delegating to [map]. Define [remove key map] to
   return [None] for that key and delegate otherwise.

   Test x=1 and y=2, shadow x with 3, remove x, and verify every older map still
   returns its old values.
   Build and run before continuing. *)

(* Task 7 — Generalize updates.
   Define [update key f map] so the returned map yields [f (map key)] at [key]
   and delegates elsewhere. Test incrementing x=1 to x=11 with
   [Option.map (( + ) 10)] and creating an absent key with a function returning
   [Some 5]. Explain why no [bindings] operation can enumerate an arbitrary
   function map.
   Build and run before continuing. *)

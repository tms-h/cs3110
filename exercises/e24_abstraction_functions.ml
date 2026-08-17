(** E24 — Abstraction functions and representation invariants (40-50 min)

    OUTCOME

    - Write an abstraction function, RI, and [rep_ok] before implementation.
    - Contrast constrained data with a representation that is executable code.

    STEP 1 — SPECIFY CLOSED INTERVALS

    - Fill the interval AF and RI blocks.
    - Require [lo <= hi] and reject NaNs.
    - Decide whether [make] reorders endpoints or rejects reversed input.
    - Document that decision before implementing [rep_ok] and [make].

    STEP 2 — IMPLEMENT INTERVAL OPERATIONS

    - Implement [bounds] and [contains].
    - Implement [add].
    - For [mul], calculate all four endpoint products, especially across zero.
    - Implement [pp] with Format composition, not string concatenation.

    STEP 3 — DEFINE THE FUNCTION-MAP AF

    - Write the AF for representation ['k -> 'v option].
    - Explain why an enumerable [bindings] operation is unavailable.
    - Implement [find], [mem], [add], and [remove] in source order.

    STEP 4 — CHECK PERSISTENCE

    - Implement [update].
    - Keep references to the old and new maps.
    - Verify each map continues to return its own value for the same key.

    FINISH

    - Run [opam exec -- dune exec exercises/e24_abstraction_functions.exe].

    Source coverage: interval arithmetic; function maps. *)

module Interval : sig
  type t

  val make : float -> float -> t
  val bounds : t -> float * float
  val contains : float -> t -> bool
  val add : t -> t -> t
  val mul : t -> t -> t
  val pp : Format.formatter -> t -> unit
end = struct
  type t = { lo : float; hi : float }

  let rep_ok (_x : t) : t = failwith "TODO: assert RI"
  let make (_a : float) (_b : float) : t = failwith "TODO"
  let bounds (_x : t) : float * float = failwith "TODO"
  let contains (_x : float) (_interval : t) : bool = failwith "TODO"
  let add (_a : t) (_b : t) : t = failwith "TODO"
  let mul (_a : t) (_b : t) : t = failwith "TODO: four products"
  let pp (_formatter : Format.formatter) (_x : t) : unit = failwith "TODO"
end

module Function_map = struct
  type ('k, 'v) t = 'k -> 'v option

  let empty : ('k, 'v) t = fun _ -> None
  let find (_key : 'k) (_map : ('k, 'v) t) : 'v option = failwith "TODO"
  let mem (_key : 'k) (_map : ('k, 'v) t) : bool = failwith "TODO"
  let add (_key : 'k) (_value : 'v) (_map : ('k, 'v) t) : ('k, 'v) t = failwith "TODO"
  let remove (_key : 'k) (_map : ('k, 'v) t) : ('k, 'v) t = failwith "TODO"

  let update (_key : 'k) (_f : 'v option -> 'v option) (_map : ('k, 'v) t) : ('k, 'v) t
      =
    failwith "TODO: transfer"
end

(* INTERVAL AF: ...
   INTERVAL RI: ...
   FUNCTION MAP AF: ...
   WHY BINDINGS IS IMPOSSIBLE: ... *)

let () =
  let x = Interval.make (-2.) 3. and y = Interval.make 4. 5. in
  assert (Interval.bounds (Interval.add x y) = (2., 8.));
  assert (Interval.bounds (Interval.mul x y) = (-10., 15.));
  assert (Interval.contains 0. x && not (Interval.contains 4. x));
  let m0 = Function_map.empty in
  let m1 = m0 |> Function_map.add "x" 1 |> Function_map.add "y" 2 in
  let m2 = Function_map.update "x" (Option.map (( + ) 10)) m1 in
  assert (
    Function_map.find "x" m0 = None
    && Function_map.find "x" m1 = Some 1
    && Function_map.find "x" m2 = Some 11);
  assert (Function_map.find "x" (Function_map.remove "x" m2) = None);
  print_endline "E24 complete"

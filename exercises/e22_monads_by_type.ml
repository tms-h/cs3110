(** E22 — Monads by following the types (40-50 min)

    OUTCOME

    - Derive [fmap], [join], and [bind] from one another.
    - Work through abstract Maybe and list representations without casts.

    STEP 1 — COMPLETE MAYBE DIRECTLY

    - Implement [Maybe.bind], [Maybe.fmap], and [Maybe.join] by matching.
    - Outside the module, implement [add] with only [return] and [bind].
    - Do not use [Some] or [None] in [add].

    STEP 2 — REMOVE REPRESENTATION KNOWLEDGE

    - Implement [Derived.fmap] and [Derived.join].
    - Use only the supplied [bind] and [return].
    - Do not pattern-match on an unknown representation.

    STEP 3 — DERIVE BIND THE OTHER WAY

    - Implement [Make_bind.bind] from [fmap] and [join].
    - Let type errors guide expression shape.
    - Do not add casts or inspect [M.t].

    STEP 4 — IMPLEMENT THE LIST MONAD

    - Predict result ordering for the supplied [x -> [x; -x]] example.
    - Implement [return], [fmap], [join], and [bind].
    - Check the observed ordering against the prediction.

    STEP 5 — TEST THE LAWS

    - Add executable left-identity, right-identity, and associativity checks.
    - Cover [Trivial] and representative finite Maybe and List inputs.
    - Explain what those tests establish and what still requires proof.

    FINISH

    - Run [opam exec -- dune exec exercises/e22_monads_by_type.exe].

    Source coverage: add opt; fmap and join; fmap and join again; bind from fmap+join;
    list monad; trivial monad laws. *)

module type EXT_MONAD = sig
  type 'a t

  val return : 'a -> 'a t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val fmap : 'a t -> ('a -> 'b) -> 'b t
  val join : 'a t t -> 'a t
end

module Maybe : sig
  include EXT_MONAD

  val of_option : 'a option -> 'a t
  val to_option : 'a t -> 'a option
end = struct
  type 'a t = 'a option

  let return x = Some x
  let bind (_m : 'a t) (_f : 'a -> 'b t) : 'b t = failwith "TODO"
  let fmap (_m : 'a t) (_f : 'a -> 'b) : 'b t = failwith "TODO: direct match"
  let join (_m : 'a t t) : 'a t = failwith "TODO: direct match"
  let of_option x = x
  let to_option x = x
end

let add (_a : int Maybe.t) (_b : int Maybe.t) : int Maybe.t =
  failwith "TODO: no Some/None"

module Derived (M : sig
  type 'a t

  val return : 'a -> 'a t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
end) =
struct
  let fmap (_m : 'a M.t) (_f : 'a -> 'b) : 'b M.t = failwith "TODO"
  let join (_m : 'a M.t M.t) : 'a M.t = failwith "TODO"
end

module type FMAP_JOIN = sig
  type 'a t

  val return : 'a -> 'a t
  val fmap : 'a t -> ('a -> 'b) -> 'b t
  val join : 'a t t -> 'a t
end

module Make_bind (M : FMAP_JOIN) = struct
  let bind (_m : 'a M.t) (_f : 'a -> 'b M.t) : 'b M.t = failwith "TODO"
end

module List_monad : EXT_MONAD with type 'a t = 'a list = struct
  type 'a t = 'a list

  let return (_x : 'a) : 'a t = failwith "TODO"
  let fmap (_m : 'a t) (_f : 'a -> 'b) : 'b t = failwith "TODO"
  let join (_m : 'a t t) : 'a t = failwith "TODO"
  let bind (_m : 'a t) (_f : 'a -> 'b t) : 'b t = failwith "TODO"
end

module Trivial = struct
  type 'a t = Wrap of 'a

  let return x = Wrap x
  let bind (Wrap x) f = f x
end

(* LAW TESTS / PROOF SKETCHES: ... *)

let () =
  assert (
    Maybe.to_option (add (Maybe.of_option (Some 2)) (Maybe.of_option (Some 3))) = Some 5);
  assert (Maybe.to_option (add (Maybe.of_option None) (Maybe.of_option (Some 3))) = None);
  assert (List_monad.bind [ 1; 2; 3 ] (fun x -> [ x; -x ]) = [ 1; -1; 2; -2; 3; -3 ]);
  let open Trivial in
  assert (bind (return 3) (fun x -> Wrap (x + 1)) = Wrap 4);
  print_endline "E22 complete"

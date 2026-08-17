(** E29 — Equational specifications (30-45 min)

    OUTCOME

    - Classify operations as generators, manipulators, or queries.
    - Turn algebraic equations into implementation-independent tests.

    STEP 1 — SPECIFY LISTISH

    - Classify [nil], [cons], [append], and [length].
    - Write equations that reduce any query built from [nil] and [cons].
    - Identify one redundant equation that remains useful to clients.

    STEP 2 — SPECIFY BAG

    - Classify every [BAG] operation.
    - Write equations for [is_empty], [multiplicity], and [remove].
    - Ensure [remove] decreases multiplicity by at most one.

    STEP 3 — CHALLENGE THE SPEC

    - Invent a devious implementation that satisfies the current equations but violates
      your intent.
    - Add the missing equation before writing implementation code.

    STEP 4 — IMPLEMENT AND TEST THE EQUATIONS

    - Choose and state a [List_bag] representation invariant.
    - Implement the operations in source order.
    - Turn every equation into at least one executable test.

    STEP 5 — DEFINE CLIENT EQUALITY

    - State observational equivalence for bags.
    - Explain why list structural equality is not the client-level relation.
    - Run [opam exec -- dune exec exercises/e29_equational_specifications.exe].

    Source coverage: list spec; bag spec. *)

module type LISTISH = sig
  type 'a t

  val nil : 'a t
  val cons : 'a -> 'a t -> 'a t
  val append : 'a t -> 'a t -> 'a t
  val length : 'a t -> int
end

module type BAG = sig
  type 'a t

  val empty : 'a t
  val is_empty : 'a t -> bool
  val insert : 'a -> 'a t -> 'a t
  val multiplicity : 'a -> 'a t -> int
  val remove : 'a -> 'a t -> 'a t
end

module List_bag : BAG = struct
  type 'a t = 'a list

  let empty = []
  let is_empty (_bag : 'a t) : bool = failwith "TODO"
  let insert (_x : 'a) (_bag : 'a t) : 'a t = failwith "TODO"
  let multiplicity (_x : 'a) (_bag : 'a t) : int = failwith "TODO"
  let remove (_x : 'a) (_bag : 'a t) : 'a t = failwith "TODO: at most one"
end

(* LISTISH CLASSIFICATION:
   LISTISH EQUATIONS:

   BAG CLASSIFICATION:
   BAG EQUATIONS:

   BAG OBSERVATIONAL EQUIVALENCE:
*)

let () =
  let open List_bag in
  let b = empty |> insert "x" |> insert "y" |> insert "x" in
  assert (not (is_empty b));
  assert (multiplicity "x" b = 2 && multiplicity "z" b = 0);
  assert (multiplicity "x" (remove "x" b) = 1);
  assert (multiplicity "z" (remove "z" b) = 0);
  print_endline "E29 complete"

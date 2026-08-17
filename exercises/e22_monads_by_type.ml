(** E22 — Monads from their types (85-115 min)

    Build: [opam exec -- dune build exercises/e22_monads_by_type.exe] Run:
    [opam exec -- dune exec exercises/e22_monads_by_type.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e22_monads_by_type.ml] *)

(* Task 1 — Define the extended monad interface.
   Define module type [EXT_MONAD] with type constructor ['a t] and operations:
   [return : 'a -> 'a t], [bind : 'a t -> ('a -> 'b t) -> 'b t],
   [fmap : 'a t -> ('a -> 'b) -> 'b t], and [join : 'a t t -> 'a t].

   Run interface inspection and verify each type variable occurs in the intended
   positions.
   Build and run before continuing. *)

(* Task 2 — Implement the maybe monad directly.
   Define unsealed [Maybe_impl] with ['a t = 'a option], identity [of_option] and
   [to_option], [return x = Some x], and direct pattern-matching implementations
   of [bind], [fmap], and [join]. None must propagate without calling a supplied
   function.

   Test every operation with [Some] and [None], including [join (Some None)].
   Build and run before continuing. *)

(* Task 3 — Seal [Maybe] and add optional integers.
   Seal [Maybe_impl] as [Maybe], exposing [EXT_MONAD] plus [of_option] and
   [to_option]. Define [add a b] using only [Maybe.bind] and [Maybe.return], with
   no direct [Some] or [None] match.

   Test 2 + 3 produces [Some 5], and either missing operand produces [None].
   Build and run before continuing. *)

(* Task 4 — Derive [fmap] and [join] from bind.
   Define functor [Derived] taking a module with ['a t], [return], and [bind]. Its
   result defines [fmap m f = bind m (fun x -> return (f x))] and
   [join mm = bind mm (fun m -> m)].

   Instantiate it for [Maybe]. Test derived map on [Some 3] and [None], and
   derived join on [Some (Some 4)] and [Some None].
   Build and run before continuing. *)

(* Task 5 — Derive bind from [fmap] and [join].
   Define module type [FMAP_JOIN] with ['a t], [return], [fmap], and [join].
   Define functor [Make_bind] with [bind m f = join (fmap m f)].

   Instantiate it for [Maybe]. Test binding [Some 3] to [Some 4] and binding
   [None] without calling the function.
   Build and run before continuing. *)

(* Task 6 — Implement the list monad.
   Define [List_monad : EXT_MONAD with type 'a t = 'a list]. [return x] is [x],
   [fmap] preserves list order, [join] concatenates nested lists in order, and
   [bind] maps then concatenates.

   Test empty inputs and test binding [1; 2; 3] with
   [fun x -> [x; -x]] produces [1; -1; 2; -2; 3; -3].
   Build and run before continuing. *)

(* Task 7 — Check monad laws on a trivial monad.
   Define [Trivial] with ['a t = Wrap of 'a], [return x = Wrap x], and
   [bind (Wrap x) f = f x]. Write runtime assertions for left identity, right
   identity, and associativity using integer functions.

   Add a comment explaining why these examples illustrate but do not prove the
   polymorphic laws.
   Build and run before continuing. *)

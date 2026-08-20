(** E22 — Monads from their types and laws (85-115 min)

    Build: [opam exec -- dune build exercises/e22_monads_by_type.exe] Run:
    [opam exec -- dune exec exercises/e22_monads_by_type.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e22_monads_by_type.ml] *)

(* Task 1 — Define the extended monad interface.
   Define module type [EXT_MONAD] with type constructor ['a t], [return], infix
   bind [(>>=)], infix fmap [(>>|)], and [join]. Use these exact types:
   [return : 'a -> 'a t], [(>>=) : 'a t -> ('a -> 'b t) -> 'b t],
   [(>>|) : 'a t -> ('a -> 'b) -> 'b t], and [join : 'a t t -> 'a t].
   Inspect the interface and explain the one type-level difference between bind
   and fmap.
   Build and run before continuing. *)

(* Task 2 — Implement the Maybe monad directly.
   Define unsealed [Maybe_impl] with ['a t = 'a option], conversion functions to
   and from [option], [return], and direct pattern-matching implementations of
   [(>>=)], [(>>|)], and [join]. In the bodies of fmap and join, do not use bind
   or return. [None] must propagate without calling a supplied function.

   Test every operation on relevant [Some] and [None] partitions, including
   [join (Some None)].
   Build and run before continuing. *)

(* Task 3 — Add optional integers outside the representation.
   Seal [Maybe_impl] behind [EXT_MONAD] plus the two conversion functions. Define
   [add : int Maybe.t -> int Maybe.t -> int Maybe.t] outside the module using
   only bind and return; its body may not mention [Some] or [None]. Test two
   present operands and each missing-operand position.
   Build and run before continuing. *)

(* Task 4 — Derive fmap and join from bind.
   Define a functor taking only a type constructor, return, and bind. Derive
   [(>>|)] and [join] without inspecting the representation. Instantiate it for
   [Maybe] and test the same partitions as Task 2.
   Build and run before continuing. *)

(* Task 5 — Derive bind from fmap and join.
   Define a signature containing a type constructor, return, fmap, and join,
   then a functor that derives bind. Instantiate it for [Maybe]. Test a present
   input and prove with a counter that a function is not called for a missing
   input.
   Build and run before continuing. *)

(* Task 6 — Implement the list monad.
   Define [ListMonad : EXT_MONAD with type 'a t = 'a list]. [return x] yields the
   singleton list [x :: []]. Fmap preserves order, join concatenates nested lists
   in order, and bind maps then concatenates.

   Test empty inputs and all four operations. In particular, binding [1;2;3]
   with [fun x -> [x; -x]] must produce [1;-1;2;-2;3;-3]. Explain why this
   denotes multiple results rather than concurrent execution.
   Build and run before continuing. *)

(* Task 7 — Prove the trivial monad laws.
   Define [Trivial] with ['a t = Wrap of 'a], [return x = Wrap x], and
   [Wrap x >>= f = f x]. In comments, prove for arbitrary values and functions:

   - left identity: [return x >>= f = f x];
   - right identity: [m >>= return = m];
   - associativity: [(m >>= f) >>= g = m >>= (fun x -> f x >>= g)].

   For each proof, quantify the variables, unfold the definitions one step at a
   time, and show both sides reduce to the same expression. Integer examples are
   not a proof.
   Build and run before continuing. *)

(* Extension — Executable law checks.
   Add representative runtime assertions for all three laws using at least two
   different functions. Explain why those checks can catch an implementation
   regression but cannot establish the polymorphic laws. *)

(* Final task — Completion marker.
   Only after the three symbolic proofs and every required assertion are
   present, make the completed program print exactly [E22 passed] once. *)

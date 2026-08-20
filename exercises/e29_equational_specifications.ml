(** E29 — Equational specifications (80-110 min)

    Build: [opam exec -- dune build exercises/e29_equational_specifications.exe] Run:
    [opam exec -- dune exec exercises/e29_equational_specifications.exe] *)

(* Task 1 — Specify a list-like abstraction.
   Define module type [LISTISH] with ['a t], [nil], [cons], [append], and [length].
   Use [nil : 'a t], [cons : 'a -> 'a t -> 'a t],
   [append : 'a t -> 'a t -> 'a t], and [length : 'a t -> int]. Classify [nil]
   and [cons] as generators, [append] as a manipulator, and [length] as a query.

   In comments, write separate equations for [append nil right],
   [append (cons x left) right], [length nil], [length (cons x list)], and
   [length (append left right)]. State which variables each equation quantifies.
   Implement [Listish_list] with ordinary lists and test every equation on
   concrete integer lists, including an empty right operand.
   Example form: [(* size (add x collection) = size collection + 1 *)]
   Build and run before continuing. *)

(* Task 2 — Specify a bag interface.
   Define module type [BAG] with ['a t], [empty], [is_empty], [insert],
   [multiplicity], and [remove]. Use [empty : 'a t],
   [is_empty : 'a t -> bool], [insert : 'a -> 'a t -> 'a t],
   [multiplicity : 'a -> 'a t -> int], and [remove : 'a -> 'a t -> 'a t].
   [multiplicity x bag] is the number of x values; [remove x bag] decreases that
   number by one when positive and changes nothing otherwise.

   In comments, classify [empty] and [insert] as generators, [remove] as a
   manipulator, and [is_empty] and [multiplicity] as queries. Write query laws for
   [is_empty empty], [is_empty (insert x bag)], [multiplicity item empty], and
   [multiplicity item (insert x bag)], splitting the last law on whether item=x.
   Write manipulator laws for [remove x empty] and
   [remove x (insert y bag)], splitting on whether x=y. Explain how these laws
   reduce any query over a generated-and-manipulated bag to a result.
   Example form: [module type COUNTS = sig type 'a t val blank : 'a t val count : 'a -> 'a t -> int end]
   Build and run before continuing. *)

(* Extension Task 3 — Implement a list-backed bag.
   Define [List_bag : BAG] with list representation. [insert] may prepend.
   [remove] removes exactly the first matching element. [is_empty] and
   [multiplicity] must depend only on bag contents.

   Test empty, insert x/y/x, multiplicities of x and absent z, one removal of x,
   repeated removal, and removal of z.
   Example form: [let rec first = function [] -> None | x :: _ -> Some x]
   Build and run before continuing. *)

(* Extension Task 4 — Test every bag equation.
   Turn every equation from Task 2 into at least one runtime assertion using
   [List_bag]. Include equal and unequal inserted elements so both branches of
   the multiplicity and remove equations are exercised.
   Example form: [assert (Counts.count item (Counts.add item Counts.empty) = 1)]
   Build and run before continuing. *)

(* Extension Task 5 — Define equality on a finite observation domain.
   Define [bag_equal_on universe a b] to return true exactly when every element
   in the finite [universe] has equal multiplicity in [a] and [b]. Duplicate
   values in [universe] do not affect the result. This is equality only on the
   supplied observation domain, not global equality of arbitrary bags.

   Test differently ordered bags with equal multiplicities, unequal bags, and a
   universe containing duplicates. Also give two bags that compare equal on a
   universe while differing on a value outside it. Explain why list equality is
   not bag equality and why [bag_equal_on] needs the domain qualification.
   Example form: [let equal_on domain left right = List.for_all (fun x -> observe x left = observe x right) domain]
   After every required equation, explanation, and assertion in E29 is present
   and passing, print the exact line ["E29 passed"] once, and not earlier.
   Build and run before continuing. *)

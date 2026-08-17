(** E29 — Equational specifications (75-100 min)

    Build: [opam exec -- dune build exercises/e29_equational_specifications.exe] Run:
    [opam exec -- dune exec exercises/e29_equational_specifications.exe] *)

(* Task 1 — Specify a list-like abstraction.
   Define module type [LISTISH] with ['a t], [nil], [cons], [append], and [length].
   Use [nil : 'a t], [cons : 'a -> 'a t -> 'a t],
   [append : 'a t -> 'a t -> 'a t], and [length : 'a t -> int]. Classify [nil]
   and [cons] as generators, [append] as a manipulator, and [length] as a query.

   In comments, write equations for append with nil and cons, and length of nil,
   cons, and append. Implement [Listish_list] with ordinary lists and test every
   equation on concrete integer lists.
   Build and run before continuing. *)

(* Task 2 — Specify a bag interface.
   Define module type [BAG] with ['a t], [empty], [is_empty], [insert],
   [multiplicity], and [remove]. Use [empty : 'a t],
   [is_empty : 'a t -> bool], [insert : 'a -> 'a t -> 'a t],
   [multiplicity : 'a -> 'a t -> int], and [remove : 'a -> 'a t -> 'a t].
   [multiplicity x bag] is the number of x values; [remove x bag] decreases that
   number by one when positive and changes nothing otherwise.

   In comments, classify operations and write equations for all queries over
   empty, insert, and remove.
   Build and run before continuing. *)

(* Task 3 — Implement a list-backed bag.
   Define [List_bag : BAG] with list representation. [insert] may prepend.
   [remove] removes exactly the first matching element. [is_empty] and
   [multiplicity] must depend only on bag contents.

   Test empty, insert x/y/x, multiplicities of x and absent z, one removal of x,
   repeated removal, and removal of z.
   Build and run before continuing. *)

(* Task 4 — Test every bag equation.
   Turn every equation from Task 2 into at least one runtime assertion using
   [List_bag]. Include equal and unequal inserted elements so both branches of
   the multiplicity and remove equations are exercised.
   Build and run before continuing. *)

(* Task 5 — Define observational bag equality.
   Define [bag_equal universe a b] to return true exactly when every element in
   the finite [universe] has equal multiplicity in [a] and [b]. Duplicate values
   in [universe] do not affect the result.

   Test differently ordered bags with equal multiplicities, unequal bags, and a
   universe containing duplicates. Explain why list equality is not bag equality.
   Build and run before continuing. *)

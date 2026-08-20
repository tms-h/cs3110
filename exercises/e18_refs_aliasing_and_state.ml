(** E18 — References and state transitions (65-90 min)

    Build: [opam exec -- dune build exercises/e18_refs_aliasing_and_state.exe] Run:
    [opam exec -- dune exec exercises/e18_refs_aliasing_and_state.exe] *)

(* Task 1 — Mutate a record field.
   Define record [student] with immutable [name : string] and mutable
   [gpa : float]. Define Alice with GPA 3.7, mutate it to 4.0, and assert both the
   changed GPA and unchanged name. Then package the assignment as
   [set_gpa : student -> float -> unit].
   Build and run before continuing. *)

(* Task 2 — Construct reference shapes.
   Define expressions with types [bool ref], [int list ref], and [int ref list].
   Annotate each expression, check it in the program, and draw the three heap
   shapes in comments. For the last shape, use two separately allocated cells
   that initially contain the same integer so allocation, not contents,
   distinguishes them.
   Build and run before continuing. *)

(* Task 3 — Store a function in a reference.
   Define [inc = ref (fun x -> x + 1)]. Dereference and apply it to produce 3110.
   Then assign a function that adds 2, assert the changed result, restore the
   original behavior, and assert 3110 again.
   Build and run before continuing. *)

(* Task 4 — Define addition assignment.
   Before implementing it, write the intended type of infix [(+:=)]. Define it
   so [cell +:= amount] adds [amount] to the integer stored in [cell] and returns
   unit. Test zero, a positive amount, and a negative amount.
   Build and run before continuing. *)

(* Task 5 — Predict physical and structural equality.
   Define exactly [x = ref 0], [y = x], and [z = ref 0]. Before running any of
   the following, record predictions for [x == y], [x == z], [x = y], [x = z],
   then mutate [x := 1] and predict [x = y] and [x = z].

   Assert every prediction. Explain why physical equality is meaningful here
   because refs are mutable locations, but is not a general content test.
   Build and run before continuing. *)

(* Extension — Aliasing utilities.
   Define [swap] for two refs using one saved value; test distinct cells and a
   cell swapped with itself. Then define [apply_atomically cell update]. If
   [update !cell] succeeds, store its result. If it raises, restore the old
   value and re-raise the same exception. Test both paths, including an update
   closure that mutates [cell] before raising. *)

(* Final task — Completion marker.
   Only after every prediction, assertion, heap drawing, and explanation is
   present and passing, make the completed program print exactly [E18 passed]
   once. *)

(** E18 — References and state transitions (65-90 min)

    Build: [opam exec -- dune build exercises/e18_refs_aliasing_and_state.exe] Run:
    [opam exec -- dune exec exercises/e18_refs_aliasing_and_state.exe] *)

(* Task 1 — Mutate a record field.
   Define record [student] with immutable [name : string] and mutable
   [gpa : float]. Define [raise_gpa student new_gpa] to assign the new GPA and
   return unit.

   Test changing Alice from 3.7 to 4.0 and verify her name is unchanged.
   Build and run before continuing. *)

(* Task 2 — Construct reference shapes.
   Define [bool_cell] containing true, [list_cell] containing [1; 2], and
   [cell_list] containing two distinct references to 3 and 4. Annotate them as
   [bool ref], [int list ref], and [int ref list].

   Test their dereferenced runtime values. Draw the three heap shapes in comments.
   Build and run before continuing. *)

(* Task 3 — Store a function in a reference.
   Define [step] as a reference containing integer increment. Define
   [reach_3110 ()] by dereferencing [step] and applying it to 3109.

   Test the initial result. Assign a function adding 2, test the new result 3111,
   then restore increment and test 3110 again.
   Build and run before continuing. *)

(* Task 4 — Define small mutation operators.
   Define infix [(+:=)] so [cell +:= amount] adds [amount] to the integer in
   [cell]. Define [swap a b] to exchange the contents of two references using one
   saved old value.

   Test adding 5 to a cell containing 10, swapping cells containing 1 and 2, and
   swapping one cell with itself.
   Build and run before continuing. *)

(* Task 5 — Observe aliasing safely.
   Define [x = ref [1; 2]], [y = x], and [z = ref [1; 2]]. Assert only their
   structural contents with [(=)]. Print the results of [x == y] and [x == z]
   without asserting either physical-equality result.

   Mutate [x] to [3] and assert the contents observed through [y] changed while
   [z] still contains [1; 2]. Explain why [(==)] is not a content test.
   Build and run before continuing. *)

(* Task 6 — Roll back a failed update.
   Define [apply_atomically cell update]. Compute [update !cell]; on success,
   assign the result. If [update] raises, restore the old value and re-raise the
   same exception.

   Test adding 10 to a cell containing 2. Then use an update that raises
   [Failure "boom"], test the exception message, and test the cell still contains
   12.
   Build and run before continuing. *)

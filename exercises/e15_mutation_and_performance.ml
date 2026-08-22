open! Core

(* E15 — Mutation and performance

   One file covers refs, aliasing, arrays, hash tables, measurement, and the
   engineering decision about where mutation belongs. *)

(* Task 1 — Predict aliasing.
   Create two references to the same mutable record and one structurally equal
   copy. Before mutating, predict structural and physical equality and the
   value observed through every alias afterward. Run only after recording the
   prediction. *)

(* Task 2 — Compare pure and in-place normalization.
   Implement a pure list function and an in-place array function that divide
   float values by their Euclidean norm. Define behavior for empty and all-zero
   inputs. Test that array rows or copies do not accidentally alias. *)

(* Task 3 — Count with a hash table.
   Implement frequency counting with [Hashtbl]. Use an explicit key module,
   not polymorphic hashing. Return deterministic sorted bindings at the public
   boundary and state the table invariant. *)

(* Task 4 — Measure the right thing.
   Generate fixed inputs large enough to compare the pure and mutable versions
   with [Time_ns]. Warm up first and avoid printing inside the timed region.
   Record observations without treating one run as a universal conclusion. *)

(* Task 5 — Choose the mutation boundary.
   State time complexity, peak additional space, allocation behavior, and
   aliasing risk for both versions. Give one case where mutation is justified
   and one where persistence is preferable.

   After all checks pass, print exactly [E15 passed] as the final output line. *)

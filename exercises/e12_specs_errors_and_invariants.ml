open! Core

(* E12 — Specifications, errors, and invariants

   This consolidates exceptions, contracts, abstraction functions,
   representation invariants, and atomic updates into one serious boundary. *)

(* Task 1 — Specify before implementing.
   Write a precise contract for
   [take_exact : int -> 'a list -> 'a list Or_error.t]. Cover negative counts,
   insufficient input, output length/order, and what remains unobservable.
   Then implement it without partial list operations. *)

(* Task 2 — Add context at error boundaries.
   Define [update_count : int String.Map.t -> string -> int ->
   int String.Map.t Or_error.t]. A missing key starts at zero; a result below
   zero is invalid; a result of zero removes the key. Errors must name the key
   and rejected result. Do not catch unrelated exceptions. *)

(* Task 3 — State and check the invariant.
   Write the abstraction function for the map as a multiset and the invariant
   that stored counts are strictly positive. Implement [invariant] by checking
   every binding. Deliberately construct one invalid map to test the checker. *)

(* Task 4 — Make a batch atomic.
   Implement [apply_batch] for a list of [(key, delta)] changes. Stop at the
   first error and return no partially updated map. Test success, failure in
   the middle, repeated keys, and preservation of the invariant.

   After all checks pass, print exactly [E12 passed] as the final output line. *)

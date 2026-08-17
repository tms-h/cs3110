(** E15 — Functors, include, and controlled reuse (30-45 min)

    OUTCOME

    - Generate modules from required capabilities.
    - Preserve useful type equalities while controlling the exported surface.

    STEP 1 — BUILD THE SMALLEST FUNCTOR

    - Read [TO_STRING] and the result signature of [Print].
    - Implement [Print.print].
    - Confirm the result exposes exactly [print] and accepts [M.t].

    STEP 2 — INSTANTIATE AND PREDICT SEALING

    - Instantiate the functor for [int] and [string].
    - Predict the client error if [type t = int] is hidden behind [type t].
    - Make that change temporarily, inspect the error, and revert it.

    STEP 3 — REUSE WITH INCLUDE

    - Build [String_with_print] from two [include] statements.
    - Export all [String] operations plus the generated printer.
    - Copy no printer implementation.

    STEP 4 — EXPLAIN THE ABSTRACTION

    - Fill the reuse explanation block.
    - Compare functors with C++ templates and dependency injection.
    - Name at least one important mismatch.

    STEP 5 — TRANSFER AND FINISH

    - Implement the [Debug] functor and [dump].
    - Inspect with [ocamlc -i exercises/e15_functors_and_include.ml].
    - Run [opam exec -- dune exec exercises/e15_functors_and_include.exe].

    Source coverage: ToString; Print; Print Int; Print String; Print Reuse; Print String
    reuse revisited. *)

module type TO_STRING = sig
  type t

  val to_string : t -> string
end

module Print (M : TO_STRING) : sig
  val print : M.t -> unit
end = struct
  let print (_x : M.t) = failwith "TODO"
end

module My_int = struct
  type t = int

  let to_string = string_of_int
end

module My_string = struct
  type t = string

  let to_string x = x
end

module Print_int = Print (My_int)
module Print_string = Print (My_string)

module String_with_print = struct
  include String
  include Print (My_string)
end

module type DEBUGGABLE = sig
  type t

  val to_debug_string : t -> string
end

module Debug (M : DEBUGGABLE) : sig
  val dump : M.t -> unit
end = struct
  let dump (_x : M.t) = failwith "TODO: prefix a useful label"
end

(* REUSE EXPLANATION: ...
   C++ COMPARISON: ... *)

let () =
  (* Uncomment these observational calls after implementing; they should print
     three lines without exposing extra values from the generated modules. *)
  Print_int.print 3110;
  Print_string.print "modules";
  String_with_print.print (String_with_print.uppercase_ascii "reuse");
  print_endline "E15 complete"

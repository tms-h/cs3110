(** E15 — Functors and [include] (75-100 min)

    Build: [opam exec -- dune build exercises/e15_functors_and_include.exe] Run:
    [opam exec -- dune exec exercises/e15_functors_and_include.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e15_functors_and_include.ml] *)

(* Task 1 — Define a printing functor.
   Define module type [TO_STRING] with type [t] and
   [to_string : t -> string]. Define functor [Print (M : TO_STRING)] whose result
   exposes only [print : M.t -> unit]. [print x] must print [M.to_string x]
   followed by a newline.

   Define one local argument module whose conversion increments a counter. Call
   its generated printer once and test that the counter equals 1.
   Build and run before continuing. *)

(* Task 2 — Instantiate the functor.
   Define [My_int] with [type t = int] and [to_string = string_of_int]. Define
   [My_string] with [type t = string] and identity conversion. Define
   [Print_int = Print (My_int)] and [Print_string = Print (My_string)].

   Test both conversion functions directly on 3110 and ["modules"], then call
   both generated printers with those values.
   Build and run before continuing. *)

(* Task 3 — Reuse with [include].
   Define [String_with_print] by including [String] and [Print (My_string)]. Do
   not copy either implementation.

   Test [String_with_print.uppercase_ascii "reuse"] equals ["REUSE"], then print
   that result with [String_with_print.print].
   Build and run before continuing. *)

(* Task 4 — Define a debugging functor.
   Define module type [DEBUGGABLE] with type [t] and
   [to_debug_string : t -> string]. Define functor [Debug] exposing only
   [dump : M.t -> unit], which prints ["DEBUG: " ^ M.to_debug_string x].

   Instantiate it for integers, test the underlying conversion on -7, and call
   [dump] on -7.
   Build and run before continuing. *)

(* Task 5 — Inspect generated interfaces.
   Run the inspection command. Add type annotations proving
   [Print_int.print : int -> unit] and [Print_string.print : string -> unit].
   In comments, compare functors with C++ templates and dependency injection,
   naming one difference from each.
   Build and run before continuing. *)

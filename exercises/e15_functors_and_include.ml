(** E15 — Functors and [include] (75-100 min)

    Build: [opam exec -- dune build exercises/e15_functors_and_include.exe] Run:
    [opam exec -- dune exec exercises/e15_functors_and_include.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e15_functors_and_include.ml] *)

(* Task 1 — Define [ToString] and [Print].
   Define module type [ToString] with abstract type [t] and
   [to_string : t -> string]. Define functor [Print (M : ToString)]. Its result
   must expose exactly one value, [print : M.t -> unit]. [print x] prints
   [M.to_string x] followed by a newline.

   Add a local argument module whose conversion increments a counter. Call its
   generated printer once and assert that the conversion ran exactly once.
   Before coding, write down the result signature you expect from [Print].
   Build and run before continuing. *)

(* Task 2 — Instantiate the functor without losing type sharing.
   Define [Int] with [type t = int] and [to_string = string_of_int]. Define
   [MyString] with [type t = string] and identity conversion. Leave those
   modules unsealed, or ascribe them with [ToString with type t = int] and
   [ToString with type t = string]. An opaque [Int : ToString] would hide the
   fact that [Int.t = int] and make [PrintInt.print 3110] ill-typed.

   Define [PrintInt = Print (Int)] and [PrintString = Print (MyString)]. Test
   the conversions directly, then call both printers. Add annotations proving
   [PrintInt.print : int -> unit] and [PrintString.print : string -> unit].
   Build and run before continuing. *)

(* Task 3 — Explain the reuse.
   In a comment, explain which code is written once, which modules supply the
   changing behavior, and why applying [Print] twice is code reuse rather than
   copied implementations. Mention the role of [M.t] in the generated type.
   Build and run before continuing. *)

(* Task 4 — Reuse with [include].
   Define [StringWithPrint] without copying any implementation. It must expose
   all values from [String] and the [print] operation generated from [MyString].
   Use two [include] statements.

   Assert [StringWithPrint.uppercase_ascii "reuse" = "REUSE"], then print that
   result with [StringWithPrint.print]. Inspect the inferred interface and
   confirm both operations are present.
   Build and run before continuing. *)

(* Extension — Generalize the pattern.
   Define module type [Debuggable] with [to_debug_string], then a [Debug]
   functor exposing only [dump]. Instantiate it for integers. Unlike Task 1,
   first write its complete input and output signatures without using the
   [Print] implementation as a template.

   In comments, compare an OCaml functor with a C++ template and with dependency
   injection, naming one concrete difference from each. *)

(* Final task — Completion marker.
   Only after every required assertion and written explanation above is present
   and passing, make the completed program print exactly [E15 passed] once. *)

(** E16 — Interface boundaries (80-110 min)

    Build: [opam exec -- dune build exercises/e16_interface_boundaries.exe] Run:
    [opam exec -- dune exec exercises/e16_interface_boundaries.exe] Inspect:
    [opam exec -- ocamlc -i exercises/e16_interface_boundaries.ml] *)

(* Task 1 — Implement without an interface.
   Define [Leaky_date] with record type [t = { month : int; day : int }],
   [make month day], [month date], and [day date]. [make] stores its arguments
   without validation.

   Test construction of month 13 and direct access to its record fields. Inspect
   the inferred interface and list every exposed representation detail.
   Example form: [module Open_box = struct type t = { contents : string } let pack contents = { contents } end]
   Build and run before continuing. *)

(* Task 2 — Define an abstract date interface.
   Define module type [DATE] with abstract type [t] and operations:
   [make : month:int -> day:int -> t option], [month : t -> int],
   [day : t -> int], [to_string : t -> string], and
   [pp : Format.formatter -> t -> unit].

   Define no sealed implementation yet. Inspect and verify that the interface
   exposes no record fields.
   Example form: [module type BOX = sig type t val pack : string -> t val contents : t -> string end]
   Build and run before continuing. *)

(* Task 3 — Enforce valid date construction.
   Begin unsealed [Date_impl] with a record representation. Define [make] to
   accept months 1 through 12 and days valid for that month, using 28 days for
   February. Return [None] otherwise. Define [month] and [day].

   Test January 1, February 28, February 29, April 31, and month 13.
   Example form: [let create_box size = if size > 0 then Some { size } else None]
   Build and run before continuing. *)

(* Task 4 — Add date printers and seal the module.
   Define [to_string date] as ["month/day"]. Define [pp formatter date] with
   [Format.fprintf]. Seal the implementation as [module Date : DATE = Date_impl].

   Define [render_pair a b] with [Format.asprintf] and two [%a] placeholders,
   producing ["a -> b"]. Test January 1, December 31, and their rendered pair.
   Example form: [let pp fmt box = Format.fprintf fmt "box(%s)" (contents box)]
   Build and run before continuing. *)

(* Task 5 — Change the hidden representation.
   Replace [Date_impl.t] with an ordinal day from 1 through 365. The ordinal for
   [(month, day)] is [day] plus the sum of every preceding month's length.
   Recover month by subtracting month lengths until the remainder fits, and use
   that remainder as day. Update all five operations while leaving [DATE],
   [Date], [render_pair], and client tests unchanged. Test February 28 and
   December 31 again.
   Example form: [let encode row column = (row * width) + column]
   Build and run before continuing. *)

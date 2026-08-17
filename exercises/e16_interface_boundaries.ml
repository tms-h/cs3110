(** E16 — Interface boundaries in one file (25-40 min)

    OUTCOME

    - Observe exactly how a signature changes client capabilities.
    - Add useful formatting without exposing representation.

    NOTE

    - Nested modules keep this a one-file lab.
    - Sealing [Date] uses the same boundary that an [.mli] applies to an [.ml].

    STEP 1 — INSPECT BEFORE IMPLEMENTING

    - Run [opam exec -- ocamlc -i exercises/e16_interface_boundaries.ml].
    - Compare [Leaky_date] with the [DATE] signature.
    - List every operation or representation detail the sealed client loses.

    STEP 2 — ENFORCE VALID CONSTRUCTION

    - Implement [Date.make] first and reject invalid inputs.
    - Implement the accessors and [to_string].
    - Confirm clients cannot construct a record or read its fields directly.

    STEP 3 — COMPOSE A PRINTER

    - Implement [Date.pp] with [Format.fprintf].
    - Implement [render_pair] with two [%a] placeholders.
    - Do not eagerly concatenate two date strings.

    STEP 4 — PREDICT A MANIFEST TYPE

    - Predict how [ocamlc -i] changes if [DATE] exposes the record definition.
    - Make the change, inspect the interface, and revert it.

    STEP 5 — TRANSFER AND FINISH

    - Change the hidden representation to an ordinal day.
    - Keep [DATE] and all client code unchanged.
    - Run [opam exec -- dune exec exercises/e16_interface_boundaries.exe].

    Source coverage: implementation without interface; implementation with interface;
    implementation with abstracted interface; printer for date. *)

module Leaky_date = struct
  type t = { month : int; day : int }

  let make month day = { month; day }
  let month d = d.month
  let day d = d.day
end

module type DATE = sig
  type t

  val make : month:int -> day:int -> t option
  val month : t -> int
  val day : t -> int
  val to_string : t -> string
  val pp : Format.formatter -> t -> unit
end

module Date : DATE = struct
  type t = { month : int; day : int }

  let make ~month:_ ~day:_ : t option = failwith "TODO"
  let month (_d : t) : int = failwith "TODO"
  let day (_d : t) : int = failwith "TODO"
  let to_string (_d : t) : string = failwith "TODO"
  let pp (_formatter : Format.formatter) (_d : t) : unit = failwith "TODO"
end

let render_pair (_a : Date.t) (_b : Date.t) : string =
  failwith "TODO: Format.asprintf with two %a printers"

let () =
  let jan1 = Option.get (Date.make ~month:1 ~day:1) in
  let dec31 = Option.get (Date.make ~month:12 ~day:31) in
  assert (Date.make ~month:13 ~day:1 = None);
  assert (Date.month jan1 = 1 && Date.day dec31 = 31);
  assert (render_pair jan1 dec31 = "1/1 -> 12/31");
  print_endline "E16 complete"

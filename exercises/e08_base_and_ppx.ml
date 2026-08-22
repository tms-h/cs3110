open! Base

(* E08 — Base and PPX

   This is the deliberate transition from the Stdlib to Jane Street's public
   conventions. From this file onward, use Base/Core APIs unless a task says
   otherwise. *)

(* Task 1 — Translate APIs, not algorithms.
   Reuse the idea of E07's [filter_map] through [List.filter_map ~f] rather than
   reimplementing it. In comments, record the types of [List.map],
   [List.fold], [Option.value], [Result.map], [( = )], and [Poly.equal] after
   [open Base]. Explain labelled [~f] arguments and type-specific comparison. *)

(* Task 2 — Model and validate data.
   Define [side = Bid | Ask] and a [quote] record containing a symbol, side,
   integer price in ticks, and integer size. Define [create_quote] returning
   [quote Or_error.t]; symbol must be nonempty and price/size strictly positive.
   Preserve useful error context and do not raise for validation failures. *)

(* Task 3 — Derive routine operations.
   Derive [sexp_of], [compare], and [equal] where appropriate. Print one quote
   with [Stdio.print_s]. Compare two quotes using the generated function and
   explain why unconstrained polymorphic comparison is not the default tool. *)

(* Task 4 — Separate wire data from valid domain data.
   Define a [wire_quote] with [@@deriving sexp]. Parse one s-expression into a
   wire value, then validate it through [create_quote]. Test malformed syntax
   separately from a syntactically valid but invalid quote. Do not derive a
   parser that bypasses the [quote] invariant. *)

(* Task 5 — Use one comparator witness.
   Define a [Symbol] module whose [t] is string and use [Comparable.Make] to
   obtain a comparator. Create a [Map.t] keyed by [Symbol.t], perform one
   replacement, and inspect deterministic bindings.

   After all checks pass, use [Stdio.print_endline] to print exactly
   [E08 passed] as the final output line. *)

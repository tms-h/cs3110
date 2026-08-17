(** E30 — Hash tables and coupled invariants (40-50 min)

    OUTCOME

    Inspect hash-table distribution, distinguish [add] from [replace], and keep a
    specialized table's equality and hash functions coherent.

    STEP 1 — DRAW THE BUCKETS BEFORE CODING

    - Draw seven chained buckets numbered 0 through 6.
    - Insert 4, 8, 15, 16, 23, and 42 using [k mod 7].
    - Write the representation invariant for this table.
    - Now analyze two alternative designs: buckets may contain duplicate keys; buckets
      are kept sorted. For each design, state what changes in the invariant, observable
      behavior, and operation costs.

    STEP 2 — PREDICT THE STDLIB TABLE'S BEHAVIOR

    - Read the required Hashtbl documentation:
      https://ocaml.org/manual/5.4/api/Hashtbl.html
    - Call [populate] to insert keys 1 through 32 into [table].
    - Before inspecting statistics, predict when the table will resize.
    - Check the prediction with [Hashtbl.stats] and a computed load factor.
    - Explain, with a duplicate-key example, how [Hashtbl.add] differs from
      [Hashtbl.replace].

    STEP 3 — IMPLEMENT THE OBSERVATION HELPERS

    - Implement [bindings] with [Hashtbl.fold].
    - Implement [load_factor] from [Hashtbl.stats].
    - Run the file and fix any type or API-usage errors before continuing.

    STEP 4 — EXPLORE HASH VALUES AND COLLISIONS

    - Hash several values of algebraic types.
    - Enumerate bounded binary trees and find two distinct trees with the same hash.
    - Explain why collision resistance does not mean collision freedom.

    STEP 5 — COUPLE EQUALITY WITH HASHING

    - Complete [Case_insensitive_key.equal] and [Case_insensitive_key.hash].
    - In [EQUAL/HASH PROOF], show that [equal a b] implies [hash a = hash b].
    - Deliberately violate that implication, run the lookup, and record the symptom.
    - Restore the coherent implementation before moving on.

    STEP 6 — DEGRADE DISTRIBUTION DELIBERATELY

    - Populate [Bad_table], whose hash is constant.
    - Inspect its statistics and identify the resulting bucket distribution.
    - Relate that distribution to worst-case operation costs. Make clear that the bad
      hash function, not hash tables in general, caused the degradation.

    FINISH

    Run: [opam exec -- dune exec exercises/e30_hash_tables_and_invariants.exe]

    Source coverage: hash insert; relax bucket RI; strengthen bucket RI; hash values;
    hashtbl usage; hashtbl stats; hashtbl bindings; hashtbl load factor; functorial
    interface; equals and hash; bad hash. *)

let table : (int, string) Hashtbl.t = Hashtbl.create 16

let populate () =
  for key = 1 to 32 do
    Hashtbl.replace table key (string_of_int key)
  done

let bindings (_table : ('k, 'v) Hashtbl.t) : ('k * 'v) list = failwith "TODO"
let load_factor (_table : ('k, 'v) Hashtbl.t) : float = failwith "TODO: stats"

module Case_insensitive_key = struct
  type t = string

  let equal (_a : t) (_b : t) : bool = failwith "TODO"
  let hash (_s : t) : int = failwith "TODO: must follow equal"
end

module Ci_table = Hashtbl.Make (Case_insensitive_key)

module Constant_hash_key = struct
  type t = int

  let equal = Int.equal
  let hash _ = 0
end

module Bad_table = Hashtbl.Make (Constant_hash_key)

(* BUCKET DRAWING: ...
   RELAXED RI ANALYSIS: ...
   SORTED RI ANALYSIS: ...
   EQUAL/HASH PROOF: ... *)

let () =
  populate ();
  assert (Hashtbl.find table 31 = "31");
  assert (List.length (bindings table) = 32);
  assert (load_factor table > 0.);
  let ci = Ci_table.create 8 in
  Ci_table.replace ci "OCaml" 3110;
  assert (Ci_table.find ci "ocAML" = 3110);
  let bad = Bad_table.create 8 in
  for i = 1 to 20 do
    Bad_table.replace bad i i
  done;
  assert ((Bad_table.stats bad).Hashtbl.max_bucket_length = 20);
  print_endline "E30 complete"

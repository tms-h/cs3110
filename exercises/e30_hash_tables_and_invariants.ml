(** E30 — Hash-table invariants (85-115 min)

    Build: [opam exec -- dune build exercises/e30_hash_tables_and_invariants.exe] Run:
    [opam exec -- dune exec exercises/e30_hash_tables_and_invariants.exe] Reading:
    https://ocaml.org/manual/5.4/api/Hashtbl.html *)

(* Task 1 — Model chained buckets.
   Define [bucket_index key = key mod 7]. In comments, place keys
   4, 8, 15, 16, 23, and 42 into seven buckets and state the invariant that each
   binding is in its hash-selected bucket.

   Define [bucket_counts keys] to return a seven-element count list. Test the six
   keys produce counts [1; 2; 2; 0; 1; 0; 0]. Describe how allowing duplicate
   keys or sorting each bucket changes behavior and costs.
   Example form: [let index key = (Hashtbl.hash key land max_int) mod bucket_count]
   Build and run before continuing. *)

(* Task 2 — Compare [add] and [replace].
   Define [table : (int, string) Hashtbl.t] and [populate ()] to replace keys 1
   through 32 with their decimal strings. Test key 31 and table length 32.

   In a separate small table, use [add] twice on one key and test [find_all]
   returns both values. Then use [replace] and test only the replacement remains.
   Example form: [Hashtbl.add table "color" "blue"; Hashtbl.replace table "color" "green"]
   Build and run before continuing. *)

(* Task 3 — Observe bindings and load factor.
   Define [bindings table] with [Hashtbl.fold]; result order is unspecified.
   Define [load_factor table] as
   [float num_bindings /. float num_buckets] from [Hashtbl.stats], returning 0.0
   if the implementation reports zero buckets.

   Test sorted bindings of a three-entry table and test the populated table has
   positive load. Print full statistics without asserting resize thresholds.
   Example form: [let pairs table = Hashtbl.fold (fun key value acc -> (key, value) :: acc) table []]
   Build and run before continuing. *)

(* Task 4 — Find an actual hash collision.
   Define polymorphic tree [hash_tree = HLeaf | HNode of hash_tree * int * hash_tree].
   Define [find_tree_collision limit] to enumerate trees whose node values are
   between 0 and [limit] and return two structurally distinct trees with equal
   [Hashtbl.hash], or [None] if your bounded enumeration finds none.

   Increase the limit until a collision is found, then assert the trees differ
   structurally and have equal hashes. Do not assert a particular pair.
   Example form: [match Hashtbl.find_opt seen hash with Some earlier when earlier <> value -> Some (earlier, value) | _ -> None]
   Build and run before continuing. *)

(* Task 5 — Couple equality and hashing.
   Define [Case_insensitive_key] with [type t = string], equality after
   [String.lowercase_ascii], and hash of the same normalized string. Define
   [Ci_table = Hashtbl.Make (Case_insensitive_key)].

   Test inserting ["OCaml"] and finding or replacing it through ["ocAML"]. In a
   comment, prove equal keys receive equal hashes.
   Example form: [let canonical = String.lowercase_ascii in
   canonical left = canonical right, Hashtbl.hash (canonical left)]
   Build and run before continuing. *)

(* Task 6 — Degrade distribution deliberately.
   Define [Constant_hash_key] for integers with [Int.equal] and constant hash 0.
   Define [Bad_table = Hashtbl.Make (Constant_hash_key)]. Insert keys 1 through
   20 and test all values remain findable.

   Test [max_bucket_length = 20] from [Bad_table.stats] and explain why operations
   now have linear worst-case cost even though correctness is unchanged.
   Example form: [module One_bucket = struct type t = int let equal = Int.equal let hash _ = 0 end]
   Build and run before continuing. *)

(** E30 — Hash-table invariants (105-145 min)

    Build: [opam exec -- dune build exercises/e30_hash_tables_and_invariants.exe] Run:
    [opam exec -- dune exec exercises/e30_hash_tables_and_invariants.exe] Reading:
    https://ocaml.org/manual/5.3/api/Hashtbl.html *)

(* Task 1 — Model chained buckets.
   For this textbook model, keys are required to be nonnegative. Define
   [bucket_index key = key mod 7] under that precondition. In comments, place keys
   4, 8, 15, 16, 23, and 42 into seven buckets and state the invariant that each
   binding is in its hash-selected bucket.

   Define [bucket_counts keys] to return a seven-element count list. Test the six
   keys produce counts [1; 2; 2; 0; 1; 0; 0]. Analyze two alternative bucket
   invariants separately. If duplicate bindings are allowed, state the resulting
   semantics and the best- and worst-case costs of insert, find, and remove. If
   buckets must remain sorted by key, state how each operation and its cost
   changes, including the cost of maintaining the order.
   Example form: [let index key = (Hashtbl.hash key land max_int) mod bucket_count]
   Build and run before continuing. *)

(* Task 2 — Reproduce the textbook [Hashtbl] usage experiment.
   Define [tab : (int, string) Hashtbl.t] with initial size 16. Add keys 1 through
   31 with their decimal strings using [Hashtbl.add]. Test [Hashtbl.find tab 31],
   table length 31, and both a present and an absent lookup. If testing the absent
   lookup with [find], catch and assert [Not_found] rather than letting it escape.

   Extension: in a separate small table, use [add] twice on one key and test
   [find_all] returns both values. Then use [replace] and test only the replacement
   remains. Do not use this extension table for the resizing experiment.
   Example form: [Hashtbl.add table "color" "blue"; Hashtbl.replace table "color" "green"]
   Build and run before continuing. *)

(* Task 3 — Observe bindings, statistics, and the resize boundary.
   Define [bindings table] with [Hashtbl.fold]; result order is unspecified.
   Define [load_factor table] as
   [float num_bindings /. float num_buckets] from [Hashtbl.stats], returning 0.0
   if the implementation reports zero buckets.

   Test sorted bindings of a three-entry table. For [tab] from Task 2, record its
   bucket count, number of bindings, number of singleton buckets, and load factor;
   do not assert an implementation-specific bucket count. Add binding 32, record
   the same observations, then add binding 33 and record them again. Explain why
   a load of exactly 2 does not cross a strictly-greater-than-2 resize threshold,
   whereas the next insertion can. Assert all 33 bindings remain findable.
   Example form: [let pairs table = Hashtbl.fold (fun key value acc -> (key, value) :: acc) table []]
   Build and run before continuing. *)

(* Task 4 — Explore polymorphic hashes and find an actual collision.
   Print or record [Hashtbl.hash] for [()], [false], [true], [0], [1], [""], and
   [[]], then for at least two larger values of each applicable type. Compare
   several lists and note any collisions before moving to trees.

   Define polymorphic tree [hash_tree = HLeaf | HNode of hash_tree * int * hash_tree].
   As an extension, define [find_tree_collision ~max_nodes ~max_label] to
   enumerate every tree with at most [max_nodes] internal nodes and node values
   between 0 and [max_label]. Return two structurally distinct trees with equal
   [Hashtbl.hash], or [None] after that finite domain is exhausted. Reject negative
   bounds with [Invalid_argument "collision bounds"].

   Increase one explicit bound at a time until a collision is found, then assert
   the trees differ structurally and have equal hashes. Do not assert a particular
   pair. Record the successful bounds so the search is reproducible.
   Example form: [match Hashtbl.find_opt seen hash with Some earlier when earlier <> value -> Some (earlier, value) | _ -> None]
   Build and run before continuing. *)

(* Task 5 — Couple equality and hashing.
   Define [Case_insensitive_key] with [type t = string], equality after
   [String.lowercase_ascii], and hash of the same normalized string. Define
   [Ci_table = Hashtbl.Make (Case_insensitive_key)].

   Test inserting ["OCaml"] and finding or replacing it through ["ocAML"]. In a
   comment, prove equal keys receive equal hashes. Compare this equal/hash contract
   with Java's [Object.hashCode] contract, as the textbook asks, and explain why
   lookup correctness in both APIs requires equal keys to have equal hashes.
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
   After every required observation, explanation, and assertion in E30 is present
   and passing, print the exact line ["E30 passed"] once, and not earlier.
   Build and run before continuing. *)

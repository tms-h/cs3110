(** E28 — Structural proofs and the right lemma (40-50 min)

    OUTCOME

    - Prove transformations over recursive data using explicit lemma dependencies.
    - Discover a helper lemma when a larger proof gets stuck.

    STEP 1 — BUILD A REVERSE-PROOF CHAIN

    - Prove [xs @ [] = xs].
    - Use that result to prove reverse distributes over append.
    - Use distribution to prove reverse is involutive.
    - Keep each dependency explicit; do not reprove it inside the next theorem.

    STEP 2 — PROVE A TREE TRANSFORMATION

    - Prove [size (reflect t) = size t] by structural induction on [t].
    - State one induction hypothesis for each recursive subtree.

    STEP 3 — REPAIR THE FOLD THEOREM

    - Explain why commutativity cannot be assumed for string concatenation.
    - Formulate the weakest useful fold-left/fold-right theorem.
    - State associativity and both required identity assumptions precisely.

    STEP 4 — INDUCT OVER PROPOSITIONS

    - Read the complete proposition AST.
    - Write its structural induction principle in the marked block.
    - Implement [atoms] without duplicates.

    STEP 5 — TRANSFER AND FINISH

    - Implement [simplify].
    - Prove that simplification introduces no new atom.
    - Run [opam exec -- dune exec exercises/e28_structural_proofs.exe].

    Source coverage: append nil; rev dist append; rev involutive; reflect size; fold
    theorem 2; propositions. *)

let rec rev = function [] -> [] | head :: tail -> rev tail @ [ head ]

type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

let rec size = function Leaf -> 0 | Node (l, _, r) -> 1 + size l + size r

let rec reflect = function
  | Leaf -> Leaf
  | Node (l, value, r) -> Node (reflect r, value, reflect l)

type proposition =
  | Atom of string
  | Not of proposition
  | And of proposition * proposition
  | Or of proposition * proposition
  | Implies of proposition * proposition

let atoms (_p : proposition) : string list = failwith "TODO: unique"
let simplify (_p : proposition) : proposition = failwith "TODO: transfer"

(* LEMMA 1 — append right identity:

   LEMMA 2 — reverse distributes over append:

   THEOREM 3 — reverse involution:

   THEOREM 4 — reflect preserves size:

   FOLD THEOREM:

   PROPOSITION INDUCTION PRINCIPLE:
*)

let () =
  let t = Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf)) in
  assert (size (reflect t) = size t);
  assert (rev (rev [ 1; 2; 3; 4 ]) = [ 1; 2; 3; 4 ]);
  assert (
    List.fold_left ( ^ ) "" [ "a"; "b"; "c" ]
    = List.fold_right ( ^ ) [ "a"; "b"; "c" ] "");
  let p = Implies (And (Atom "p", Atom "q"), Or (Atom "q", Not (Atom "r"))) in
  assert (atoms p = [ "p"; "q"; "r" ]);
  assert (List.for_all (fun atom -> List.mem atom (atoms p)) (atoms (simplify p)));
  print_endline "E28 complete"

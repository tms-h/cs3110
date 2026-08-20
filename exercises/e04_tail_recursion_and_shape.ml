(** E04 — Tail recursion and list shape (75-105 min)

    Build: [opam exec -- dune build exercises/e04_tail_recursion_and_shape.exe] Run:
    [opam exec -- dune exec exercises/e04_tail_recursion_and_shape.exe] *)

(* Task 1 — Define [take] and [drop].
   Define recursive [take n xs] to return the first [n] elements, or all of [xs]
   when it is shorter. Define recursive [drop n xs] to remove the first [n]
   elements, or return [] when [xs] is shorter. Both functions must raise
   [Invalid_argument] when [n < 0].

   Example form: [let rec repeat n x = if n = 0 then [] else x :: repeat (n - 1) x]
   Test negative, zero, shorter, exact-length, and longer counts.
   Build and run before continuing. *)


(* cleaner implementation gpt gave me lol *)
let rec take n xs =
  if n < 0 then invalid_arg "neg n"
  else
    match n, xs with
    | 0, _ | _, [] -> []
    | n, x :: rest -> x :: take (n - 1) rest

let rec drop n xs =
  if n < 0 then invalid_arg "neg n"
  else
    match n, xs with
    | 0, rest -> rest
    | _, [] -> []
    | n, _ :: rest -> drop (n-1) rest

(* im not gonna bother trying -n *)
let () =
  assert (take 1 [] = []);
  assert (take 5 [1; 2; 3] = [1; 2; 3]);
  assert (take 2 [1; 2; 3] = [1; 2]);
  assert (drop 5 [] = []);
  assert (drop 5 [1; 2; 3; 4; 5; 6; 7] = [6; 7]);
  assert (drop 10 [1; 2; 3; 4; 5; 6; 7] = [])

(* Task 2 — Make [take] tail-recursive and inspect [drop].
   Define [take_tr n xs] with the same contract as [take]. Use a reversed-prefix
   accumulator, and state its invariant in a comment.

   Then inspect [drop]: its recursive call should already be in tail position.
   Define [drop_tr n xs] with the same contract as [drop], without adding a
   pointless accumulator, and explain in a comment why it is tail-recursive.

   Test equality with [take] and [drop] on representative inputs, then test both
   tail-recursive functions on a list of one million integers.
   Example form: [let rec loop reversed = function [] -> List.rev reversed | x :: xs -> loop (x :: reversed) xs]
   Build and run before continuing. *)

let take_tr n xs = 
  if (n < 0) then invalid_arg "neg n"
  else
    let rec loop remaining acc left = 
      match remaining, left with
      | _, [] | 0, _ -> acc
      | _, x :: rest -> loop (remaining - 1) (x :: acc) rest
    in 
    List.rev (loop n [] xs)

(* we dont need any acc so we dont need this 
   tail recursive because recursive call to drop is final performed lul*)
let drop_tr n xs =
  drop n xs

let () =
  assert (take_tr 1 [] = []);
  assert (take_tr 5 [1; 2; 3] = [1; 2; 3]);
  assert (take_tr 2 [1; 2; 3] = [1; 2]);
  assert (drop_tr 5 [] = []);
  assert (drop_tr 5 [1; 2; 3; 4; 5; 6; 7] = [6; 7]);
  assert (drop_tr 10 [1; 2; 3; 4; 5; 6; 7] = [])

(* Task 3 — Recognize unimodal lists.
   Define [is_unimodal xs] to return true exactly when the list is first
   nondecreasing and then nonincreasing. Either phase may be empty, and equal
   adjacent values are allowed. Use one traversal and constant auxiliary space.

   Test [], a rising list, a falling list, [1; 3; 3; 2], and [1; 3; 2; 4].
   Before coding, trace the last two examples and mark the point, if any, where
   the traversal changes from rising to falling.
   Example form: [type phase = Rising | Falling]
   Build and run before continuing. *)

type phase = Rising | Falling

(* this code is beautiful and ugly at the same time lol *)
let is_unimodal xs =
  let rec loop phase last rest =
    match rest with
    | [] -> true
    | curr :: tail ->
      match phase with
      | Rising -> 
        if (curr >= last) then loop Rising curr tail
        else loop Falling curr tail
      | Falling -> 
        if (curr <= last) then loop Falling curr tail
        else false
  in
  match xs with 
  | [] -> true
  | first :: rest -> loop Rising first rest

let () = 
  assert (is_unimodal [0; 1; 2; 3; 4; 5; 4; 3; 2]);
  assert (is_unimodal [0; 1; 2; 3; 4; 5]);
  assert (is_unimodal []);
  assert (is_unimodal [5; 4; 3; 2; 1]);
  assert (not (is_unimodal [5; 4; 3; 2; 1; 2]))

(* Task 4 — Generate a powerset.
   Assume [xs] has no duplicate elements. Define [powerset xs] to return every
   sublist obtained by choosing or omitting each input element. In the recursive
   case, compute [powerset tail] once, bind that result, and reuse it for the
   subsets that include the head. The result for [] is [[]].

   Test [] and [1; 2]. For [1; 2; 3], test that the result has length 8 and
   contains [] and [1; 2; 3]; do not require a particular subset order.
   Example form: [let with_head x tails = List.map (fun tail -> x :: tail) tails]
   Build and run before continuing. *)

let rec powerset xs =
  match xs with
  | [] -> [[]]
  | x :: tail -> 
    let tails = powerset tail in
    let with_x = (List.map (fun subset -> x :: subset) tails) in
    with_x @ tails

let () = 
  assert (powerset [] = [[]]);
  assert (powerset [1; 2] |> List.length = 4);
  assert (powerset [1; 2; 3] |> List.length = 8)

(* Task 5 — Print with two traversal styles.
   Define [print_int_list xs] recursively and [print_int_list_iter xs] with
   [List.iter]. Each must print the integers in order, one per line, and print
   nothing for [].

   Factor [render_int x] to return the line text without a newline. Test
   [render_int 0] and [render_int (-3)], then call both printers on [1; 2].
   Example form: [let print_words words = List.iter print_endline words]
   Build and run before continuing. *)

let rec print_int_list = function
  | [] -> ()
  | x :: rest -> 
    print_endline (string_of_int x); 
    print_int_list rest

let print_int_list_iter xs = 
  List.iter (fun x -> print_endline (string_of_int x)) xs

let () =
  print_int_list [1; 2; 5; 4; 3];
  print_newline ();
  print_int_list_iter [1; 2; 5; 4; 3];
  print_newline ()

(* Task 6 — Extension: split into chunks.
   Define tail-recursive [chunks_of width xs]. Preserve element order, make each
   chunk length [width] except possibly the final chunk, return [] for [], and
   raise [Invalid_argument] when [width <= 0]. Do not call [take] or [drop].

   Test width 2 on [1; 2; 3; 4; 5], width larger than the list, [], and width 0.
   After every required assertion and written explanation in E04 is present,
   print exactly [E04 passed].
   Example form: [let rec finish current groups = List.rev (List.rev current :: groups)]
   Build and run before continuing. *)

let chunks_of width xs =
  if width <= 0 then invalid_arg "width <= 0 lul"
  else
    let rec loop acc rest =
      match rest with
      | [] -> acc
      | _ ->
        let rec loop2 remaining acc2 rest2 =
          match remaining, rest2 with
          | 0, _ -> (List.rev acc2, rest2)
          | _, [] -> (List.rev acc2, rest2)
          | _, x :: rest3 -> loop2 (remaining - 1) (x :: acc2) (rest3)
        in 
        let chunk, remaining = loop2 width [] rest in
        loop (chunk :: acc) remaining
      in List.rev (loop [] xs)

let better_chunks_of width xs = 
  if width <= 0 then invalid_arg "width <= 0"
  else
    let rec loop remaining current groups rest =
      match rest with 
      | [] -> 
        if current = [] then
          List.rev groups
        else
          List.rev (List.rev current :: groups)
      | x :: tail ->
        if remaining = 1 then
          loop width [] (List.rev (x :: current) :: groups) tail
        else
          loop (remaining - 1) (x :: current) groups tail
    in 
    loop width [] [] xs


let () =
  assert (chunks_of 2 [1; 2; 3; 4; 5; 6; 7] = [[1;2]; [3;4]; [5;6]; [7]]);
  assert (better_chunks_of 2 [1; 2; 3; 4; 5; 6; 7] = [[1;2]; [3;4]; [5;6]; [7]])

let () =
  print_endline "all test cases passed !! :)"

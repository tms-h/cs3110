(** E03 — Lists, patterns, and the List module (60-85 min)

    Build: [opam exec -- dune build exercises/e03_lists_and_library.exe] Run:
    [opam exec -- dune exec exercises/e03_lists_and_library.exe] Reading:
    https://ocaml.org/manual/5.4/api/List.html *)

(* Task 1 — Construct lists.
   Define [one_to_five_a] as [1; 2; 3; 4; 5] with bracket syntax. Define
   [one_to_five_b] using only [::] and [[]]. Define [one_to_five_c] using [@]
   and the sublist [2; 3; 4]. Test that all three values are equal.
   Example form: [let letters = 'a' :: ['b'] @ ['c']]
   Build and run before continuing. *)

let one_to_five_a = [1; 2; 3; 4; 5]

let one_to_five_b = 1 :: 2 :: 3 :: 4 :: 5 :: []

let one_to_five_c = [1] @ [2; 3; 4] @ [5]

let () =
  assert (one_to_five_a = one_to_five_b);
  assert (one_to_five_c = one_to_five_b)

(* Task 2 — Recurse over lists.
   Define recursive [product xs] with [product [] = 1] and
   [product (x :: xs) = x * product xs]. Define recursive [concat xs] with
   [concat [] = ""] and string concatenation in list order.

   Test [product []], [product [2; 3; 4]], [concat []], and
   [concat ["OC"; "aml"]].
   Example form: [let rec sum = function [] -> 0 | x :: xs -> x + sum xs]
   Build and run before continuing. *)

let rec product = function
  | [] -> 1
  | front :: rest -> front * product rest

let rec concat = function
  | [] -> ""
  | str :: rest -> str ^ concat rest

let () =
  assert (product [1;2;3;4;5;100] = 1 * 2 * 3 * 4 * 5 * 100);
  assert (concat ["hi"; " meow"; " i am a cat ^_^"] = "hi meow i am a cat ^_^");
  assert (product [] = 1);
  assert (product [2; 3; 4] = 24);
  assert (concat [] = "");
  assert (concat ["OC"; "aml"] = "OCaml")

(* Task 3 — Match list shapes.
   Define [starts_with_bigred xs] to return true exactly when the first two
   elements are ["big"] and ["red"]. Define [length_is_two_or_four xs] to
   return true exactly for lengths 2 and 4. Define [first_two_equal xs] to return
   true exactly when at least two elements exist and the first two are equal.

   Test each true case and the nearest shorter false case. Also test
   [first_two_equal [1; 1; 2]] and [first_two_equal [1; 2; 1]].
   Example form: [let has_two = function _ :: _ :: _ -> true | _ -> false]
   Build and run before continuing. *)

let starts_with_bigred = function
  | ("big" :: "red" :: _) -> true
  | _ -> false

let length_is_two_or_four = function
  | [_; _] | [_; _; _; _] -> true
  | _ -> false

let first_two_equal = function
  | left :: right :: _ when left = right -> true
  | _ -> false

let () = 
  assert (not (starts_with_bigred ["big"; "blue"; "bull"]));
  assert (starts_with_bigred ["big"; "red"; "dawg"]);
  assert (not (starts_with_bigred ["kitty meow"]));
  assert (length_is_two_or_four [1; 2]);
  assert (length_is_two_or_four ["yo"; "bob"]);
  assert (not (length_is_two_or_four [1; 2; 4]));
  assert (not (length_is_two_or_four []));
  assert (length_is_two_or_four [1; 2; 3; 4]);
  assert (first_two_equal ["hi"; "hi"]);
  assert (not (first_two_equal ["hi"; "bye"]));
  assert (first_two_equal [1; 1; 2]);
  assert (not (first_two_equal [1; 2; 1]));
  assert (not (length_is_two_or_four [1]));
  assert (not (first_two_equal [1]));
  assert (first_two_equal ["hi"; "hi"; "hello"])

(* Task 4 — Select the fifth element safely.
   Define [fifth_or_zero xs] with [List.nth_opt]. Return the fifth element when
   it exists and zero otherwise. Test lists of lengths 4 and 5.
   Example form: [match List.nth_opt colors 1 with Some c -> c | None -> "white"]
   Build and run before continuing. *)

let fifth_or_zero xs =
  match List.nth_opt xs 4 with
  | Some fifth -> fifth
  | None -> 0

let () =
  assert (fifth_or_zero [1;2;3;4;6;7] = 6);
  assert (fifth_or_zero [1;2;3;2;5;7] = 5);
  assert (fifth_or_zero [1;4;6;7] = 0)

(* Task 5 — Sort descending.
   Define [descending xs] with [List.sort]. Preserve duplicates and order values
   from greatest to least. Test [] and [2; 1; 3; 2].
   Example form: [let alphabetic words = List.sort String.compare words]
   Build and run before continuing. *)

let descending xs =
  List.sort (fun a b -> Int.compare b a) xs

let ascending xs = 
  List.sort Int.compare xs

let () = 
  assert (ascending [] = []);
  assert (ascending [2; 1; 3; 2] = [1; 2; 2; 3]);
  assert (descending [] = []);
  assert (descending [2; 1; 3; 2] = [3; 2; 2; 1])

(* Task 6 — Use an exception-raising library operation.
   Define [last_exn xs] without pattern matching. Return the final element and
   let the chosen List operation's documented exception escape for []. Test a
   singleton, a longer list, and the exact empty-list exception.
   Example form: [let first_exn words = List.hd words]
   Build and run before continuing. *)

let last_exn xs =
  List.hd (List.rev xs)

let () =
  assert (last_exn [1; 2; 3; 4; 5; -1] = -1);
  assert (last_exn [1] = 1);
  assert (last_exn ["first"; "second"; "some"; "last"] = "last");

  assert (
    try
      let _ = last_exn [] in 
      false
    with
    | Failure "hd" -> true
    | _ -> false
  )

(* Task 7 — Search with a predicate.
   Define [any_zero xs] with one List-library call and no explicit recursion.
   Return true exactly when an element equals zero. Test [], [1; 0; 2], and
   [1; 2; 3].
   Example form: [let any_long words = List.exists (fun word -> String.length word > 8) words]
   Build and run before continuing. *)

let any_zero xs =
  List.exists (fun c -> c = 0) xs

let () =
  assert (any_zero [1; 2; 3; 1; 5; 9; 1251521; 01; 0; 1; 5]);
  assert (not (any_zero []));
  assert (not (any_zero [1; 2; 3; 4; 5; 6]));
  assert (any_zero [0; 0; 0; 0; 5; 6])


let () = 
  print_endline ("all tests passed! :D")

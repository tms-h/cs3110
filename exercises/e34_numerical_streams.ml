(** E34 — Numerical streams and convergence (40-50 min)

    OUTCOME

    Build primes and numerical approximations as streams, then refactor an unstable
    Taylor-term generator into a recurrent one.

    STEP 1 — BUILD THE PRIME STREAM

    - Implement [filter] and [sift].
    - Use them to implement [primes] as a productive stream.
    - Check the first ten primes.
    - Explain why retaining references to old stream heads or thunks can cause a space
      leak even when computation is lazy.

    STEP 2 — IMPLEMENT THE NAIVE EXPONENTIAL APPROXIMATION

    - Implement [e_terms_naive] using numerator and factorial-style computation.
    - Implement [running_total].
    - Implement [within_absolute] with the precondition [epsilon > 0].
    - Check the approximation for a small value of [x].

    STEP 3 — LOOK FOR NUMERICAL DEGRADATION

    - Before testing, predict how the naive generator behaves for large [abs x].
    - Compare its approximations with [Float.exp] for small and large [abs x].
    - Record one input where numerator/factorial-style computation degrades and explain
      the intermediate values that cause it.

    STEP 4 — REFACTOR TERMS INTO A RECURRENCE

    - Derive the next Taylor term from the previous one using one multiplication and one
      division.
    - Implement that derivation in [e_terms_recurrent].
    - Repeat the comparison from Step 3.

    STEP 5 — MAKE THE STOPPING TEST ROBUST

    - Implement [close_mixed] using a mixed absolute/relative criterion.
    - Handle values near zero explicitly; do not divide blindly by [min a b].
    - Test equal values, near-zero values, and values of different signs.

    STEP 6 — REPORT NONCONVERGENCE

    - Implement [approximate_exp] with an iteration cap.
    - Return [Invalid_epsilon] for an invalid tolerance.
    - Return [Did_not_converge] with a useful diagnostic value when the cap is reached.

    FINISH

    Run: [opam exec -- dune exec exercises/e34_numerical_streams.exe]

    Source coverage: sift; primes; approximately e; better e. *)

type 'a sequence = Cons of 'a * (unit -> 'a sequence)

let head (Cons (x, _)) = x
let tail (Cons (_, next)) = next ()
let rec naturals_from n = Cons (n, fun () -> naturals_from (n + 1))
let rec filter (_p : 'a -> bool) (_s : 'a sequence) : 'a sequence = failwith "TODO"
let sift (_prime : int) (_s : int sequence) : int sequence = failwith "TODO"
let primes : int sequence = failwith "TODO"
let e_terms_naive (_x : float) : float sequence = failwith "TODO"
let e_terms_recurrent (_x : float) : float sequence = failwith "TODO"
let running_total (_s : float sequence) : float sequence = failwith "TODO"
let within_absolute (_epsilon : float) (_s : float sequence) : float = failwith "TODO"
let close_mixed ~epsilon:_ (_a : float) (_b : float) : bool = failwith "TODO"

type convergence_error = Invalid_epsilon | Did_not_converge of float

let approximate_exp ~max_iterations:_ ~epsilon:_ (_x : float) :
    (float, convergence_error) result =
  failwith "TODO: recurrent terms, mixed tolerance"

let rec take n (Cons (x, next)) = if n <= 0 then [] else x :: take (n - 1) (next ())

let () =
  assert (take 10 primes = [ 2; 3; 5; 7; 11; 13; 17; 19; 23; 29 ]);
  let approximation = within_absolute 1e-8 (running_total (e_terms_recurrent 1.)) in
  assert (Float.abs (approximation -. Float.exp 1.) < 1e-7);
  match approximate_exp ~max_iterations:1000 ~epsilon:1e-10 2. with
  | Ok value ->
      assert (Float.abs (value -. Float.exp 2.) < 1e-8);
      print_endline "E34 complete"
  | Error _ -> assert false

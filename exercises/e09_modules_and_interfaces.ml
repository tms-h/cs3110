open! Base

(* E09 — Modules and interfaces

   This file and its real [.mli] replace the old repeated signature,
   encapsulation, staged-interface, and algebra-refactor labs. *)

type t = { cents : int }

let create cents = { cents }
let cents t = t.cents

(* Task 1 — Observe the concrete boundary.
   Read [e09_modules_and_interfaces.mli]. In utop, construct [{ cents = -1 }]
   directly and predict which names are visible. Record what the interface
   exposes independently of what this implementation defines. *)

(* Task 2 — Make the representation abstract.
   Change the interface to expose only [type t], [create], and [cents]. Rebuild
   and confirm that direct record construction fails in a client while this
   implementation still compiles. Keep the actual compiler error in a comment. *)

(* Task 3 — Put the invariant at construction.
   Strengthen [create] to return [t Or_error.t] and reject negative cents.
   Update the interface and every client. Explain why an abstract type alone
   does not guarantee a valid value when its constructor accepts bad input. *)

(* Task 4 — Extend without reopening representation.
   Add [zero : t], [add : t -> t -> t], and [compare : t -> t -> int] to both
   files. Test only through the public interface. State whether integer
   overflow belongs in this exercise's contract. *)

(* Task 5 — Check interface pressure.
   Write a small client that creates two values, adds them, and prints cents.
   Attempt one representation-dependent operation and retain its compiler
   rejection as evidence. Keep the final interface no wider than the client
   needs.

   After all checks pass, print exactly [E09 passed] as the final output line. *)

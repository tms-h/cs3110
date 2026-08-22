open! Base

type t = { cents : int }

val create : int -> t
val cents : t -> int

open Ast

type failure_phase =
  | Lexing
  | Parsing

let parse source =
  Parser.prog Lexer.read (Lexing.from_string source)

let classify source =
  try Ok (parse source) with
  | Lex_error _ -> Error Lexing
  | Parser.Error -> Error Parsing

let parse source =
  Parser.prog Lexer.read (Lexing.from_string source)

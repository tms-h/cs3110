%{
open Ast
%}

%token <int> INT
%token <string> ID
%token TRUE FALSE LEQ TIMES PLUS LPAREN RPAREN
%token LET EQUALS IN IF THEN ELSE EOF

%nonassoc IN
%nonassoc ELSE
%left LEQ
%left PLUS
%left TIMES

%start <Ast.expr> prog

%%

prog:
  | expression = expr; EOF { expression }
  ;

expr:
  | value = INT { Int value }
  | name = ID { Var name }
  | TRUE { Bool true }
  | FALSE { Bool false }
  | left = expr; LEQ; right = expr { Binop (Leq, left, right) }
  | left = expr; TIMES; right = expr { Binop (Mult, left, right) }
  | left = expr; PLUS; right = expr { Binop (Add, left, right) }
  | LET; name = ID; EQUALS; bound = expr; IN; body = expr
      { Let (name, bound, body) }
  | IF; condition = expr; THEN; yes_branch = expr; ELSE; no_branch = expr
      { If (condition, yes_branch, no_branch) }
  | LPAREN; expression = expr; RPAREN { expression }
  ;

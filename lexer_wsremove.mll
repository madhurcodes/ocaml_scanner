(* stolen from http://courses.softlab.ntua.gr/compilers/2015a/ocamllex-tutorial.pdf *)

(* scanner for a toy language *)

{
open Printf
}
let digit = ['0'-'9']
let id = ['a'-'z'] ['a'-'z' 'A'-'Z' '0'-'9']*
rule toy_lang = parse
| "abs"
{ printf "Absolute Operator\n" ;
toy_lang lexbuf
}
| "in"
| "def" as word
{ printf "Definition Operator: %s\n" word;
toy_lang lexbuf
}
| "if"
| "then"
| "else" as kk
{ printf "Conditional Operator %s\n" kk ;
toy_lang lexbuf
}
| "("
| ")" as p
{ printf "Parenthesis %c\n" p;
toy_lang lexbuf
}
| "not"
{ printf "Not Operator \n" ;
toy_lang lexbuf
}
| "T"
| "F" as a
{ printf "Boolean: %c \n" a;
toy_lang lexbuf
}
| ("-")?['1'-'9']digit* as digs
{ printf "Number: %s \n" digs ;
toy_lang lexbuf
}
| "+"
| "-"
| "*"
|  "div"
|  "mod"
| "^" as op
{ printf "Arithmetic Operator: %s\n" op;
toy_lang lexbuf
}
|  "/\\"
{ printf "Binary Boolean Operator: and\n";
toy_lang lexbuf
}
|  "\\/"
{ printf "Binary Boolean Operator: or\n";
  toy_lang lexbuf
}
| "="
| ">"
| "<"
|  ">="
|  "<=" as op
{ printf "Comparision Operator: %s\n" op;
toy_lang lexbuf
}

| id as text
{ printf "Identifier: %s\n" text;
toy_lang lexbuf
}

| ";"
{ printf "Delimiter \n";
toy_lang lexbuf
}
| " "
| "\n" {toy_lang lexbuf}
| [^'~'] as c
{ printf "Unrecognized token: %c\n" c;
toy_lang lexbuf
}
| eof  { }
{
let main () =
	let cin =
		if Array.length Sys.argv > 1
			then open_in Sys.argv.(1)
else stdin
in
let lexbuf = Lexing.from_channel cin in
toy_lang lexbuf
let _ = Printexc.print main ()
}

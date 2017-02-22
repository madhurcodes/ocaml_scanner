(* stolen from http://courses.softlab.ntua.gr/compilers/2015a/ocamllex-tutorial.pdf *)

(*
#Ocaml Scanner
This is a scanner written in ocamllex by Madhur Singhal (2015CS10235) for an assignemnt for course COL226.
###Usage
Use "make" to build and run the program. It takes input from test.txt by default. If you want you can also run ./program after building either followed by a filename for input or give input on stdin.
###Design Decisions made
1. The subtraction operator will have a space after it since otherwise "4-4" will be interpreted as "4" and "-4". But "5+7" works properly since there is no ambiguity.
2. The div and mod operators will have spaces after them, otherwise "44div55" will give div55 as the second token (an Identifier), as otherwise there is an ambiguity since div55 is definitely a valid Identifier.
3. Greedy Matching is used always so the longest possible token will be printed at each step. For example "hg43434fef3434" is just one big Identifier.
*)

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

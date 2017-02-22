#Ocaml Scanner
This is a scanner written in ocamllex by Madhur Singhal (2015CS10235) for an assignemnt for course COL226.
###Usage
Use "make" to build and run the program. It takes input from test.txt by default. If you want you can also run ./program after building either followed by a filename for input or give input on stdin.
###Design Decisions made
1. The subtraction operator will have a space after it since otherwise "4-4" will be interpreted as "4" and "-4". But "5+7" works properly since there is no ambiguity.
2. The div and mod operators will have spaces after them, otherwise "44div55" will give div55 as the second token (an Identifier), as otherwise there is an ambiguity since div55 is definitely a valid Identifier.
3. Greedy Matching is used always so the longest possible token will be printed at each step. For example "hg43434fef3434" is just one big Identifier.

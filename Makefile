all:
	ocamllex lexer_wsremove.mll
	ocamlc -c lexer_wsremove.ml
	ocamlc -o program lexer_wsremove.cmo
	./program test.txt
clean:
	rm lexer_wsremove.ml lexer_wsremove.cmo program lexer_wsremove.cmi

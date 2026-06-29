TYPST   = typst

thesis.pdf: $(wildcard *.typ)
	$(TYPST) compile thesis.typ

watch:
	$(TYPST) watch thesis.typ

clean:
	rm -f thesis.pdf

.PHONY: watch clean

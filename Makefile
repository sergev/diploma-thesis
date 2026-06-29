TYPST   = typst

book.pdf: $(wildcard *.typ)
	$(TYPST) compile book.typ

watch:
	$(TYPST) watch book.typ

clean:
	rm -f book.pdf

.PHONY: watch clean

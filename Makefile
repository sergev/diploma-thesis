SHELL   = /bin/sh
ODD     = 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59
EVEN    = 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60
PAGES   = $(EVEN)

SRC     = common.me th.me apply.me aout.man pict.me arh.man ld.man\
		ar.man nm.man lorder.man size.man strip.man show.man\
		as.man emu.man syntax.me boot.me intro.me as.me emu.me\
		concl.me refer.me

# Typst build (modern rewrite — see book.typ and doc/TODO.md)
book.pdf: book.typ $(wildcard *.typ)
	typst compile book.typ

book-watch:
	typst watch book.typ

th.lp:  $(SRC)

th.hp:  $(SRC)

t1.hp:  $(SRC)
	hroff -o$(ODD) -Thpth -me hp.me th.me | hpflt >$@

t2.hp:  $(SRC)
	hroff -o$(EVEN) -Thpth -me hp.me th.me | hpflt >$@

apply.lp apply.hp: apply.me aout.man pict.me arh.man ld.man ar.man nm.man\
		lorder.man size.man strip.man show.man as.man emu.man\
		syntax.me

.tbl.me:
	tbl $< >$@

.me.lp:
	hroff -me lp.nr $< >$@

.me.hp:
	hroff -Thptr12 -me hp.me $< | hpflt >$@

.nr.lp:
	hroff lp.nr $< >$@

.nr.hp:
	hroff -Thpth hp.nr $< | hpflt >$@

.me.hpr:
	hroff -Thpth -me hp.me $< >$@

.man.hp:
	hroff -Thpth -me hp.me $< | hpflt >$@

.man.lp:
	hroff -me hp.me $< >$@

dict:   SPELL
	spellin DICT <SPELL >DICT.b
	mv DICT.b DICT

newdict: newspell
	spellin <SPELL >DICT

clean:
	-rm -f *.lp *.hp *.hpr *.b pict.me book.pdf

spell SPELL:  *.me *.man *.tbl *.nr
	spell -d DICT *.me *.man *.tbl *.nr >SPELL

spellvak:  vak.txt
	spell -d DICT vak.txt >SPELL

newspell:
	spell *.me *.man *.tbl *.nr >SPELL

save:
	cp *.me *.man *.tbl *.nr sav

.SUFFIXES: .sc .tbl .me .lp .man .hp .hpr .nr

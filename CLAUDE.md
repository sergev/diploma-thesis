# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is the source for a 1989 MFTI diploma thesis by S. V. Vakulenko (in Russian):
"Разработка переносимой Си-ориентированной инструментальной системы программирования
для ЭВМ Эльбрус-Б" — the design of a portable, C-oriented cross toolchain (C compiler
based on Johnson's portable C compiler, assembler, loader, librarian, emulator, and
object-file utilities) for the Elbrus-B / BESM-6 machine.

It is **document source**, not program source. The repository contains troff/nroff
markup using the `-me` macro package plus custom macros; there is no compiled artifact
beyond the typeset thesis. The toolchain it *describes* (as, ld, ar, nm, emu, etc.)
lives elsewhere — here those names appear only as man-page documentation.

## Build / typeset

The original build (see `Makefile`) targets `hroff` — a Cyrillic-capable troff variant —
and `hpflt`, an HP LaserJet output filter. Neither is installed on modern systems; only
standard `troff`/`nroff`/`groff`/`tbl` are present. To typeset today, substitute `groff`
for the `hroff` invocations.

- Master document: `th.me` pulls in every chapter via `.so` includes. Format the whole
  thesis by processing `th.me` with the `-me` macros, e.g.:
  `groff -me -t th.me` (`-t` runs tbl, needed for table sources).
- Tables: `.tbl` files are preprocessed by `tbl` into `.me` (Makefile rule `.tbl.me`,
  e.g. `pict.tbl` → `pict.me`). Run `tbl` (or `groff -t`) before/with the main pass.
- Page geometry is selected by the included config file, not by content:
  - `lp.nr` — line printer (66-line page, 64n line length)
  - `hp.nr` / `hp.me` — HP printer geometry (used with the original `hpth`/`hptr12` devices)
- `clean` removes generated output (`*.lp *.hp *.hpr *.b pict.me`).
- Spelling used a custom Russian dictionary (`DICT`, built via `spellin` from `SPELL`);
  `spell`/`spellin` are SysV-era tools and are not present on modern macOS.

## Document structure

Two distinct assemblies exist — do not confuse them:

- **Thesis body** is defined by the `.so` include list at the top of `th.me`:
  `common.me` (macros/page setup) → `results.me`, `intro.me`, `boot.me`, `load.me`,
  `as.me`, `emu.me`, `ccom.me`, `concl.me`, `refer.me`, `apply.me`. This list is the
  source of truth for chapter order; the `SRC` variable in the `Makefile` is an older,
  out-of-sync listing.
- **Appendices** (`apply.me`) are the man pages and reference sections: `aout.man`,
  `arh.man`, `ld.man`, `ar.man`, `nm.man`, `lorder.man`, `size.man`, `strip.man`,
  `show.man`, `as.man`, `emu.man`, plus `syntax.me` (formal grammar) and `pict`
  (object-file structure tables, from `pict.tbl`).

File-type conventions:
- `*.me` — `-me`-macro chapters and front matter.
- `*.man` — man-page-style appendices for individual tools.
- `*.tbl` — `tbl` table source (must be preprocessed to `.me`).
- `*.nr` — bare troff register/config snippets (page geometry, title page, hyphenation
  exceptions in `hypnen.nr`).
- `title.nr` / `th.me` carry the title page; `vak.me` is the advisor's review (отзыв),
  formatted standalone and not part of the `th.me` include chain.

## Conventions

- All prose is in Russian (KOI/Cyrillic-era text). Preserve the existing encoding when
  editing; do not transliterate or "fix" terminology.
- `common.me` defines custom macros used throughout: `.CT`/`.cT` (table-of-contents
  lines), `.AP` (appendix heading), and `.-` / `.=` (dash/equals indented list items).
  Reuse these rather than inlining equivalent troff.
- Chapter/section numbering uses the `-me` `.sh` (numbered) and `.uh` (unnumbered)
  heading macros; keep the depth consistent with `content.me`, which is the planned
  outline / table of contents.
- When adding a chapter, add both the file and its `.so` line in `th.me`; when adding an
  appendix tool page, add it to `apply.me`.

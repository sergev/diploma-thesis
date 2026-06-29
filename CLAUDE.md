# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is a 1989 MFTI diploma thesis by S. V. Vakulenko (in Russian):
"Разработка переносимой Си-ориентированной инструментальной системы программирования
для ЭВМ Эльбрус-Б" — the design of a portable, C-oriented cross toolchain (C compiler
based on Johnson's portable C compiler, assembler, loader, librarian, emulator, and
object-file utilities) for the Elbrus-B / BESM-6 machine.

It is **document source**, not program source. The thesis was originally written in
troff/nroff (the `-me` macro package) and has since been **converted to Typst**; the
original troff sources have been removed. The toolchain it *describes* (as, ld, ar, nm,
emu, …) lives elsewhere — here those names appear only as man-page-style appendices.

## Build

Typeset with [Typst](https://typst.app):

- `make` (or `make book.pdf`) → `typst compile book.typ` → `book.pdf`.
- `make watch` → `typst watch book.typ` for live preview.
- `make clean` removes `book.pdf` (which is git-ignored).

Requirements: the `typst` CLI. The document uses the `@preview/bookly` template
(auto-downloaded on first compile) and the fonts **New Computer Modern** (body; covers
Cyrillic) and **DejaVu Sans Mono** (code listings; covers the Russian comments inside
them).

## Document structure

`book.typ` is the master file: it configures bookly (Russian `lang`, A4, the title page),
emits the «Содержание» table of contents, and `#include`s the content in order.

- **Title page** — `title-page.typ` (the Soviet title page, from the original `title.nr`).
- **Chapters** (original `th.me` order): `results.typ`, `intro.typ`, `boot.typ`,
  `load.typ`, `as.typ`, `emu.typ`, `ccom.typ`, `concl.typ`, `refer.typ`.
- **Appendices** — `apply.typ` opens the unnumbered «Приложения» section and `#include`s
  the tool man pages (`aout`, `arh`, `ld`, `ar`, `nm`, `lorder`, `size`, `strip`, `show`,
  `as-man`, `emu-man`), the formal grammar (`syntax.typ`), and the object-file structure
  diagrams (`pict.typ`).
- **Advisor's review** — `review.typ` (отзыв), a standalone final page (no running
  header/footer).

## Conventions

- All prose is Russian and UTF-8; preserve the text verbatim (including original typos
  unless explicitly asked to fix them).
- Chapter and appendix files contain plain Typst markup and are `#include`d from
  `book.typ` / `apply.typ`. Files that use the man-page helpers or explicit headings start
  with `#import "man.typ": *`.
- `man.typ` provides the man-page helpers: `man-page(name, section)` (a tool-page title —
  unnumbered level-2 heading, own page, in the TOC) and `man-section(title)[body]` (a
  coloured run-in section header with its body indented).
- **Naming:** `as.typ` / `emu.typ` are the assembler / emulator *chapters*; the
  corresponding *man pages* are `as-man.typ` / `emu-man.typ` (renamed to avoid the clash).
- Code listings use Typst's built-in `c` highlighting; the BNF grammar is a plain
  monospace block and the structure diagrams are `#table`s. There is no assembler-listing
  content in the thesis, so no custom code syntax is defined.

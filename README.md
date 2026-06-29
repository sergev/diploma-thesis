# A Portable C Toolchain for the Elbrus-B / BESM-6

This repository holds the source of a 1989 MFTI (Moscow Institute of Physics and
Technology) diploma thesis by **S. V. Vakulenko**:

> *Разработка переносимой Си-ориентированной инструментальной системы программирования
> для ЭВМ Эльбрус-Б* — "Design of a portable, C-oriented programming toolchain for the
> Elbrus-B computer."

The thesis is written in Russian. It was originally typeset with troff/nroff and has been
converted to [Typst](https://typst.app) (see `book.typ`). This README summarizes its
content in English.

## Background

The **BESM-6** was, for roughly fifteen years, the leading Soviet computer. By the late
1980s it was succeeded by the **Elbrus-B**, a machine that preserved the BESM-6 line
while adding two more instruction modes:

- **Mode 1** — fully compatible with the BESM-6 (48-bit words, 32K-word address space).
- **Mode 2** — same instruction set, address space expanded to 128M words.
- **Mode 3** — 64-bit words, 128M-word address space, extended instruction set.

The Elbrus-B offered 64 MB of physical memory and roughly 5 MIPS. Its native operating
system (ДИСПАК, adapted from the BESM-6) was conceptually stuck in the late 1960s. To
modernize it, teams at the Novosibirsk branch of ITMiVT and at the Kurchatov Institute
(IAE) set out to port **DEMOS** — the Soviet UNIX clone — to the Elbrus-B. Porting UNIX
requires a portable C compiler, and building that compiler and its supporting toolchain
is the subject of this thesis.

## What was built

The work delivers a complete **cross-development system**, hosted on existing machines
(e.g. Labtam-32, SM-4) and targeting the Elbrus-B's word-oriented architecture. It uses
the *bootstrapping* method: a C compiler is brought up via a cross-compiler before it can
run natively.

Components produced for **both** Mode 1 (BESM-6) and Mode 3 (64-bit Elbrus-B):

- **C cross-compiler** — based on **S. C. Johnson's portable C compiler (pcc)**, the same
  front end used to port UNIX (4.3 BSD and System V) across architectures from the IBM
  PC/AT to the Cray-II. About 20% (~3000 lines) of the compiler was changed, mostly in
  the code generator.
- **Data representation, register allocation, and calling conventions** for each target
  mode — the non-trivial, partly heuristic part of retargeting pcc.
- **Object-file format** (`a.out`-style) and a **loader** (`ld`).
- **Assembler** (`as`) — rewritten essentially from scratch (~1500 lines).
- **Emulators** (`emu`) for Mode 1 and Mode 3, each able to trap and service UNIX system
  calls, used to debug the generated code on the host (~1500 lines each).
- **Librarian** (`ar`) and a **library file format**, plus object-file utilities
  **`nm`**, **`lorder`**, **`size`**, **`strip`**.
- A **disassembler** (`show`) for executable/object files, to ease debugging.
- **Runtime support**: a "library-on-account" (low-level runtime), C standard-library
  builds for both compilers, and a set of standard header files for the UNIX port.

A central thesis conclusion: retargeting pcc to a new architecture is feasible and much
of it is mechanical, but it **cannot be fully automated** from a formal machine
description — the code generator requires non-trivial, hand-crafted algorithms and
heuristics.

## Historical significance

According to the advisor's review (`review.typ`), this was among the **first portable C
compiler implementations in the USSR**. The intermediate BESM-6 cross-system (1986–1987)
enabled a full Version 7 UNIX port completed in autumn 1988, which in turn became the
base toolchain for the industrial 64-bit Elbrus-B effort.

## Repository contents

This repo contains only the **thesis document source** (Typst), not the toolchain's own
source code. The tool names above appear here as man-page-style appendices documenting
each program. The document was converted from its original troff/`-me` form to Typst.

| Files | Role |
|-------|------|
| `book.typ` | Master document — template setup, table of contents, and the `#include` order |
| `title-page.typ` | The Soviet title page |
| `results.typ` … `refer.typ` | The nine thesis chapters (Russian) |
| `apply.typ` + tool `*.typ` | «Приложения»: man pages for `ld`, `ar`, `as`, `emu`, …, via the `man.typ` helper |
| `syntax.typ`, `pict.typ` | Formal input-language grammar; object-file layout diagrams |
| `review.typ` | The advisor's review (отзыв), final page |
| `Makefile`, `CLAUDE.md` | Typst build rules; working guidance |

## Typesetting

Typeset with [Typst](https://typst.app):

```sh
make          # typst compile book.typ -> book.pdf
make watch    # live preview
```

The document uses the `@preview/bookly` template (auto-downloaded on first compile) and
the New Computer Modern / DejaVu Sans Mono fonts. See `CLAUDE.md` for the document
structure and conventions.

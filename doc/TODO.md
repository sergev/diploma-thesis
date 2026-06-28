# TODO — Convert the thesis from troff/-me to Typst

Sequential task list for rewriting the 1989 MFTI diploma thesis (Russian) from
troff/`-me` into **Typst**, using the bookly-based skeleton in `tmp/` as a starting
point. We execute one task at a time and check it off here.

## Decisions
- **Location:** Typst project at the **repo root** (`book.typ` + per-chapter `*.typ`
  alongside the troff sources; the `.typ` extension avoids name clashes).
- **Code blocks:** custom **BESM-6 assembler** syntax + theme (replacing the unrelated
  MLC `thesis.syntax`/`thesis.theme`); C struct listings use Typst's native `c`
  highlighting.
- **Fidelity:** **faithful reproduction** — recreate the 1989 title page, keep man-page
  section headers (ИМЯ / ФОРМАТ / ОПИСАНИЕ …), preserve `th.me` chapter order and the
  Russian text verbatim.
- **Encoding:** sources are already UTF-8 → no transcoding.

## Conversion mapping (reference for every chapter task)
| troff / -me | Typst |
|---|---|
| `.sh 1 "Заголовок."` | `= Заголовок` (bookly auto-numbers) |
| `.sh 2` / deeper | `==`, `===` |
| `.uh "X"` | unnumbered heading (`#heading(numbering: none)[X]`) |
| `.pp` / `.lp` | blank line between paragraphs |
| `.np` | numbered list `+ item` |
| `.-` | bullet `- item` |
| `.=` | bullet w/ alt marker (def-style `- ` / `/ term: …`) |
| `.ip "key" w` (man `.IP`) | term list `/ key: text` |
| `\fB…\fR`, `.b "X"` | `*X*` |
| `\fI…\fR` (tool/var names) | `_X_`, or `` `X` `` when it's a command token |
| `.ES L … .EE`, `.nf/.fi` | raw block ```` ```c ```` (structs) / ```` ```asm ```` (BESM-6) |
| man `.SH ИМЯ` | bold appendix sub-heading "ИМЯ" |
| `.TS/.TE` (pict.tbl) | `#table(...)` |
| `.CT`/`.cT` TOC diversions | drop — `#tableofcontents` (bookly) auto-builds |
| refer list | numbered list (no bib database) |

**Rule for all tasks:** preserve the Russian text byte-for-byte; only the markup
changes. After each task, `typst compile book.typ` must succeed.

---

## Phase A — Setup
- [x] **1. Scaffold at repo root.** Adapt `tmp/book.typ` + `tmp/Makefile` to the repo
  root; add build artifacts (`book.pdf`) to `.gitignore`; set `lang: "ru"`, a
  Cyrillic-capable font, and page geometry approximating the original (A4, ~16cm
  measure). Verify `typst` is installed and an empty document compiles (bookly
  auto-downloads). _Done: `book.typ` + placeholder `title-page.typ`, font = New Computer
  Modern (body) / DejaVu Sans Mono (code), `lang: ru`, A4; Typst targets added to
  `Makefile`; `book.pdf` gitignored. Compiles clean; Cyrillic verified in render._
- [x] **2. Russian title page** — convert `title.nr` → `title-page.typ`: the three
  institutes, author "Вакуленко С. В.", bold three-line title, hanging-indent advisor
  block, "Москва / 1989". Wire it as the bookly `title-page`. _Done: faithful Soviet
  title page (no header/footer bars or rules), `1fr` spacers distribute the four blocks
  down one A4 page; advisor names indented 2.5in via `#pad`. Renders clean; body
  unaffected._
- [ ] **3. BESM-6 syntax highlighting** — write `besm6.syntax` + `besm6.theme`
  (replacing the MLC files); register via `#set raw(...)`; pick the ```` ```asm ````
  tag; keep native `c` highlighting for the struct listings.

## Phase B — Body chapters (th.me order)
- [ ] **4.** `results.me` + `intro.me` → `results.typ`, `intro.typ`.
- [ ] **5.** `boot.me` → `boot.typ` (numbered `.np` paragraphs).
- [ ] **6.** `load.me` → `load.typ` (largest body chapter; convert alone).
- [ ] **7.** `as.me` + `emu.me` → `as.typ`, `emu.typ`.
- [ ] **8.** `ccom.me` → `ccom.typ` (large; convert alone).
- [ ] **9.** `concl.me` + `refer.me` → `concl.typ`, `refer.typ` (bibliography as a
  numbered list).

## Phase C — Appendices
- [ ] **10. Appendix scaffolding** — "Приложения" section divider (`.AP`) + a reusable
  `man-page` helper reproducing `.SH/.IP/.ES/.EE` semantics (Cyrillic section headers,
  term lists, code blocks) for use by all the tool pages.
- [ ] **11.** `aout.man` → appendix (large; dual BESM-6 / Эльбрус-Б C struct listings +
  IP lists).
- [ ] **12.** `ld.man` + `ar.man` + `nm.man`.
- [ ] **13.** `lorder.man` + `size.man` + `strip.man` + `show.man` + `as.man` +
  `emu.man`.
- [ ] **14.** `syntax.me` → formal grammar appendix (no-fill / no-hyphenation rules →
  raw or tight blocks).
- [ ] **15.** `pict.tbl` → Typst `#table()`s (object-file & archive structure diagrams +
  captions).

## Phase D — Finish
- [ ] **16. Assemble & verify** — set the `#include` order in `book.typ` to match
  `th.me`, enable `#tableofcontents`, cross-check chapter/appendix completeness against
  `th.me` / `apply.me`, run a full `typst compile`, then fix overflow/font/spacing
  issues by visual review against a `groff -me -t th.me` reference render.

## Verification
- **Per task:** `typst compile book.typ` succeeds with no errors; spot-check the
  affected pages in `book.pdf`.
- **Final:** every `.so` entry in `th.me` and `apply.me` has a corresponding converted
  `.typ`; the TOC lists all chapters + appendices; the Russian text matches the source;
  the render is compared side-by-side with the groff output of the original.

## Open points (settle as we go, not blocking)
- Font choice depends on what's installed locally (candidates: Libertinus / New Computer
  Modern for Cyrillic) — finalized in Task 1.
- Original page header `X(5) ОС ДЕМОС. Команды` (from `.TH`) — reproduce in Task 10 if it
  renders cleanly, otherwise omit.

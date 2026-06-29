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
- [x] **3. Code highlighting** — _Finding: the thesis has no assembler listings (only C
  struct listings in aout/arh; `as.me` is prose). Per decision, dropped the custom
  `besm6.syntax`/`besm6.theme` idea and use Typst's built-in `c` highlighting with its
  default light theme. Removed the dead `#set raw(...)` placeholder from `book.typ`;
  mono = DejaVu Sans Mono. Verified on a real `struct exec` listing with Russian
  comments — highlighted, clean, no tofu._

## Phase B — Body chapters (th.me order)
- [x] **4.** `results.me` + `intro.me` → `results.typ`, `intro.typ`. _Done: bold lead-ins
  (`*…*`), `.-` → bullet lists, tool names italic (`_nm_`…); wired into `book.typ` as
  `#include`s (replacing the `= Черновик` placeholder). Both chapters render correctly,
  Cyrillic crisp._
- [x] **5.** `boot.me` → `boot.typ` (numbered `.np` paragraphs). _Done: two independent
  `+` numbered lists (12 + 5 items, each restarting at 1, matching the prose references);
  tool names italic; «на самом себе» renders as Russian guillemets. Wired into `book.typ`;
  renders correctly._
- [x] **6.** `load.me` → `load.typ` (largest body chapter; convert alone). _Done: 7
  `==` subsections; `.np` → numbered lists (Загрузчик's blocks restart at 1); new pattern
  `.=`/`.-` (`.ba` indent) → Typst nested bullet lists (file-structure & library-file
  lists); tool names italic. Wired into `book.typ`; all subsections render correctly,
  nesting + numbering verified._
- [x] **7.** `as.me` + `emu.me` → `as.typ`, `emu.typ`. _Done: prose + one numbered list
  each (7 and 5 items); `\fIutc\fR` → italic. Wired into `book.typ`; both render
  correctly._
- [x] **8.** `ccom.me` → `ccom.typ` (large; convert alone). _Done: 7 `==` subsections;
  numbered/bullet lists; register section kept as `.pp` paragraphs; new `.(l` no-fill
  display → `#pad` indented block. Escaping handled: `#`→`\#` (directive list), `*`→`\*`
  (`int *`, `char *`, «*&»). Heavy inline C-type italics. Clean compile validates
  escaping; all rendered correctly._
- [x] **9.** `concl.me` + `refer.me` → `concl.typ`, `refer.typ` (bibliography as a
  numbered list). _Done: «Выводы» 4-item list with the `.(l` timings display nested in
  item 4; «Литература» 7-item numbered bibliography — leading-`-` publisher lines joined
  onto the preceding line so they stay inline (not parsed as sub-bullets). Renders
  correctly. **Phase B complete.**_

## Phase C — Appendices
- [x] **10. Appendix scaffolding** — "Приложения" section divider (`.AP`) + a reusable
  `man-page` helper reproducing `.SH/.IP/.ES/.EE` semantics (Cyrillic section headers,
  term lists, code blocks) for use by all the tool pages. _Done: `man.typ`
  (`man-page(name, section)`, `man-section(title)` + documented conventions) and
  `apply.typ` (unnumbered «Приложения» region via `#set heading(numbering: none)`). Chose
  custom unnumbered over bookly's lettered `appendix` env (faithful). Verified with a
  throwaway DEMO(9) page (since removed): title/sections/term-list/synopsis-raw/code all
  render correctly. Wired into `book.typ`._
- [x] **11.** `aout.man` → appendix (large; dual BESM-6 / Эльбрус-Б C struct listings +
  IP lists). _Done: `aout.typ` via man helpers — two ```c blocks (tabs/#defines/Russian
  comments intact), synopsis as inline raw, `.IP` → term lists, prose underscores escaped
  `\_` (n_value/a_flag/N_COMM…), troff backtick-quotes → inline-raw `-s` / guillemets.
  Each man file imports `man.typ`. Renders correctly, no overflow._
- [x] **12.** `arh.man` + `ld.man` + `ar.man` + `nm.man`. _Done: `arh` folded in (was
  omitted from the groupings) so appendix order matches apply.me. arh has a `struct ar_hdr`
  ```c block; ld/ar/nm are flag/key term lists. Escaping: prose underscores `\_`
  (`_econst…`, `ar_date`), `*` in file-path keys (`/lib/lib\*.a`, `/tmp/v\*`); quotes →
  guillemets. All render correctly with indented sections._
- [x] **13.** `lorder.man` + `size.man` + `strip.man` + `show.man` + `as.man` +
  `emu.man`. _Done: as.man/emu.man named `as-man.typ`/`emu-man.typ` (the as/emu chapter
  files already own `as.typ`/`emu.typ`). lorder's shell example → code block (backticks/
  `*`/`|` literal); emu's ~14 debugger keys escape `<`→`\<` `>`→`\>`; strip's `/tmp/s??????`
  literal; show's multiple letter term-lists. All render correctly. **All 11 man pages
  done.**_
- [x] **14.** `syntax.me` → formal grammar appendix (no-fill / no-hyphenation rules →
  raw or tight blocks). _Done: `syntax.typ` — unnumbered TOC heading; notation legend as a
  term list with monospace symbol keys; the ~62-production BNF as one monospace code block
  (every metacharacter / quoted terminal / `"\""` exact, source line breaks preserved → no
  overflow); the `.[` examples as code blocks; prose `"#"`→`"\#"`. Renders correctly._
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

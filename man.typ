// Helpers for the man-page-style appendices, faithful to the original troff
// `.man` macros (apply.me redefines .TH/.SH/.PP/.IP/.ES/.EE on top of -me).
//
// Each converted *.man → *.typ file must start with:  #import "man.typ": *
// (an #include does NOT inherit apply.typ's import).
//
// Conventions used by the converted *.man → *.typ files:
//   .TH N S            → #man-page("N", S)        tool-page title (own page, in TOC)
//   .SH "T"            → #man-section("T")         bold run-in header (ИМЯ, ФОРМАТ, …)
//   .PP / .LP          → blank line (paragraph)
//   .IP "key" w        → term list `/ key: desc`   (escape \* \< \> in the key)
//   .ES L … .EE        → ```c fenced block         (Russian comments OK; #, <> literal)
//   ФОРМАТ synopsis    → inline raw `…`            (avoids # / <> being parsed by Typst)
//   ДОПОЛНИТЕЛЬНЫЕ ССЫЛКИ → plain text line

// .TH name section — tool-page title. Unnumbered level-2 heading "NAME(section)";
// starts on its own page and is listed in the table of contents.
#let man-page(name, section) = {
  pagebreak(weak: true)
  heading(level: 2, numbering: none, outlined: true)[#name\(#section\)]
}

// .SH title — bold run-in section header. Deliberately NOT a heading, so it gets
// neither a number nor a TOC entry (matching the original .SH).
#let man-section(title) = block(above: 1.1em, below: 0.55em, breakable: false)[
  #strong(title)
]

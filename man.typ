// Helpers for the man-page-style appendices, faithful to the original troff
// `.man` macros (apply.me redefines .TH/.SH/.PP/.IP/.ES/.EE on top of -me).
//
// Each converted *.man → *.typ file must start with:  #import "man.typ": *
// (an #include does NOT inherit apply.typ's import).
//
// Conventions used by the converted *.man → *.typ files:
//   .TH N S            → #man-page("N", S)        tool-page title (own page, in TOC)
//   .SH "T"            → #man-section("T")[ … ]    bold header + indented section body
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

// Indent of a section body relative to its header (the original .SH did `.ba 0.5i`).
#let man-indent = 5em

// .SH title — bold run-in header (NOT a heading, so no number/TOC entry) followed by
// the section body, indented under the header in the classic man-page style.
#let man-section(title, body) = {
  block(above: 1.1em, below: 0.55em, breakable: false)[#strong(title)]
  pad(left: man-indent)[#body]
}

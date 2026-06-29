#show link: set text(fill: blue)

#import "@preview/bookly:0.1.0": *
#import "title-page.typ": thesis-title-page

// Code listings use Typst's built-in `c` highlighting (the thesis has no
// assembler listings — only C struct definitions in the a.out/ar appendices).
// Russian body text in New Computer Modern; code in a Cyrillic-capable mono.
#set text(lang: "ru", font: "New Computer Modern")
#show raw: set text(font: "DejaVu Sans Mono")

#show raw.where(block: true): it => block(
  stroke: 0.5pt + luma(180),
  radius: 4pt,
  inset: 1em,
  width: 100%,
  it,
)

#show: book.with(
  title: "Разработка переносимой Си-ориентированной инструментальной системы программирования для ЭВМ Эльбрус-Б",
  author: "Вакуленко С. В.",
  book-config: (
    theme: "fancy", // or classic, or modern
    lang: "ru",
    title-page: thesis-title-page,
  )
)

#show: main-matter
#set page(paper: "a4")

// TODO Task 16: enable table of contents
// #tableofcontents

// TODO Task 16: replace placeholder with real #include order per th.me
= Черновик

TODO

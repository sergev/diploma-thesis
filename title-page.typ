// TODO Task 2: replace this placeholder with the real Soviet title page
// converted from title.nr (institutes, author, bold title, advisors, Москва 1989).
#import "@preview/bookly:0.1.0": *

#let thesis-title-page = context {
  let primary = states.colors.get().primary

  let header = box(fill: primary, width: 100%, inset: 1em)[
    #set align(center + horizon)
    #text(fill: white, size: 1.5em)[*MLA Assembly Programming*]
  ]

  let footer = box(fill: primary, width: 100%, inset: 1em)[
    #set align(center + horizon)
    #text(fill: white, size: 1.5em)[*Serge Vakulenko*]
  ]

  set page(
    paper: "a4",
    header: header,
    footer: footer,
    margin: (left: 0em, right: 0em, top: 6em, bottom: 6em),
  )

  align(horizon)[
    #move(dx: 2em)[
      #line(stroke: 1.5pt + primary, length: 90%)
      #v(1em)
    ]
    #move(dx: 4em)[
      #text(size: 3em)[*#states.title.get()*]
      #v(0.5em)
      #text(size: 2em)[Assembly Programming]
      #v(1em)
      #text(size: 1.5em)[Edition 0.1]
      // #text(size: 1.5em)[#states.author.get()]
    ]
    #move(dx: 2em)[
      #v(1em)
      #line(stroke: 1.5pt + primary, length: 90%)
    ]
  ]

  place(bottom + left, dx: 2em, dy: -2em)[
    #text(size: 0.85em)[
      #sym.copyright 1989 Serge Vakulenko
    ]
  ]
}

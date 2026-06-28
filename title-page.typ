// Soviet diploma title page, faithfully reproduced from the original troff
// source (title.nr). Plain academic layout: centered institutes at the top,
// author and bold title in the upper middle, advisors lower, «Москва 1989» at
// the bottom. No header/footer bars or decorative rules.

#let thesis-title-page = {
  set page(
    paper: "a4",
    header: none,
    footer: none,
    margin: (x: 2.5cm, top: 2.5cm, bottom: 2cm),
  )

  // Institutes (centered, at the top).
  align(center)[
    Московский ордена Трудового Красного Знамени \
    физико-технический институт \
    Ордена Ленина и ордена Октябрьской Революции \
    институт атомной энергии им. И. В. Курчатова \
    Ордена Ленина институт прикладной математики \
    Академии наук СССР
  ]

  v(1fr)

  // Author, title and kind of work (centered, upper middle).
  align(center)[
    Вакуленко С. В.

    #v(1em)
    #text(weight: "bold")[
      Разработка переносимой Си-ориентированной \
      инструментальной системы программирования \
      для ЭВМ Эльбрус-Б.
    ]

    #v(1em)
    Дипломная работа.
  ]

  v(1fr)

  // Scientific advisors: label flush-left, names indented (mimics .in 2.5i / .ti -2.5i).
  block(width: 100%)[
    Научные руководители:
    #pad(left: 2.5in)[
      Платонов Александр Константинович, \
      доктор физико-математических наук, \
      ИПМ АН СССР

      #v(0.5em)
      Пасынков Игорь Григорьевич, \
      кандидат физико-математических наук, \
      ИАЭ им. И. В. Курчатова
    ]
  ]

  v(1fr)

  // City and year, at the bottom.
  align(center)[
    Москва \
    1989
  ]
}

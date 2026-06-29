#pagebreak(weak: true)
#heading(level: 2, numbering: none, outlined: true)[Рисунки.]

// Undo bookly's coloured/bold header-row styling — these diagrams have no header row.
#show table.cell.where(y: 0): set text(fill: black, weight: "regular")

#v(1em)

// Структура файла a.out (allbox, одна колонка).
#align(center, table(
  columns: 1,
  stroke: 0.6pt,
  fill: none,
  align: center,
  inset: (x: 1.2em, y: 0.5em),
  [заголовок файла],
  [сегмент .const],
  [сегмент .text],
  [сегмент .data],
  [информация о настройке],
  [таблица символов],
))
#align(center)[Структура файла a.out.]

#v(1.5em)

// Структура информации о настройке для БЭСМ-6 (box, c c c|c c c|c).
#align(center, table(
  columns: 7,
  stroke: none,
  fill: none,
  align: center + horizon,
  inset: (x: 0.8em, y: 0.5em),
  table.hline(y: 0, stroke: 0.6pt),
  table.hline(y: 1, stroke: 0.6pt),
  table.hline(y: 2, stroke: 0.6pt),
  table.vline(x: 0, stroke: 0.6pt),
  table.vline(x: 3, stroke: 0.6pt),
  table.vline(x: 6, stroke: 0.6pt),
  table.vline(x: 7, stroke: 0.6pt),
  [24], [], [5], [4], [], [2], [1],
  table.cell(colspan: 3)[ссылка на таблицу \ символов], table.cell(colspan: 3)[M], [X],
))
#align(center)[Структура информации о настройке для БЭСМ-6.]

#v(1.5em)

// Структура информации о настройке для Эльбрус-Б (box, c c c|c c c|c c c).
#align(center, table(
  columns: 9,
  stroke: none,
  fill: none,
  align: center + horizon,
  inset: (x: 0.8em, y: 0.5em),
  table.hline(y: 0, stroke: 0.6pt),
  table.hline(y: 1, stroke: 0.6pt),
  table.hline(y: 2, stroke: 0.6pt),
  table.vline(x: 0, stroke: 0.6pt),
  table.vline(x: 3, stroke: 0.6pt),
  table.vline(x: 6, stroke: 0.6pt),
  table.vline(x: 9, stroke: 0.6pt),
  [32], [], [7], [6], [], [4], [3], [], [1],
  table.cell(colspan: 3)[ссылка на таблицу \ символов], table.cell(colspan: 3)[M], table.cell(colspan: 3)[X],
))
#align(center)[Структура информации о настройке для Эльбрус-Б.]

#pagebreak()

// Структура библиотечного (архивного) файла (allbox, одна колонка).
#align(center, table(
  columns: 1,
  stroke: 0.6pt,
  fill: none,
  align: center,
  inset: (x: 1.2em, y: 0.5em),
  [признак архивного файла],
  [заголовок файла 1],
  [файл 1],
  [заголовок файла 2],
  [файл 2],
  [...],
  [заголовок файла N],
  [файл N],
))
#align(center)[Структура библиотечного (архивного) файла.]

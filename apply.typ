#import "man.typ": *

// Appendices region: unnumbered headings (the «Приложения» divider is an
// unnumbered chapter; each tool page an unnumbered section titled NAME(section)).
#set heading(numbering: none)

= Приложения

// Man pages and reference sections are included here, in apply.me order:
//   aout, arh, ld, ar, nm, lorder, size, strip, show, as, emu  (Tasks 11–13)
//   syntax (Task 14), pict tables (Task 15)
#include "aout.typ"
#include "arh.typ"
#include "ld.typ"
#include "ar.typ"
#include "nm.typ"
#include "lorder.typ"
#include "size.typ"
#include "strip.typ"
#include "show.typ"
#include "as-man.typ"
#include "emu-man.typ"

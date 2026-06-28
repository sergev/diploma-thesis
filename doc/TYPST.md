# Typst Tutorial for Writers

Typst is a modern typesetting system — think of it as a smarter, programmable alternative to Word or LaTeX. You write plain text with a few special symbols, and Typst turns it into a beautifully formatted PDF.

This tutorial explains every feature used in the `book.typ` article, starting from the simplest and building toward more advanced ones.

---

## 1. Plain Text

Just type. Paragraphs are separated by a blank line, exactly like Markdown.

```typst
This is the first paragraph.

This is the second paragraph.
```

---

## 2. Headings

Headings are created with `=` signs, one per level.

```typst
= Chapter Title

== Section Title

=== Subsection Title
```

One `=` is a top-level chapter. Two `==` is a section inside that chapter. Three `===` is a subsection, and so on. Typst numbers them and uses them to build the table of contents automatically.

---

## 3. Bold and Italic Text

Wrap text in `*asterisks*` for **bold** and `_underscores_` for *italic*.

```typst
This word is *bold* and this one is _italic_.
```

---

## 4. Inline Code

Surround a word or short phrase with backtick characters to show it as monospace code:

```typst
Use the `add` instruction to add two tensors.
```

This renders as: Use the `add` instruction to add two tensors.

---

## 5. Code Blocks

For multi-line code, use triple backticks. You can name the language right after the opening backticks, and Typst will apply syntax highlighting.

````typst
```bash
$ git clone git@bitbucket.org:sima-ai/mla-toolchain.git
$ cd mla-toolchain/build
$ make
```
````

````typst
```asm
matrix t0 int8 0:0:0 1 16
add t2 t0 t1
stop
```
````

The language name (`bash`, `asm`, `python`, etc.) is optional but recommended.

---

## 6. Bullet Lists

Start a line with `- ` (a dash followed by a space):

```typst
- First item
- Second item
- Third item
```

For a nested list, indent with two spaces:

```typst
- Top level
  - Nested item
  - Another nested item
```

---

## 7. Links

Use `#link("url")[display text]` to create a hyperlink:

```typst
See the #link("https://example.com/docs")[documentation] for details.
```

The URL goes inside the quotes; the text the reader sees goes inside the square brackets.

---

## 8. Special Symbols

Typst has named symbols you can insert with `#sym.name`:

```typst
#sym.copyright 2026 SiMa.ai
```

This inserts the © symbol. Other common symbols include `#sym.trademark`, `#sym.arrow.r`, `#sym.infinity`, and many more. Search the Typst documentation for the full list.

---

## 9. The `#` Sign — Commands vs. Content

Anything starting with `#` is a **command** (Typst calls them "functions" or "expressions"). Plain text without `#` is just content. Understanding this distinction is the key to Typst.

```typst
This is plain text.

#pagebreak()   // this is a command — it inserts a page break
```

---

## 10. Functions and Arguments

Typst functions look like: `#functionName(arguments)[content]`

- Arguments go inside `( )`, separated by commas.
- Content the function should format goes inside `[ ]`.
- Some functions take only arguments, some take only content, some take both.

```typst
#text(size: 2em, fill: red)[This text is large and red.]
```

Here `size: 2em` and `fill: red` are named arguments. `em` is a unit meaning "relative to the current font size" — `1em` is normal size, `2em` is double.

---

## 11. `#v()` — Vertical Space

Insert blank vertical space between elements:

```typst
First line.
#v(1em)
Second line, with extra space above it.
```

`1em` is roughly one line height. Use larger values like `2em` or `3em` for more space.

---

## 12. `#line()` — Horizontal Rules

Draw a horizontal line:

```typst
#line(length: 90%)
```

You can control the thickness and color:

```typst
#line(stroke: 1.5pt + blue, length: 90%)
```

`1.5pt + blue` means "1.5 point thick, blue color". The `+` combines thickness and color into a stroke style.

---

## 13. `#box()` — A Rectangular Container

A box wraps content in a rectangle you can style:

```typst
#box(fill: navy, width: 100%, inset: 1em)[
  Some content inside the box.
]
```

- `fill:` sets the background color.
- `width:` sets how wide the box is (`100%` means full page width).
- `inset:` adds padding (space) between the box edge and its content.

---

## 14. `#align()` — Alignment

Control where content sits horizontally and vertically:

```typst
#align(center)[This text is centered.]

#align(right)[This text is right-aligned.]
```

For both horizontal and vertical alignment at once, combine them with `+`:

```typst
#align(center + horizon)[Centered on both axes.]
```

`horizon` means vertically centered. This is mainly used on a full page to place something in the middle.

---

## 15. `#set` — Changing Defaults

`#set` changes the default behavior of a function for everything that follows it in the same scope. You do not need to repeat the argument every time.

```typst
#set text(size: 12pt, font: "Georgia")

Everything after this line uses 12pt Georgia.
```

```typst
#set align(center)

All paragraphs after this are centered.
```

`#set` is scoped — if you use it inside `[ ]` brackets, it only applies inside those brackets.

---

## 16. `#move()` — Shifting Content

`#move` shifts content by an offset without affecting surrounding layout:

```typst
#move(dx: 2em)[
  This content is shifted 2em to the right.
]
```

`dx` is horizontal offset, `dy` is vertical offset. Positive `dx` moves right; positive `dy` moves down.

---

## 17. `#place()` — Absolute Positioning

`#place` pins content at a specific location on the page, outside the normal text flow:

```typst
#place(bottom + left, dx: 2em, dy: -2em)[
  This appears near the bottom-left corner of the page.
]
```

The first argument is the anchor point — combinations of `top`, `bottom`, `left`, `right`, `center`, `horizon`. The `dx` and `dy` arguments fine-tune the position from that anchor.

---

## 18. `#set page()` — Page Setup

Configure the page size, margins, headers, and footers:

```typst
#set page(
  paper: "us-letter",
  margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
)
```

Common paper sizes: `"us-letter"`, `"a4"`. Margins can be set for each side individually or as a single value for all sides.

To add a header and footer, create them as content first, then pass them:

```typst
#let my-header = [Chapter One]
#let my-footer = [Page #counter(page).display()]

#set page(header: my-header, footer: my-footer)
```

---

## 19. `#let` — Defining Variables and Functions

`#let` assigns a name to content or a function so you can reuse it:

```typst
#let company-name = [SiMa.ai]

Our product is made by #company-name.
```

You can also define a reusable block of content:

```typst
#let warning-box = box(fill: yellow, inset: 0.5em)[Warning!]

#warning-box Please read carefully.
```

---

## 20. `#show` — Applying a Template

`#show: some-function` passes the entire rest of the document through a function. This is how templates and packages work:

```typst
#show: book.with(
  title: "My Book Title",
  author: "Jane Smith",
)
```

Everything written after this line is formatted by the `book` template. The `.with(...)` syntax pre-fills the template's arguments.

Multiple `#show` rules can be chained. Each one wraps the document further:

```typst
#show: book.with(title: "My Book", author: "Jane")
#show: main-matter
```

---

## 21. `#import` — Using Packages

Typst has a package registry. Import a package at the top of your file:

```typst
#import "@preview/bookly:0.1.0": *
```

- `@preview/bookly` is the package name.
- `0.1.0` is the version.
- `: *` imports everything the package exports (all its functions and variables).

After this line, you can use anything the package provides, such as `book`, `main-matter`, `tableofcontents`, and `states`.

---

## 22. `#tableofcontents` — Automatic Table of Contents

After importing the bookly package, insert a table of contents with:

```typst
#tableofcontents
```

Typst builds it automatically from all your `=` headings. No manual updating needed.

---

## 23. `context` — Reading Document State

Some values — like the current page number or theme color — are not known until Typst finishes laying out the document. The `context` keyword lets you access these dynamic values:

```typst
#let my-thing = context {
  let current-color = states.colors.get().primary
  text(fill: current-color)[Styled with the theme color]
}
```

You will rarely need to write `context` yourself. It is mainly used inside package code and advanced custom templates. When you see it, it means "wait until the full document is ready, then read this value."

---

## 24. Colors

Typst has built-in named colors: `red`, `blue`, `green`, `black`, `white`, `gray`, `navy`, `orange`, etc.

You can also define colors with RGB values:

```typst
#let my-blue = rgb("#1a73e8")
#text(fill: my-blue)[Colored text]
```

Colors are used in `fill:` (backgrounds), `stroke:` (borders and lines), and `text(fill:...)`.

---

## 25. Units

Typst supports several measurement units:

| Unit | Meaning |
|------|---------|
| `pt` | Points (1/72 of an inch) — good for font sizes |
| `cm` | Centimeters |
| `mm` | Millimeters |
| `in` | Inches |
| `em` | Relative to current font size — `1em` = current size, `2em` = double |
| `%`  | Percentage of the containing element's width or height |

Use `em` when you want things to scale with the text size. Use `cm`/`in` for fixed physical dimensions.

---

## 26. Content Blocks `[ ]`

Square brackets hold formatted content in Typst. You can have multi-line content blocks:

```typst
#box(fill: silver)[
  This is the first line.

  This is a second paragraph inside the box.
]
```

Content blocks can contain any Typst markup — headings, lists, code, other functions.

---

## Putting It All Together: A Simple Document

Here is a minimal document that uses the most common features:

```typst
#import "@preview/bookly:0.1.0": *

#show: book.with(
  title: "My Guide",
  author: "Jane Smith",
)

#show: main-matter
#set page(paper: "a4")

#tableofcontents

= Introduction

Welcome to this guide. See the #link("https://example.com")[website] for more.

== Getting Started

Install the tools:

```bash
$ brew install my-tool
```

Key concepts:

- First concept
- Second concept
- Third concept: use `special-flag` to enable it.
```

---

## Quick Reference

| What you want | Typst syntax |
|---|---|
| Chapter heading | `= Title` |
| Section heading | `== Title` |
| Bold text | `*bold*` |
| Italic text | `_italic_` |
| Inline code | `` `code` `` |
| Code block | ```` ```lang ```` … ```` ``` ```` |
| Bullet list item | `- item` |
| Hyperlink | `#link("url")[text]` |
| Copyright symbol | `#sym.copyright` |
| Extra vertical space | `#v(1em)` |
| Horizontal rule | `#line(length: 100%)` |
| Page break | `#pagebreak()` |
| Centered text | `#align(center)[text]` |
| Import package | `#import "@preview/name:version": *` |
| Table of contents | `#tableofcontents` |

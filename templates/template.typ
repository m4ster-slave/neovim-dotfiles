#let topic = "TITEL"
#let date = datetime.today().display()
#let author = "Lukas Weger"

// Page setup
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  header: [
    #set text(9pt)
    #grid(
      columns: (1fr, 1fr),
      align(left)[#author],
      align(right)[#date]
    )
    #line(length: 100%, stroke: 0.5pt)
  ],
  footer: context [
    #line(length: 100%, stroke: 0.5pt)
    #set text(9pt)
    #align(center)[#counter(page).display("1 / 1", both: true)]
  ]
)

// Text settings
#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "de"
)

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.2em
)

// Heading styles
#show heading.where(level: 1): it => [
  #set text(18pt, weight: "bold")
  #block(
    fill: rgb("#f5f5f5"),
    width: 100%,
    inset: 12pt,
    radius: 4pt,
    [#it.body]
  )
  #v(0.5em)
]

#show heading.where(level: 2): it => [
  #set text(14pt, weight: "bold", fill: rgb("#2d3748"))
  #v(0.3em)
  #it.body
  #v(0.2em)
  #line(length: 100%, stroke: 1pt + rgb("#4a5568"))
  #v(0.3em)
]

#show heading.where(level: 3): it => [
  #set text(12pt, weight: "semibold", fill: rgb("#4a5568"))
  #v(0.2em)
  #it.body
  #v(0.2em)
]

#show heading.where(level: 4): it => [
  #set text(11pt, weight: "semibold", fill: rgb("#718096"))
  #v(0.15em)
  #it.body
  #v(0.15em)
]

// Custom boxes for important information
#let definition(term, content) = [
  #block(
    stroke: (left: 3pt + rgb("#c17817")),
    width: 100%,
    inset: (left: 12pt, rest: 8pt),
  )[
    #text(weight: "bold", fill: rgb("#8b5a0a"))[Definition: #term] \
    #content
  ]
]

#let theorem(name, content) = [
  #block(
    stroke: (left: 3pt + rgb("#2f7c4f")),
    width: 100%,
    inset: (left: 12pt, rest: 8pt),
  )[
    #text(weight: "bold", fill: rgb("#1f5938"))[Theorem: #name] \
    #content
  ]
]

#let example(content) = [
  #block(
    stroke: (left: 3pt + rgb("#7c5295")),
    width: 100%,
    inset: (left: 12pt, rest: 8pt),
  )[
    #text(weight: "bold", fill: rgb("#5a3a6f"))[Beispiel] \
    #content
  ]
]

#let note(content) = [
  #block(
    stroke: (left: 3pt + rgb("#3a72a8")),
    width: 100%,
    inset: (left: 12pt, rest: 8pt),
  )[
    #text(weight: "bold", fill: rgb("#2a5278"))[Wichtig:] #content
  ]
]

// Title
#align(center)[
  #text(22pt, weight: "bold")[#topic]
  #v(0.3em)
  #text(12pt, style: "italic")[#author]
]

#v(1em)

// ========================================================================

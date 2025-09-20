#set document(
  title: [Template],
  author: "Lukas Weger",
)

#set page(
  numbering: "I",
  paper: "a4",
  header: grid(
    columns: 2,
    rows: 1,
    gutter: 450pt,
    [#align(left)[#text(size: 10pt, "Lukas Weger")]], 
    [#align(right)[#text(size: 10pt, datetime.today().display())]]
  ),
  margin: (x: 24pt, y: auto),
)

#set text(slashed-zero: true, ligatures: true)

// Heading 1 
#show heading.where(level: 1): it => [
  #set align(center)
  #text(size: 21pt, (it.body))
]

// Heading 2 
#show heading.where(level: 2): it => {
  text(size: 14pt, it.body)
  v(-14pt)
  line(length: 100%, stroke: 1pt)
}
